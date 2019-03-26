workflow "Build and Publish" {
  on = "push"
  resolves = "Docker Publish"
}

action "Shell Lint" {
  uses = "actions/bin/shellcheck@master"
  args = "entrypoint.sh"
}

action "Docker Lint" {
  uses = "docker://replicated/dockerfilelint"
  args = ["Dockerfile"]
}

action "Build" {
  needs = ["Shell Lint", "Docker Lint"]
  uses = "actions/docker/cli@master"
  args = "build -t s3cmd-action ."
}

action "Docker Run" {
  needs = ["Build"]
  uses = "actions/docker/cli@master"
  args = "run -t s3cmd-action"
}

action "Docker Tag" {
  needs = ["Build"]
  uses = "actions/docker/tag@master"
  args = "s3cmd-action jusbrasil/s3cmd-action --no-latest"
}

action "Publish Filter" {
  needs = ["Build"]
  uses = "actions/bin/filter@master"
  args = "branch master"
}

action "Docker Login" {
  needs = ["Publish Filter"]
  uses = "actions/docker/login@master"
  secrets = ["DOCKER_USERNAME", "DOCKER_PASSWORD"]
}

action "Docker Publish" {
  needs = ["Docker Run", "Docker Tag", "Docker Login"]
  uses = "actions/docker/cli@master"
  args = "push jusbrasil/s3cmd-action"
}

action "S3cmd" {
  uses = "./"
  args = ["ls"]
  secrets = ["ACCESS_KEY", "SECRET_KEY"]
}
