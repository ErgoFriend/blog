workflow "Build and Publish" {
  on = "push"
  resolves = ["Build"]
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
  args = "src:build"
  needs = ["Install"]
}
