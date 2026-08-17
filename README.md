# congrats, you found the secret repo that generates commits

a GitHub Action runs daily, makes 1-5 fake conventional commits
(`feat(bullshit-subsystem): added bullshit to parse_config`), spread across
random times so it's not all one timestamp, and pushes. that's the whole
project.

commits are authored as EPSILON0-dev so they count on the graph. messages
are built by combining random lines from `data/commit_types.txt`,
`commit_scopes.txt`, `commit_funcs.txt`, and `commit_verbs.txt`.

only real setup step: Settings -> Actions -> General -> Workflow permissions
-> "Read and write permissions", so it's allowed to push.
