---
description: (Re)trigger the @claude and @codex PR review bots by posting the mention comment. Use after pushing review fixes, or when a bot missed a push.
argument-hint: [pr-number]
allowed-tools: Bash(request-review:*), Bash(gh pr view:*), Bash(gh pr comment:*)
---

Trigger a fresh bot review on PR #$1 — if no number is given, use the current branch's PR.

Run the global helper, which posts a single comment mentioning the review bots
(`@claude` / `@codex`) — that mention is what kicks off a new review:

```
request-review $1
```

To trigger only one bot, set `BOTS` (e.g. `BOTS="@codex" request-review $1`).

If `request-review` isn't on PATH, fall back to posting the comment directly
(resolve the PR from `gh pr view --json number` when `$1` is empty):

```
gh pr comment $1 --body $'@claude review this PR\n@codex review this PR'
```

Report the comment URL `gh` prints. Make **no** code changes — this only posts the trigger comment.
