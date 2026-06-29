# AI Coding Guardrails

> Keep Codex, Claude Code, and Cursor from overengineering, missing validation, and producing noisy handoffs.

**AI Coding Guardrails** is a practical skill for everyday software development.

It helps coding agents classify task size, keep diffs small, validate core behavior, and end with a concise evidence-based summary.

## Why this exists

AI coding agents are powerful, but they often:

- turn small tasks into heavy SOPs
- modify unrelated files
- add unnecessary abstractions
- forget routes, DTOs, configs, tests, or validation
- claim work is complete without running checks
- produce long review reports that humans do not want to read

This skill adds lightweight guardrails:

- classify the task before acting
- use the smallest sufficient workflow
- keep changes scoped and reversible
- validate P0 behavior
- report unverified work honestly
- finish with a short Executive Summary

## Core idea

Do not use the same process for every task.

| Level | Use for | Process |
|---|---|---|
| L0 Micro task | copy change, small style tweak, tiny bug fix | change -> self-check -> summary |
| L1 Small feature | button, simple API, form validation, small page change | task card -> impact analysis -> implement -> checklist |
| L2 Module task | login, permissions, uploads, multi-layer changes | short plan -> task split -> review -> test |
| L3 Project task | new project, major refactor, architecture change | PRD -> architecture -> backlog -> release checklist |

Small tasks stay light.  
Large tasks get structure.

## What it enforces

### Minimal Diff

The agent should:

- modify the fewest files possible
- avoid unrelated formatting
- avoid opportunistic refactors
- avoid renaming public APIs, routes, DTOs, database fields, or config keys
- record unrelated issues as follow-ups instead of fixing them in the same diff

### Impact Analysis

For L1+ tasks, the agent must state whether the change touches:

- backend API
- service logic
- DTO / types
- database / config
- frontend page / API call
- routing / navigation
- tests / validation

### Validation Discipline

Validation is grouped by priority:

| Level | Meaning |
|---|---|
| P0 | required: core flow, data correctness, API/page entry, build/typecheck |
| P1 | recommended: empty state, invalid params, duplicate submit, network failure |
| P2 | optional: performance, large data, extreme UI edge cases |

The agent must not say `merge-ready` when P0 validation was not run or failed.

### Final Executive Summary

Every implementation or review ends with:

```text
Goal:
Changed:
Validated:
Risks:
Conclusion:
```

No long generic handoff.

## Quick Start

Copy this repository into your Codex skills directory:

```powershell
git clone git@github.com:yeqiana/ai-coding-collaboration.git "$env:USERPROFILE\.codex\skills\ai-coding-collaboration"
```

Or copy `SKILL.md` into your AI coding tool's skills directory.

Example for Claude Code:

```text
~/.claude/skills/ai-coding-guardrails/SKILL.md
```

Then ask:

```text
Use ai-coding-guardrails.

Task:
Add an export button to the user list page.

Constraints:
- Do not change backend APIs.
- Do not refactor unrelated components.
- Keep the diff minimal.
- Run missing-check self-audit.
- Do not mark merge-ready without P0 validation.
```

Codex users can also invoke the existing skill name:

```text
Use $ai-coding-collaboration.
```

## Example: before vs after

### Without this skill

The agent may:

- generate a long plan
- rewrite unrelated files
- add unnecessary abstractions
- forget to verify the page entry
- produce 30 test suggestions

### With this skill

The agent should respond like:

```text
Task level: L1 small feature

Impact:
Backend API: no
Frontend page/API call: yes
Routing: no
Tests/validation: yes
Risk: low

Plan:
1. Locate user list page
2. Add export button near existing actions
3. Reuse existing export handler if available
4. Run build/typecheck if available

Executive Summary:
Goal: add export button to user list.
Changed: UserList page action area.
Validated: checked page render path; build not run because ...
Risks: export API behavior not changed.
Conclusion: can continue / needs small fix / merge-ready
```

## When to use

Use this skill for:

- feature implementation
- bug fixes
- code review
- implementation handoff
- test and acceptance planning
- generating project agent rules
- reducing noisy AI output
- preventing overengineering

## When not to use

Do not use this as a replacement for:

- full product PRD
- deep architecture design
- security audit
- production release approval

For high-risk L3 work, use this skill together with a proper spec workflow.

## Philosophy

```text
Small tasks -> light process
Large tasks -> structured process
Every task -> scoped diff + validation evidence
```

## Files

```text
SKILL.md
README.zh-CN.md
references/ai-coding-execution-spec-v1.md
examples/
prompts/
```

Additional promotion and rollout notes are kept in `docs/`.

## License

MIT. See [LICENSE](LICENSE).
