# s3cmd

## Usage

Executes s3cmd with arguments listed in the Action's `args`.

```
action "Shell" {
  uses = "jusbrasil/actions-s3cmd/s3cmd@master"
  args = ["ls"]
  secrets = ["ACCESS_KEY", "SECRET_KEY"]
}
```

### Secrets

  * `ACCESS_KEY` AWS Access Key
  * `SECRET_KEY` AWS Secret Key

## License

The Dockerfile and associated scripts and documentation in this project are released under the [MIT License](LICENSE).
