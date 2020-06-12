#!/bin/bash
set -e
set -o pipefail

if [[ -n "$TOKEN" ]]; then
    GITHUB_TOKEN=$TOKEN
fi

if [[ -z "$PAGES_BRANCH" ]]; then
    PAGES_BRANCH="gh-pages"
fi

if [[ -z "$BUILD_DIR" ]]; then
    BUILD_DIR="."
fi

if [[ -z "$GITHUB_TOKEN" ]]; then
    echo "Set the GITHUB_TOKEN env variable."
    exit 1
fi

if [[ -z "$GITHUB_REPOSITORY" ]]; then
    echo "Set the GITHUB_REPOSITORY env variable."
    exit 1
fi

if [[ -z "$BUILD_ONLY" ]]; then
    BUILD_ONLY=false
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

    echo "Building in $BUILD_DIR directory"
    cd $BUILD_DIR
    
    echo Building with flags: ${BUILD_FLAGS:+"$BUILD_FLAGS"}
    zola build ${BUILD_FLAGS:+"$BUILD_FLAGS"}

    if ${BUILD_ONLY}; then
        echo "Build complete. Deployment skipped by request"
        exit 0
    else 
        echo "Pushing artifacts to ${GITHUB_REPOSITORY}:$remote_branch"

        cd public
        git init
        git config user.name "GitHub Actions"
        git config user.email "github-actions-bot@users.noreply.github.com"
        git add .

        git commit -m "Deploy ${GITHUB_REPOSITORY} to ${GITHUB_REPOSITORY}:$remote_branch"
        git push --force "${remote_repo}" master:${remote_branch}

        echo "Deploy complete"
    fi
}

main "$@"
