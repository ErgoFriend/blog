workflow "Build and Publish" {
  on = "push"
  resolves = ["Deploy to GitHub Pages"]
}

action "Master branch only" {
  uses = "actions/bin/filter@3c0b4f0e63ea54ea5df2914b4fabf383368cd0da"
  args = "branch master"
}

action "Install" {
  uses = "actions/npm@59b64a598378f31e49cb76f27d6f3312b582f680"
  args = "install"
  needs = ["Master branch only"]
}

action "Build" {
  uses = "actions/npm@59b64a598378f31e49cb76f27d6f3312b582f680"
  args = "build"
  needs = ["Install"]
}

action "Deploy to GitHub Pages" {
  uses = "maxheld83/ghpages@v0.2.1"
  needs = ["Build"]
  env = {
    BUILD_DIR = "docs/"
  }
  secrets = [
    "GITHUB_TOKEN",
    "GH_PAT",
  ]
}
