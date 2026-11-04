# Governance

Mantine Admin is run by a small group of human maintainers and a set of AI agents.
Agents do most of the routine work. **Deterministic rules and humans decide what gets merged.**

## Principles

1. **Rules decide, AI advises.** CI, rulesets, risk classes and protected paths are deterministic.
   AI reviews are signals; they never count as approvals.
2. **Separate identities.** The identity that writes code can't approve or merge it.
3. **Every new commit invalidates previous approvals.**
4. **Policy as code.** Org rulesets live in [`rulesets/`](rulesets) and are applied through the API,
   never edited by hand in the UI.
5. **Measure before automating.** Automation (such as auto-merge) is enabled per risk class,
   only after a shadow period shows it is safe.
6. **No trust for external code.** No `pull_request_target` with untrusted code, no secrets
   exposed to forks, no auto-merge for external contributions.

## Roles

| Role | Who | Can |
| --- | --- | --- |
| **Owner** | [@toofff](https://github.com/toofff) | Everything. Final say on R3 changes, releases, security and governance. |
| **Maintainer** | Humans listed in each repository's `CODEOWNERS` | Review and approve PRs in their area, triage issues, steer the roadmap. |
| **Coding agent** | Bot identities (Claude Code, Codex, Gemini...) | Open PRs from issues, push to their own branches, answer review comments. Can't approve or merge. |
| **Reviewer agent** | Bot identities | Comment on PRs. Comments only, never approvals. |
| **Merge controller** | A dedicated GitHub App | Merge PRs whose risk class allows automation once all checks pass. Nothing else. |
| **Contributor** | Anyone | Open issues, discussions and PRs, following [CONTRIBUTING.md](CONTRIBUTING.md). |

## Risk classes

Every pull request gets a risk class, computed from the paths it changes and from
deterministic signals (for example, a public API diff). The highest matching class wins.

| Class | Typical changes | Merge requirement |
| --- | --- | --- |
| **R0** | Docs, comments, tests only, internal tooling that isn't published | Checks pass. Auto-merge eligible after the shadow period. |
| **R1** | Internal implementation, no public API change; dependency patch/minor updates | Checks pass + maintainer approval. Auto-merge eligible later. |
| **R2** | Public API change, new runtime dependency, build or bundling config | Checks pass + maintainer approval. Never auto-merged. |
| **R3** | `.github/`, workflows, rulesets, `CODEOWNERS`, `AGENTS.md`, release and publishing config, security fixes, governance | Owner approval only. Agents may propose, never decide. |

Until the shadow period ends, **every class requires human approval**.

## Decision making

- **Day-to-day changes**: through pull requests and reviews.
- **Significant changes** (new package, public API design, architecture): an RFC in
  [Discussions](https://github.com/orgs/Mantine-Admin/discussions), then an Architecture Decision Record (ADR)
  in the repository. Maintainers reach consensus; the owner breaks ties.
- **Governance changes**: a pull request to this repository, approved by the owner.

## Becoming a maintainer

Contributors who make sustained, high-quality contributions may be invited by the owner.
Maintainers inactive for 6 months may be moved to emeritus status.
