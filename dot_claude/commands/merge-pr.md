---
description: Build the gh command(s) to rebase a PR onto its base then land it with a merge commit (semi-linear). Rebase and merge-commit each independently disable-able. Conventional subject + /tmp body. Runs nothing.
argument-hint: <pr-number> [no-rebase] [no-merge] [keep]
allowed-tools: Bash(gh pr view:*), Bash(gh pr checks:*), Bash(git log:*), Bash(git fetch:*), Bash(git rev-parse:*), Write
---

Produce ready-to-run `gh` command(s) to land PR #$1 with the **rebase-then-merge-commit**
flow. Do **NOT** run anything — output the command(s) and stop.

Two independent steps, **both ON by default**; flags anywhere in `$ARGUMENTS` turn either OFF:
- **rebase** — first bring the branch up to date & linear by rebasing it onto its base
  (`gh pr update-branch $1 --rebase`). Disable with `no-rebase`.
- **merge commit** — finish with a real merge commit (`gh pr merge --merge`). Disable with
  `no-merge` (then finish without a merge node).
- **branch** — include `--delete-branch` on the merge unless `keep`, `--keep-branch`, or
  `--no-delete` is present.

## Steps

1. **Gather context:** `gh pr view $1 --json title,headRefName,baseRefName,commits,files,state,mergeable,mergeStateStatus`; `git fetch origin -q` then `git log origin/main --oneline -15` to learn this repo's Conventional Commits scope vocabulary.

2. **Resolve the (rebase?, merge-commit?) combination and emit the matching command(s):**

   - **rebase ON + merge-commit ON — the default.** Two steps. Derive a Conventional Commits subject `type(scope): description (#$1)` (type from the change: feat|fix|refactor|chore|docs|test|build|ci|perf|style; scope = area touched, matching recent `git log origin/main`; imperative, lower-case, no trailing period; always append ` (#$1)`). Write a body to `/tmp/pr$1-merge-body.md` (one short paragraph + a few `- ` bullets, **no leading `#`**, end with `🤖 Generated with [Claude Code](https://claude.com/claude-code)`). Emit:
     ```bash
     gh pr update-branch $1 --rebase
     # wait for CI to go green on the rebased branch, then:
     gh pr merge $1 --merge --delete-branch \
       --subject "<the conventional subject>" \
       --body-file /tmp/pr$1-merge-body.md
     ```

   - **rebase OFF + merge-commit ON.** Merge commit on the branch as-is — same subject + body as above, single command:
     ```bash
     gh pr merge $1 --merge --delete-branch \
       --subject "<the conventional subject>" \
       --body-file /tmp/pr$1-merge-body.md
     ```

   - **rebase ON + merge-commit OFF.** Rebase-and-merge (linear, no merge node). `--rebase` rebases inherently, so no separate update-branch step and **no** subject/body. First inspect commits — `git log origin/$baseRefName..origin/$headRefName --oneline` — and **warn if any are `fixup!`/`squash!`/WIP**, since they land on the base verbatim (suggest cleaning history or `/squash-merge`). Emit:
     ```bash
     gh pr merge $1 --rebase --delete-branch
     ```

   - **both OFF.** Contradictory — nothing to do. Tell the user to keep at least one step, or use `/squash-merge`.

3. **State merge-readiness** (`mergeable` / `mergeStateStatus` + `gh pr checks $1` functional checks), which combination you chose, and branch handling. When the rebase step is included, remind that `gh pr update-branch --rebase` re-triggers CI — wait for green before running the merge. Run nothing.
