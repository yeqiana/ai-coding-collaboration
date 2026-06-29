# Coding Prompt

Use the ai-coding-guardrails skill.

Task:
[describe task]

Constraints:
- Keep the diff minimal.
- Do not refactor unrelated code.
- Do not add dependencies unless explicitly required.
- Do not rename public APIs, routes, DTOs, database fields, or config keys.

Required output:
1. Task level: L0 / L1 / L2 / L3
2. Impact analysis
3. Implementation plan
4. Changes made
5. Validation result
6. Executive Summary

Do not mark the work as merge-ready if P0 validation was not run or failed.
