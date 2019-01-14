workflow "Tests" {
  on = "push"
  resolves = ["Shellcheck"]
}

action "Shellcheck" {
  uses = "docker://koalaman/shellcheck:latest"
  args = "./entrypoint.sh"
}
