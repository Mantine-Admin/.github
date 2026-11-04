#!/usr/bin/env bash
# Apply organization rulesets from rulesets/*.json (the source of truth).
#
# Usage:
#   scripts/apply-rulesets.sh             # show the plan (dry run, default)
#   scripts/apply-rulesets.sh --apply     # create or update the rulesets
#
# Env:
#   ORG   GitHub organization (default: Mantine-Admin)
#
# Requires: gh (authenticated as an org owner, scope admin:org), jq.
# Rulesets are matched by name. Rulesets that exist in the org but not in
# rulesets/ are reported, never deleted.

set -euo pipefail

ORG="${ORG:-Mantine-Admin}"
MODE="plan"
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
RULESETS_DIR="${ROOT_DIR}/rulesets"

case "${1:-}" in
  --apply) MODE="apply" ;;
  ""|--dry-run) MODE="plan" ;;
  -h|--help) sed -n '2,14p' "$0"; exit 0 ;;
  *) echo "Unknown option: $1" >&2; exit 2 ;;
esac

for cmd in gh jq; do
  command -v "$cmd" >/dev/null || { echo "Missing dependency: $cmd" >&2; exit 1; }
done

# Keep only the fields we manage, sorted, to compare local and remote.
normalize() {
  jq -S '{name, target, enforcement, conditions, bypass_actors: (.bypass_actors // [] | sort_by(.actor_type, .actor_id)), rules: (.rules | sort_by(.type))}'
}

existing="$(gh api --paginate "orgs/${ORG}/rulesets" --jq '.[] | {id, name}' | jq -s '.')"
local_names=()
changes=0

shopt -s nullglob
files=("${RULESETS_DIR}"/*.json)
[ "${#files[@]}" -gt 0 ] || { echo "No ruleset found in ${RULESETS_DIR}" >&2; exit 1; }

for file in "${files[@]}"; do
  jq -e '.name and .target and .enforcement and .rules' "$file" >/dev/null \
    || { echo "Invalid ruleset: $file" >&2; exit 1; }
  name="$(jq -r '.name' "$file")"
  local_names+=("$name")
  id="$(jq -r --arg n "$name" '.[] | select(.name == $n) | .id' <<<"$existing")"

  if [ -z "$id" ]; then
    echo "+ create  ${name}  (${file#"${ROOT_DIR}"/})"
    changes=$((changes + 1))
    if [ "$MODE" = "apply" ]; then
      gh api --method POST "orgs/${ORG}/rulesets" --input "$file" --jq '"  created id \(.id)"'
    fi
    continue
  fi

  wanted="$(normalize <"$file")"
  # GitHub returns default values for parameters we don't set: compare only the keys we manage.
  remote="$(gh api "orgs/${ORG}/rulesets/${id}" | normalize | jq -S --argjson w "$wanted" '
    .rules |= map(
      . as $r
      | ($w.rules | map(select(.type == $r.type)) | first) as $wr
      | if ($wr | has("parameters"))
        then .parameters |= with_entries(select(.key as $k | $wr.parameters | has($k)))
        else del(.parameters) end
    )')"
  if [ "$remote" = "$wanted" ]; then
    echo "= ok      ${name}  (id ${id})"
    continue
  fi

  echo "~ update  ${name}  (id ${id})"
  changes=$((changes + 1))
  diff -u <(echo "$remote") <(echo "$wanted") --label "github:${name}" --label "local:${name}" | sed 's/^/    /' || true
  if [ "$MODE" = "apply" ]; then
    gh api --method PUT "orgs/${ORG}/rulesets/${id}" --input "$file" --jq '"  updated id \(.id)"'
  fi
done

# Report rulesets that exist on GitHub but not in this repository (drift).
while IFS= read -r remote_name; do
  [ -z "$remote_name" ] && continue
  found=false
  for n in "${local_names[@]}"; do [ "$n" = "$remote_name" ] && found=true; done
  if [ "$found" = false ]; then
    echo "! drift   ${remote_name}  exists on GitHub but not in rulesets/ (not deleted)"
  fi
done < <(jq -r '.[].name' <<<"$existing")

if [ "$MODE" = "plan" ]; then
  echo
  echo "${changes} change(s) planned. Run with --apply to apply them."
fi
