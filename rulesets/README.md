# Organization rulesets

These JSON files are the **source of truth** for the organization rulesets.
Never edit rulesets in the GitHub UI: change the JSON here through a pull request,
then apply it with [`scripts/apply-rulesets.sh`](../scripts/apply-rulesets.sh).

| File | Applies to | What it enforces |
| --- | --- | --- |
| `default-branch.json` | Default branch of every repository | PR required, 1 approval, code owner review, stale approvals dismissed, last push approved by someone else, threads resolved, squash only, linear history, no force-push, no deletion |
| `required-checks-governance.json` | `.github` | Checks `validate` and `workflow-lint / lint` |
| `required-checks-node.json` | `mantine-admin` | Checks `quality / quality` and `workflow-lint / lint` |
| `tags.json` | All tags of every repository | Tags can't be moved or deleted |

## Notes

- **Bypass**: only organization owners (`OrganizationAdmin`), and only through a pull request
  for branches. Agents and the merge controller never bypass.
- **Check names** come from reusable workflows: `<caller job id> / <reusable job name>`.
  Keep the caller job ids `quality` and `workflow-lint` from the workflow template, or the checks will never match.
- **Required checks must always run.** Never put `paths` filters on a workflow that provides a required check;
  skip work inside the job instead.
- `integration_id: 15368` is GitHub Actions: a status with the same name from another app doesn't satisfy the check.
- **Add a repository** to a required-checks file when its CI is in place, not before:
  a required check that never runs blocks every PR.
