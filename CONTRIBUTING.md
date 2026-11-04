# Contributing to Mantine Admin

Thanks for your interest in Mantine Admin! This guide applies to every repository
in the organization unless a repository provides its own `CONTRIBUTING.md`.

## Before you start

- **Questions and feature requests** go to [Discussions](https://github.com/orgs/Mantine-Admin/discussions), not issues.
- **Bugs** go to issues, with a minimal reproduction. Issues without one may be closed.
- **Security issues** must never be reported publicly. See [SECURITY.md](SECURITY.md).
- **Larger changes** (new feature, public API change, new dependency) need an approved
  issue or discussion before you write code. Unsolicited large PRs may be closed.
- Read the [Code of Conduct](CODE_OF_CONDUCT.md), the [AI policy](AI_POLICY.md)
  and the [governance model](GOVERNANCE.md).

## Development workflow

1. Fork the repository and create a branch from `main`.
2. Install dependencies with `pnpm install` (the Node.js version is pinned in `.nvmrc`).
3. Make your change, with tests.
4. Run the checks locally: `pnpm lint`, `pnpm typecheck`, `pnpm test`, `pnpm build`.
5. Add a changeset with `pnpm changeset` if your change affects a published package.
6. Open a pull request and fill in the template.

## Rules for pull requests

- **One concern per pull request.** Keep diffs small and focused.
- **Link an issue** (`Closes #123`) for anything that isn't a typo.
- **Tests are required** for bug fixes and features.
- **Conventional Commits** for PR titles (`feat(core): ...`, `fix(mantine): ...`, `docs: ...`).
  We squash-merge, so the PR title becomes the commit message.
- **No breaking changes without a deprecation first**, except before `1.0`.
- **Don't touch protected paths** (`.github/`, workflows, `CODEOWNERS`, release config)
  unless a maintainer asked you to. These changes are risk class R3 (see [GOVERNANCE.md](GOVERNANCE.md)).
- All required checks must pass, and review threads must be resolved, before merge.
  Pushing new commits dismisses previous approvals.

## Reviews

A maintainer reviews every pull request. AI reviewers may leave comments, but their
comments are signals, not approvals. Be patient: this is a small project.

## License

By contributing, you agree that your contributions are licensed under the MIT License
of the repository you contribute to.
