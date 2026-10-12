---
description: Build a gh squash-merge command — Conventional Commits subject + body in /tmp/pr<N>-squash-body.md (does NOT run the merge)
argument-hint: <pr-number> [keep]
allowed-tools: Bash(gh pr view:*), Bash(gh pr checks:*), Bash(gh pr diff:*), Bash(git log:*), Bash(git fetch:*), Write
---

Produce a ready-to-run `gh pr merge` **squash** command for PR #$1. Do **NOT** run the
merge yourself — output the command for the user to run, and stop.

**Branch deletion:** default to including `--delete-branch`. If the second argument
(`$2`, anywhere in `$ARGUMENTS`) is `keep`, `--keep`, `--keep-branch`, or `--no-delete`,
**omit** `--delete-branch` so the branch is kept. State which you chose in step 5.

## Steps

1. **Gather context** (read-only):
   - `gh pr view $1 --json title,body,headRefName,baseRefName,files,commits,state,mergeable,mergeStateStatus`
   - `git fetch origin -q` then `git log origin/main --oneline -15` to learn this repo's
     Conventional Commits **scope vocabulary** and `type(scope):` style.

2. **Derive a Conventional Commits subject** of the form `type(scope): description (#$1)`:
   - `type` ∈ `feat` | `fix` | `refactor` | `chore` | `docs` | `test` | `build` | `ci` |
     `perf` | `style` — pick from the actual change (new capability → `feat`, bug fix →
     `fix`, no-behaviour restructure → `refactor`, etc.).
   - `scope` = the package/area touched (e.g. `ui-components`, `backend`, `i18n`,
     `graphql`), matching scopes seen in recent `git log origin/main`. If a sibling PR
     touched the same area, reuse its scope.
   - `description` = imperative, lower-case, no trailing period, and don't repeat the
     scope word in it.
   - Always append ` (#$1)`.
   - If the PR title is already Conventional-compliant, refine it; otherwise write one
     (the PR title is often non-compliant — that's why `--subject` is needed).

3. **Write a concise squash body** to `/tmp/pr$1-squash-body.md` using the Write tool:
   - One short prose paragraph (what + why), then a few `- ` bullets on notable specifics.
   - **No leading `#` heading** (would render oddly as the commit body's first line).
   - End with: `🤖 Generated with [Claude Code](https://claude.com/claude-code)`

4. **Output the command** (do not execute it) — include `--delete-branch` per the branch
   rule above, or omit it when the `keep` flag was given:

   ```bash
   gh pr merge $1 --squash --delete-branch \
     --subject "<the conventional subject>" \
     --body-file /tmp/pr$1-squash-body.md
   ```

   Note that `--body-file` passes the `.md` verbatim (no editor, no auto-appended commit
   list), and that you did NOT run the merge. If you deleted the branch by default,
   mention that passing `keep` as the 2nd arg next time retains it.

5. **State the merge-readiness** from step 1 in one line (`mergeable` / `mergeStateStatus`,
   and from `gh pr checks $1` whether the functional checks are green) so the user knows
   if it's safe to run now.
