#!/usr/bin/env bash
# Makes 1-5 randomly-timed commits against a rotating set of scratch files.
set -euo pipefail

cd "$(dirname "$0")/.."

AUTHOR_NAME="${COMMIT_AUTHOR_NAME:-placeholder}"
AUTHOR_EMAIL="${COMMIT_AUTHOR_EMAIL:-placeholder@example.com}"
git config user.name "$AUTHOR_NAME"
git config user.email "$AUTHOR_EMAIL"

MESSAGES_FILE="data/commit_messages.txt"
LOG_FILES=("activity/log.md" "activity/notes.md" "activity/scratch.md" "activity/journal.md")

NUM_COMMITS=$(( (RANDOM % 5) + 1 ))
echo "Making $NUM_COMMITS commit(s)"

mapfile -t MESSAGES < <(shuf "$MESSAGES_FILE")
MSG_COUNT=${#MESSAGES[@]}

NOW_EPOCH=$(date -u +%s)
SPREAD_SECONDS=$(( 10 * 3600 )) # spread commits across the last 10 hours

OFFSETS=()
for ((i = 0; i < NUM_COMMITS; i++)); do
  OFFSETS+=($(( RANDOM % SPREAD_SECONDS )))
done
mapfile -t SORTED < <(printf '%s\n' "${OFFSETS[@]}" | sort -rn)

for ((i = 0; i < NUM_COMMITS; i++)); do
  MSG="${MESSAGES[$(( i % MSG_COUNT ))]}"
  TARGET="${LOG_FILES[$(( RANDOM % ${#LOG_FILES[@]} ))]}"
  mkdir -p "$(dirname "$TARGET")"

  TOKEN=$(head -c 16 /dev/urandom | base64 | tr -dc 'a-zA-Z0-9' | head -c 8)
  printf -- "- %s :: %s\n" "$(date -u +"%Y-%m-%dT%H:%M:%SZ")" "$TOKEN" >> "$TARGET"

  COMMIT_EPOCH=$(( NOW_EPOCH - SORTED[i] ))
  COMMIT_DATE=$(date -u -d "@$COMMIT_EPOCH" +"%Y-%m-%dT%H:%M:%S")

  git add "$TARGET"
  GIT_AUTHOR_DATE="$COMMIT_DATE" GIT_COMMITTER_DATE="$COMMIT_DATE" \
    git commit -q -m "$MSG" --date "$COMMIT_DATE"
  echo "  [$COMMIT_DATE] $MSG ($TARGET)"
done
