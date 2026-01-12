# Zola Deploy Action

[![Build Status](https://img.shields.io/endpoint.svg?url=https%3A%2F%2Factions-badge.atrox.dev%2Fshalzz%2Fzola-deploy-action%2Fbadge&style=flat)](https://actions-badge.atrox.dev/shalzz/zola-deploy-action/goto)
![GitHub release (latest SemVer)](https://img.shields.io/github/v/release/shalzz/zola-deploy-action?sort=semver)

A GitHub action to automatically build and deploy your [zola] site to the master
branch as GitHub Pages.

## Table of Contents

 - [Usage](#usage)
 - [Environment Variables](#environment-variables)
 - [Custom Domain](#custom-domain)

## Usage

In your repository **Settings > Actions > General**, in Workflow permissions, make sure that `GITHUB_TOKEN` has **Read and Write permissions**.

This example will build and deploy to gh-pages on push to the main branch.

```yml
name: Zola on GitHub Pages

on: 
 push:
  branches:
   - main

jobs:
  build:
    name: Publish site
    runs-on: ubuntu-latest
    steps:
    - name: Checkout main
      uses: actions/checkout@v4
    - name: Build and deploy
      uses: shalzz/zola-deploy-action@v0.22.0
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

This example will build and deploy to gh-pages branch on a push to the main branch, 
and it will build only on pull requests.
```yml
name: Zola on GitHub Pages

on:
  push:
    branches:
      - main
  pull_request:

jobs:
  build:
    runs-on: ubuntu-latest
    if: github.ref != 'refs/heads/main'
    steps:
      - name: Checkout main
        uses: actions/checkout@v4
      - name: Build only
        uses: shalzz/zola-deploy-action@v0.22.0
        env:
          BUILD_DIR: docs
          BUILD_ONLY: true
          BUILD_FLAGS: --drafts
          # A GitHub token is not necessary when BUILD_ONLY is true
          # GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}

  build_and_deploy:
    runs-on: ubuntu-latest
    if: github.ref == 'refs/heads/main'
    steps:
      - name: Checkout main
        uses: actions/checkout@v4
      - name: Build and deploy
        uses: shalzz/zola-deploy-action@v0.22.0
        env:
          BUILD_DIR: docs
          PAGES_BRANCH: gh-pages
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

## Environment Variables
* `PAGES_BRANCH`: The git branch of your repo to which the built static files will be pushed. Default is `gh-pages` branch
* `REPOSITORY`: The target repository to push to. Default is `GITHUB_REPOSITORY`(current repository). Set this variable if you want to deploy to other repo.
* `BUILD_DIR`: The path from the root of the repo where we should run the `zola build` command. Default is `.` (current directory)
* `OUT_DIR`: The build output directory of `zola build`. Default is `public`
* `BUILD_FLAGS`: Custom build flags that you want to pass to zola while building. (Be careful supplying a different build output directory might break the action).
* `BUILD_ONLY`: Set to value `true` if you don't want to deploy after `zola build`.
* `BUILD_THEMES`: Set to false to disable fetching themes submodules. Default `true`.
* `CHECK_LINKS`: Set to `true` to check links with `zola check`.
* `CHECK_FLAGS`: Custom check flags that you want to pass to `zola check`.
* `GITHUB_HOSTNAME`: The Github hostname to use in your action. This is to account for Enterprise instances where the base URL differs from the default, which is `github.com`.


## Custom Domain

If you're using a custom domain for your GitHub Pages site put the CNAME 
in `static/CNAME` so that zola puts it in the root of the public folder
which is where GitHub expects it to be.

[zola]: https://github.com/getzola/zola

##

Thanks and enjoy your day!

<a href="https://www.buymeacoffee.com/shaleen"><img src="https://img.buymeacoffee.com/button-api/?text=Buy me a Beer&emoji=🍺&slug=shaleen&button_colour=40DCA5&font_colour=ffffff&font_family=Bree&outline_colour=000000&coffee_colour=FFDD00" /></a>
