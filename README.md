# AI Coding Collaboration

Codex skill for classifying AI coding tasks, keeping implementation diffs small, validating core behavior, and ending with concise evidence-based handoff summaries.

It is designed for developers who use AI agents for real software work and want fewer common failure modes:

- AI treats every task like a large refactor.
- Small fixes produce oversized plans and noisy diffs.
- Feature work misses API, DTO, config, database, or test impact.
- Final summaries say “done” without evidence.
- Review feedback is broad but not actionable.

## What it does

- Classifies tasks into L0 / L1 / L2 / L3 workflows.
- Requires scoped analysis before non-trivial implementation.
- Enforces minimal-diff implementation discipline.
- Uses P0 / P1 / P2 validation instead of long unprioritized test lists.
- Requires post-implementation self-checks.
- Standardizes review output and executive summaries.

## Repository structure

```text
.
├─ SKILL.md
├─ agents/
│  └─ openai.yaml
├─ references/
│  └─ ai-coding-execution-spec-v1.md
└─ docs/
   ├─ examples.md
   ├─ promotion-copy.md
   └─ skills仓库推广实施测试验收方案.md
```

## Install

Copy this repository into your Codex skills directory:

```powershell
git clone git@github.com:yeqiana/ai-coding-collaboration.git "$env:USERPROFILE\.codex\skills\ai-coding-collaboration"
```

Or copy the folder manually:

```powershell
Copy-Item -Recurse . "$env:USERPROFILE\.codex\skills\ai-coding-collaboration"
```

Restart your Codex session after installation so the skill can be discovered.

## Usage

Invoke it directly:

```text
Use $ai-coding-collaboration to classify this coding task, implement with minimal diff, validate it, and summarize the result.
```

Example:

```text
Use $ai-coding-collaboration.

Task: Fix the mobile layout bug where the profile stats card wraps onto two rows.
```

## Example scenarios

See [docs/examples.md](docs/examples.md) for realistic prompts and expected behavior:

- L0 small UI fix
- L1 small feature
- L2 module-level user identity work
- Code review

## Core workflow

```text
Classify task size
-> inspect relevant files
-> choose the lightest sufficient workflow
-> implement the smallest safe diff
-> validate P0 paths
-> report evidence and risks
```

## When to use

Use this skill for:

- Coding tasks
- Bug fixes
- Small and medium feature work
- Code review
- Implementation handoff
- Test and acceptance planning
- Generating project agent rules from the full execution specification

Do not use it as a replacement for domain-specific engineering judgment. It is a collaboration workflow, not an automatic guarantee that code is correct.

## Full specification

The condensed operational rules live in [SKILL.md](SKILL.md).

The full Chinese execution standard is preserved in [references/ai-coding-execution-spec-v1.md](references/ai-coding-execution-spec-v1.md).

## License

MIT. See [LICENSE](LICENSE).
