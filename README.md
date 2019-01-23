# Zola Deploy Action

A GitHub action to automatically build and deploy your [zola] site to the master
branch as GitHub Pages.

## Usage

```
workflow "Build and deploy on push" {
  on = "push"
  resolves = ["zola deploy"]
}

action "zola deploy" {
  uses = "shalzz/zola-deploy-action@master"
  secrets = ["TOKEN"]
}
```

## Secrets

 * `TOKEN`: Personal Access key with the scope `public_repo`, we need this
    to push the site files back to the repo.
    
    ( Actions already provides a `GITHUB_TOKEN` which is an installation token and does not trigger a GitHub Pages builds hence we need a personal access token )

## Custom Domain 

If you're using a custom domain for your GitHub Pages site put the CNAME 
in `static/CNAME` so that zola puts it in the root of the public folder
which is where GitHub expects it to be.

[zola]: https://github.com/getzola/zola
