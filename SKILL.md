---
name: ai-coding-collaboration
description: Use when coding agents need guardrails against overengineering, scope creep, missing validation, noisy handoffs, or unverified completion. Classifies tasks by size, enforces minimal diff, runs impact and self-checks, and ends with concise evidence-based summaries. Trigger for coding tasks, bug fixes, feature work, code review, test/acceptance planning, implementation handoff, or generating project agent rules from the AI Coding execution specification.
---

# AI Coding Guardrails

## Purpose

Apply pragmatic guardrails for AI coding work: classify the task, choose the lightest sufficient process, keep diffs small, validate core behavior, and end with a concise evidence-based summary.

This skill is packaged as **AI Coding Guardrails**. The repository and Codex skill identifier may still appear as `ai-coding-collaboration` for compatibility.

For the full source specification, read `references/ai-coding-execution-spec-v1.md` when the user asks for the complete standard, wants to generate derived rule files, or the task is ambiguous enough that the condensed rules below are insufficient. That specification is normative; prompts and examples are supporting material.

## Task Level Decision

Choose the lowest level that safely covers the request:

| Level | Use for | Process |
| --- | --- | --- |
| L0 micro task | Copy tweaks, small style change, simple bug, single-file fix | Understand -> change -> self-check -> summary |
| L1 small feature | Simple API, button, form validation, small page change | Task card -> impact analysis -> implement -> checklist -> summary |
| L2 module task | Login, permissions, payment, uploads, multi-layer backend/frontend/database work | Short plan -> task split -> implement stepwise -> review -> test -> summary |
| L3 project task | New project, major refactor, core architecture or risky database changes | PRD/architecture/backlog -> stepwise implementation -> release checklist |

Do not run L2/L3 ceremony for L0/L1 work. Do not skip analysis for L2/L3 work.

## Risk Modifiers

Task size is not the only decision. Upgrade the workflow to at least L2 and ask for explicit scope confirmation before implementation when a change affects any of the following:

- authentication, authorization, secrets, or security controls
- payments, billing, or other irreversible external actions
- production configuration, data deletion, migrations, or backfills
- public APIs, shared contracts, or data isolation

State the modifier and the reason for the upgrade. Do not treat a small diff as low risk merely because it changes few lines.

## Ambiguity Gate

For L2/L3 work, pause before planning when an unresolved product decision, acceptance criterion, ownership boundary, or irreversible trade-off could change the implementation. Inspect the codebase first, then ask one focused question at a time with a recommended default.

Do not run a grilling session by default for L0/L1 work. If the user has supplied clear acceptance criteria, proceed without extra questions.

## Non-Negotiable Rules

- Analyze complex tasks before proposing a solution, and implement only after scope is clear.
- Do not make large code changes unless the user asks to implement, modify, or execute.
- Inspect current code, docs, config, and tests when uncertain.
- Use the smallest safe diff; avoid unrelated formatting, renames, dependency additions, and opportunistic refactors.
- Do not rename public APIs, routes, DTOs, database fields, or config keys without explicit scope.
- Do not delete existing tests unless the reason is stated and replacement coverage is added.
- Prefer root-cause fixes over surface workarounds.
- If verification cannot be completed, say exactly what was not verified and why.

## Required Pre-Implementation Checks

For L1+ implementation, state a compact impact analysis before editing:

```text
Backend API: yes/no
Service logic: yes/no
DTO/types: yes/no
Database/config: yes/no
Frontend page/API call: yes/no
Routing/navigation: yes/no
Tests/validation: yes/no
Risk: max 3 bullets
```

For L0, skip the table unless the change touches API, database, auth, or user data.

## Implementation Discipline

- Keep changes reversible and scoped to the task.
- Reuse existing patterns and file organization.
- Preserve existing behavior unless the user requests a behavior change.
- Record discovered unrelated issues as follow-up notes instead of fixing them in the same diff.
- Match the repository's style and command conventions.

## Validation Rules

Use P0/P1/P2 validation instead of long test lists:

- **P0 required**: core flow runs, data is correct, API/page entry works, build/typecheck passes where relevant.
- **P1 recommended**: empty state, invalid params, duplicate submit, network failure, legacy data.
- **P2 optional**: performance, large data, extreme UI boundaries, weak-network behavior.

Never mark work as merge-ready when P0 validation was not run or failed. If tests are unavailable, report manual validation or state unverified.

## Validation Evidence

For every P0 item, report the command or manual path, its result, and any coverage limitation. A statement such as "tests passed" without the command or observable result is not validation evidence.

## OpenSpec Cooperation

This skill governs execution quality; it does not replace persistent change specifications.

- L0/L1: use Guardrails only unless the repository already requires a specification.
- L2/L3: keep a short decision record. When the repository uses OpenSpec, work through its proposal/apply/archive workflow and use this skill for task level, risk, minimal diff, and validation evidence.
- Do not create an `openspec/` directory or add a new workflow tool unless the user explicitly requests it.

## Post-Implementation Self-Check

Before final handoff, answer internally and report material gaps:

1. Is any requested item missing?
2. Did any code change remain unverified?
3. Were API, route, DTO, config, database, or test impacts missed?
4. Are there new risks or follow-up tasks?
5. Can the work proceed to review, or does it need more changes?

## Review Output

For code review tasks, use:

```text
Conclusion: merge-ready / can continue / needs small fix / must rework
Blocker: required fixes
Major: important issues
Minor: optional improvements, max 3
Next step: direct fix prompt or action
```

Do not produce broad generic review advice.

## Final Executive Summary

End implementation or review turns with a short summary:

```text
【目标】one sentence
【改动文件】key files and purpose
【自测结果】commands/manual checks run
【风险】max 3
【必须验收】max 5 items
【结论】can continue / merge-ready / needs small fix / must rework
```

Keep it concise. Do not claim merge-ready when there are unverified core paths.
