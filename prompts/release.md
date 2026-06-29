# Release Prompt

Use the ai-coding-guardrails skill to prepare release validation.

Release scope:
[describe release scope]

Check:
- included changes match the release scope
- P0 flows have validation evidence
- known unverified paths are listed
- rollback or follow-up items are explicit
- no unrelated refactors are bundled into the release

Output:
- Release conclusion: can release / needs small fix / must rework
- P0 validation checklist
- Known risks, max 3
- Follow-ups, max 3
- Executive Summary
