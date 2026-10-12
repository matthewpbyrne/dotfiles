---
description: Summarize a PR as a per-file table — path, code/doc/both, and a one-line why. Read-only; makes no changes.
argument-hint: [pr-number]
allowed-tools: Bash(gh pr view:*), Bash(gh pr diff:*), Bash(gh api:*), Bash(git fetch:*), Bash(git log:*), Read, Grep
---

Summarize PR #$1 as a **per-file table** — if no number is given, use the current branch's PR.
Read-only: make **no** edits and post **nothing** to GitHub.

## Steps

1. **Context and tip.** `git fetch origin -q`, then
   `gh pr view $1 --json number,title,body,author,baseRefName,headRefName,state,changedFiles,additions,deletions`.
   Record the head SHA (`headRefOid`) and quote it under the table, so the summary can be dated
   against the tip it describes.

2. **Get the authoritative file list from the compare API, not the patch.**

   ```bash
   gh api "repos/:owner/:repo/compare/<base>...<head>" \
     --jq '.files[] | "\(.status)\t\(.additions)+\t\(.deletions)-\t\(.filename)"'
   ```

   `gh pr diff --patch` is a *per-commit patch series* and double-counts a file touched by more
   than one commit — never use it to build this table. Use `gh pr diff $1` (plain, no `--patch`)
   only to read the actual hunks.

3. **Read the hunks per file.** For every file, look at its diff (and, where the change only
   makes sense in context, the surrounding code) so the *why* column is grounded in what the hunk
   does — not guessed from the filename.

4. **Classify each file** in the Kind column:
   - **code** — behaviour, config, schema, tests, CI, build, generated artefacts.
   - **doc** — prose only: `*.md`, ADRs, comment/docstring-only edits, changelogs.
   - **both** — the file's hunks do genuinely both, e.g. a source file whose diff mixes a logic
     change with a rewritten docstring, or a `.md` whose fenced snippets are executed/tested.

   Classify by **what the hunks change**, not by extension: a `.py` diff that only rewords
   docstrings is *doc*; a `.md` that is the actual runbook a script parses is *code*.

5. **Emit the table**, longest/most substantive change first — the reader should be able to stop
   after three rows and know what the PR does:

   | File | Kind | +/- | Why |
   | --- | --- | --- | --- |
   | `backend/apps/runs/mutations.py` | code | +48/-6 | Adds the `commitDeliveryRun` mutation and its DISPATCHER permission gate. |
   | `docs/adr/0012-run-phases.md` | doc | +31/-0 | Records why DRAFT→COMMITTED is a separate acceptance record. |

   Rules for the **Why** column: one sentence, present tense, says *what this file's change
   accomplishes for the PR* — not a restatement of the diff. If a file exists only to satisfy
   another (a migration for a model, a snapshot for a component, a codegen output), say which
   file it serves. Never write "updates X" where the point of the update can be named.

6. **Group when the table would run long.** Past ~25 rows, keep the same columns but break the
   table under `### <area>` headings (by top-level package/app), and collapse pure bulk — lockfiles,
   generated codegen, snapshot churn — into a single row named for the group
   (e.g. `frontend/src/gql/** (7 files)`) with a why of "codegen output for the new operations".
   State explicitly that you collapsed them; never silently drop a file.

7. **Close with two lines**: a one-sentence statement of what the PR does overall, and the
   code/doc/both counts plus totals (`N files · +A/-D`) reconciled against `changedFiles` from
   step 1. If they disagree, say so and trust the compare API.
