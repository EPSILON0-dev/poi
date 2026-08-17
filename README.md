# daily-activity

Scheduled GitHub Action that makes 1-5 commits a day at randomized times, using
random messages from `data/commit_messages.txt`.

## Setup

1. Create a repo on GitHub and push this to it (see below).
2. **Important:** for commits to count on your contribution graph, the commit
   author name/email must match an email verified on your GitHub account.
   Set these as repo variables (Settings -> Secrets and variables -> Actions -> Variables):
   - `COMMIT_AUTHOR_NAME` — your GitHub username or display name
   - `COMMIT_AUTHOR_EMAIL` — an email verified on your account. To keep it
     private, use your GitHub-provided noreply address (Settings -> Emails ->
     "Keep my email address private"), format:
     `ID+username@users.noreply.github.com`
   If these vars aren't set, commits fall back to a `placeholder` identity and
   won't count toward your graph.
3. Settings -> Actions -> General -> Workflow permissions -> set to
   "Read and write permissions" so the default `GITHUB_TOKEN` can push.
4. The workflow also runs on `workflow_dispatch`, so you can trigger it
   manually from the Actions tab to test before waiting for the daily cron.

## Notes

- GitHub disables scheduled workflows after 60 days with no repo activity;
  this repo's own daily pushes count as activity, so it should stay alive.
- Contributions only count on the repo's default branch, and only for
  non-fork repos (or forks with the right settings) — keep this as its own
  standalone repo.
- Commit times are randomized within roughly the last 10 hours of each run so
  they don't all land at the exact same minute every day.
