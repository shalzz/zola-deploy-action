#!/bin/bash
set -e
set -o pipefail

if [[ -n "$TOKEN" ]]; then
    GITHUB_TOKEN=$TOKEN
fi

if [[ -z "$PAGES_BRANCH" ]]; then
    PAGES_BRANCH="master"
fi

if [[ -z "$GITHUB_TOKEN" ]]; then
    echo "Set the GITHUB_TOKEN env variable."
    exit 1
fi

if [[ -z "$GITHUB_REPOSITORY" ]]; then
    echo "Set the GITHUB_REPOSITORY env variable."
    exit 1
fi

main() {
    echo "Starting deploy..."

    echo "Fetching themes"
    git config --global url."https://".insteadOf git://
    git config --global url."https://github.com/".insteadOf git@github.com:
    git submodule update --init --recursive

    version=$(zola --version)
    remote_repo="https://${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git"
    remote_branch=$PAGES_BRANCH

    echo "Using $version"

    zola build

    echo "Pushing artifacts to ${GITHUB_REPOSITORY}:$remote_branch"

    cd public
    git init
    git config user.name "GitHub Actions"
    git config user.email "github-actions-bot@users.noreply.github.com"
    git add .

    git commit -m "Deploy ${GITHUB_REPOSITORY} to ${GITHUB_REPOSITORY}:$remote_branch"
    git push --force "${remote_repo}" master:${remote_branch}

    echo "Deploy complete"
}

main "$@"
