# Example: L1 Small Feature

## Task

Add an export button to the user list page.

## Constraints

- Do not change backend APIs.
- Do not refactor the table component.
- Reuse existing button styles.
- Keep the diff minimal.

## Expected Agent Behavior

1. Classify as L1.
2. Perform impact analysis.
3. Locate the user list page.
4. Add the button near existing actions.
5. Verify page entry and build/typecheck if available.
6. Output Executive Summary.

## Expected Summary

```text
Goal: add export button to user list.
Changed: user list page action area.
Validated: checked render path; build not run because ...
Risks: export API behavior not changed.
Conclusion: can continue.
```
