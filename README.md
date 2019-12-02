# Zola Deploy Action

A GitHub action to automatically build and deploy your [zola] site to the master
branch as GitHub Pages.

## Table of Contents

 - [Usage](#usage)
 - [Secrets](#secrets)
 - [Custom Domain](#custom-domain)

## Usage

```
on: push
name: Build and deploy on push
jobs:
  build:
    name: shalzz/zola-deploy-action
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - name: shalzz/zola-deploy-action
      uses: shalzz/zola-deploy-action@master
      env:
        PAGES_BRANCH: master
        BUILD_DIR: docs
        BUILD_FLAGS: --drafts
        TOKEN: ${{ secrets.TOKEN }}
```

## Secrets

 * `TOKEN`: [Personal Access key][] with the appropriate scope. If the
    repository is public the `public_repo` scope suffices, for private
    repositories the full `repo` scope is required. We need this to push
    the site files back to the repo.
    
    ( Actions already provides a `GITHUB_TOKEN` which is an installation token and does not trigger a GitHub Pages builds hence we need a personal access token )

## Environment Variables
* `PAGES_BRANCH`: The git branch of your repo to which the built static files will be pushed. Default is `master` branch
* `BUILD_DIR`: The path from the root of the repo where we should run the `zola build` command. Default is `.` (current directory)
* `BUILD_FLAGS`: Custom build flags that you want to pass to zola while building. (Be careful supplying a different build output directory might break the action).

## Custom Domain

If you're using a custom domain for your GitHub Pages site put the CNAME 
in `static/CNAME` so that zola puts it in the root of the public folder
which is where GitHub expects it to be.

[zola]: https://github.com/getzola/zola
[Personal Access key]: https://help.github.com/en/github/authenticating-to-github/creating-a-personal-access-token-for-the-command-line
