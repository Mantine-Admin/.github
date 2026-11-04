# .github

Organization-wide defaults, governance and reusable workflows for [Mantine Admin](https://github.com/Mantine-Admin).

Community health files here apply to every repository of the organization that doesn't define its own.
Everything in this repository is risk class **R3**: changes require the owner's approval.

## Contents

| Path | Purpose |
| --- | --- |
| [`profile/README.md`](profile/README.md) | Organization home page |
| [`CONTRIBUTING.md`](CONTRIBUTING.md), [`SUPPORT.md`](SUPPORT.md) | How to contribute and get help |
| [`GOVERNANCE.md`](GOVERNANCE.md) | Roles, risk classes R0–R3, decision making |
| [`AI_POLICY.md`](AI_POLICY.md) | Rules for AI-assisted contributions and for the organization's agents |
| [`SECURITY.md`](SECURITY.md) | Private vulnerability reporting |
| [`CODE_OF_CONDUCT.md`](CODE_OF_CONDUCT.md) | Contributor Covenant 3.0 |
| [`.github/ISSUE_TEMPLATE/`](.github/ISSUE_TEMPLATE) | Default issue forms (bug, docs, task); ideas and questions go to Discussions |
| [`.github/pull_request_template.md`](.github/pull_request_template.md) | Default pull request template |
| [`.github/workflows/reusable-quality.yml`](.github/workflows/reusable-quality.yml) | Reusable quality gate: gitleaks, lint, typecheck, test, build |
| [`.github/workflows/reusable-workflow-lint.yml`](.github/workflows/reusable-workflow-lint.yml) | Reusable workflow linter: actionlint and zizmor |
| [`workflow-templates/`](workflow-templates) | "Mantine Admin CI" starter workflow, shown in every repository's Actions tab |
| [`rulesets/`](rulesets) | Organization rulesets, as code |
| [`scripts/apply-rulesets.sh`](scripts/apply-rulesets.sh) | Plans and applies the rulesets through the GitHub API |

## Applying the rulesets

```sh
gh auth refresh -h github.com -s admin:org
scripts/apply-rulesets.sh           # plan
scripts/apply-rulesets.sh --apply   # apply
```
