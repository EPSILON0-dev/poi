# congrats, you found the secret repo that generates commits

there is no product. there is no roadmap. there is only the graph, and the
graph must be green.

every day, a GitHub Action wakes up, makes 1-5 fake conventional commits
(`feat(bullshit-subsystem): added bullshit to shit_func123` — real example),
scatters them at slightly different times so it doesn't look too suspicious,
and pushes. that's it. that's the whole project.

## setup (do this once)

1. push this to its own repo on GitHub.
2. for the commits to actually count on your contribution graph, set these
   as repo variables (Settings -> Secrets and variables -> Actions -> Variables):
   - `COMMIT_AUTHOR_NAME` — your GitHub username
   - `COMMIT_AUTHOR_EMAIL` — an email verified on your account. use your
     noreply address if you don't want your real email in every commit:
     `ID+username@users.noreply.github.com`
   - skip this and every commit is authored by `placeholder`, which does
     nothing for you.
3. Settings -> Actions -> General -> Workflow permissions -> "Read and write
   permissions", so it's allowed to push.
4. optionally run it once by hand from the Actions tab (`workflow_dispatch`)
   to make sure it works before trusting the cron.

## how the messages get made

`data/commit_types.txt`, `commit_scopes.txt`, `commit_funcs.txt`, and
`commit_verbs.txt` each hold a pile of fragments. every commit picks one of
each at random and glues them into `type(scope): verb` — so it's always a
technically-valid conventional commit that means nothing.

## honest notes

- GitHub kills scheduled workflows after 60 days of repo silence; this repo
  feeds itself so that shouldn't happen, but if the graph goes gray, check
  the Actions tab.
- only counts on the default branch, and this needs to be its own repo
  (not a fork).
- you didn't hear it from me but this is a bit of a lie to everyone who
  looks at your profile.
