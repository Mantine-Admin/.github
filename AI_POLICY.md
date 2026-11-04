# AI Policy

Mantine Admin is built with AI agents, and we welcome contributors who use AI tools.
This policy sets the rules for both.

## For contributors using AI tools

Inspired by the [TanStack AI policy](https://github.com/TanStack/query/blob/main/AI_POLICY.md).

- **Never let an LLM think for you.** Use AI to explore or to write code, but only submit
  changes you fully understand and can explain. You're responsible for every line.
- **Never let an LLM speak for you.** Write issues, PR descriptions and review replies in
  your own words. Short and clear beats long and polished. Don't paste AI summaries.
- **Disclose it.** Tick the AI box in the pull request template when AI generated a
  significant part of the change.
- **Same bar for everyone.** AI-assisted contributions follow the same rules, tests and
  reviews as any other contribution. Low-effort generated PRs will be closed.

## For the organization's agents

These rules apply to every agent operating on Mantine Admin repositories, whatever the model or vendor.

1. **Work from an issue.** Every agent PR links an issue with acceptance criteria.
2. **Use a dedicated bot identity.** Agents never act with a human's credentials.
3. **Never approve, never merge.** Only humans approve. Only the merge controller merges,
   and only when the risk class allows it.
4. **Stay inside the risk class.** Agents may propose R3 changes (workflows, rulesets,
   `CODEOWNERS`, `AGENTS.md`, release config) but a human owner decides.
5. **Follow the repository's `AGENTS.md`.** It's the canonical source of conventions and commands.
6. **No secrets, no security work.** Agents never handle credentials or undisclosed vulnerabilities.
7. **Stop and ask.** When requirements are unclear, checks keep failing, or a change grows beyond
   the issue's scope, the agent stops and asks a human in the issue instead of guessing.
8. **Bounded cost.** Agent runs have token and time limits. A run that hits a limit stops.

AI reviews are signals that help humans review faster. They never replace a human approval.
``