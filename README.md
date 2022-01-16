# Zola Deploy Action

[![Build Status](https://img.shields.io/endpoint.svg?url=https%3A%2F%2Factions-badge.atrox.dev%2Fshalzz%2Fzola-deploy-action%2Fbadge&style=flat)](https://actions-badge.atrox.dev/shalzz/zola-deploy-action/goto)
![GitHub release (latest SemVer)](https://img.shields.io/github/v/release/shalzz/zola-deploy-action?sort=semver)

A GitHub action to automatically build and deploy your [zola] site to the master
branch as GitHub Pages.

## Table of Contents

 - [Usage](#usage)
 - [Secrets](#secrets)
 - [Custom Domain](#custom-domain)

## Usage

This example will build on push to any branch, then deploy to gh-pages.

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
        PAGES_BRANCH: gh-pages
        BUILD_DIR: docs
        BUILD_FLAGS: --drafts
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

This example will build and deploy on master branch to gh-pages branch.
Additionally will build only on pull requests.
```
on:
  push:
    branches:
      - master 
  pull_request:
jobs:
  build:
    runs-on: ubuntu-latest
    if: github.ref != 'refs/heads/master'
    steps:
      - name: 'Checkout'
        uses: actions/checkout@master
      - name: 'Build only' 
        uses: shalzz/zola-deploy-action@master
        env:
          BUILD_DIR: .
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
          BUILD_ONLY: true
  build_and_deploy:
    runs-on: ubuntu-latest
    if: github.ref == 'refs/heads/master'
    steps:
      - name: 'Checkout'
        uses: actions/checkout@master
      - name: 'Build and deploy'
        uses: shalzz/zola-deploy-action@master
        env:
          PAGES_BRANCH: gh-pages
          BUILD_DIR: .
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

## Environment Variables
* `PAGES_BRANCH`: The git branch of your repo to which the built static files will be pushed. Default is `gh-pages` branch
* `REPOSITORY`: The target repository to push to. Default is `GITHUB_REPOSITORY`(current repository). Set this variable if you want to deploy to other repo.
* `BUILD_DIR`: The path from the root of the repo where we should run the `zola build` command. Default is `.` (current directory)
* `BUILD_FLAGS`: Custom build flags that you want to pass to zola while building. (Be careful supplying a different build output directory might break the action).
* `BUILD_ONLY`: Set to value `true` if you don't want to deploy after `zola build`.
* `BUILD_THEMES`: Set to false to disable fetching themes submodules. Default `true`.
* `GITHUB_HOSTNAME`: The Github hostname to use in your action. This is to account for Enterprise instances where the base URL differs from the default, which is `github.com`.


## Custom Domain

If you're using a custom domain for your GitHub Pages site put the CNAME 
in `static/CNAME` so that zola puts it in the root of the public folder
which is where GitHub expects it to be.

[zola]: https://github.com/getzola/zola
