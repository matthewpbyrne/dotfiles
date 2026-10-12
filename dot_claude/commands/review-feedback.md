---
description: Read the latest Claude/Codex/Copilot review feedback on a PR, verify each claim against the CURRENT code, and propose actions. Makes NO changes — proposes and awaits approval.
argument-hint: [pr-number]
allowed-tools: Bash(gh pr view:*), Bash(gh api:*), Bash(gh pr checks:*), Bash(git fetch:*), Bash(git log:*), Bash(git rev-parse:*), Bash(git diff:*), Read, Grep, Glob
---

Triage the latest bot review feedback (Claude, Codex, Copilot) on PR #$1 — if no number is
given, use the current branch's PR. **Propose** actions; do **NOT** edit code. Await approval.

## Steps

1. **Pin the current tip first — bot reviews are routinely stale.** `git fetch origin -q`; `gh pr view $1 --json number,headRefName,state,mergeable,mergeStateStatus`. Record the remote tip SHA and its commit time; you will judge every comment against this tip, not against whatever the bot saw.

2. **Collect feedback from all three bots, newest first. All THREE endpoints — each bot hides something in a different one:**
   - Top-level reviews/comments: `gh api repos/:owner/:repo/issues/$1/comments` — keep authors matching `claude`, `codex`, `copilot`. A **clean Codex pass lives only here**, never in `reviews`; and the **Claude bot edits one placeholder comment in place**, so read `updated_at` and re-read the body rather than watching for a new comment id.
   - Inline review comments: `gh api repos/:owner/:repo/pulls/$1/comments` — same authors, with `path:line` + body. This returns *surfaced* threads only.
   - **Review bodies: `gh api repos/:owner/:repo/pulls/$1/reviews`** — Copilot puts its verdict banner (`🟢 Approval recommended` / `🔵 Needs a closer look`) and, critically, its **suppressed comments** in the review *body*, where they are invisible to the endpoint above. Print each review's `body`, not just its `state`. A suppressed comment is a real finding: on #282 one was the only report of a genuine defect, and checking only `pulls/N/comments` produced a confident, wrong "Copilot never raised this".
   - Note each comment's timestamp; flag which ones **postdate the latest push** (reviewing current code) vs. which reviewed a superseded commit. For Codex, trust the `**Reviewed commit:** <sha>` line in the body over the timestamp — it is routinely behind the tip it was triggered against.

3. **Verify every finding against the current code — never on faith.** Bots regularly quote code that no longer exists, predict lint/CI failures that don't occur, flag things already fixed, or raise legacy/back-compat concerns that don't apply. For each finding:
   - Read the cited file/lines on the current tip (`Read`/`Grep`).
   - If it claims a lint / type / test failure ("will fail the strict rule", "lint error", "breaks CI"), **run the actual check** on that file (the repo's eslint / tsc / pytest / etc.) and report the real exit status — don't repeat the prediction.
   - If the repo is greenfield (no production data / old clients), don't accept migration or backwards-compat arguments; say so.

4. **Triage** each finding into exactly one bucket:
   - **Real & open** → propose a concrete fix: file, the change, and why.
   - **Already addressed** → cite the commit/line that resolves it.
   - **False / stale / premature** → refute with the evidence from step 3 (quote the real line, or the clean lint/test run).

5. **Output a prioritized proposal:** blocking items first, then minor; each with the recommended action or an explicit skip-with-rationale. Note anything where two reviewers disagree. End by asking whether to proceed — make **no** edits in this command.
