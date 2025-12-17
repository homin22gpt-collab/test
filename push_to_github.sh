#!/usr/bin/env bash
set -euo pipefail

# Helper script to push the current branch to GitHub.
# Usage: ./push_to_github.sh <GITHUB_REPO_URL> [branch]

if [[ $# -lt 1 ]]; then
  echo "Usage: $0 <GITHUB_REPO_URL> [branch]" >&2
  exit 1
fi

REPO_URL="$1"
BRANCH="${2-$(git rev-parse --abbrev-ref HEAD)}"

if ! git remote | grep -q "^origin$"; then
  echo "Adding origin remote: $REPO_URL"
  git remote add origin "$REPO_URL"
else
  echo "Updating origin remote to: $REPO_URL"
  git remote set-url origin "$REPO_URL"
fi

echo "Pushing branch '$BRANCH' to GitHub..."
git push -u origin "$BRANCH"
