# Review Prompt

Use AI Coding Guardrails to review this change. In Codex, invoke `$ai-coding-collaboration`.

Check:
- requirement match
- scope creep
- unrelated refactor
- API / DTO / database / config impact
- missing route or caller update
- P0 validation
- unverified core paths

Output only:
- Conclusion
- Blocker
- Major
- Minor, max 3
- Next step
- final summary using `【目标】`、`【改动文件】`、`【自测结果】`、`【风险】`、`【必须验收】`、`【结论】`
