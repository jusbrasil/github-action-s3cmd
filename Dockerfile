FROM ubuntu:xenial

LABEL "name"="s3cmd"
LABEL "maintainer"="Jusbrasil Dev Team <dev@jusbrasil.com.br>"
LABEL "version"="1.0.0"

LABEL "com.github.actions.name"="s3cmd for GitHub Actions"
LABEL "com.github.actions.description"="Runs s3cmd in an Action"
LABEL "com.github.actions.icon"="upload-cloud"
LABEL "com.github.actions.color"="green"

COPY LICENSE README.md /

COPY entrypoint.sh /entrypoint.sh

RUN apt-get update -y && \
	apt-get install -y --no-install-recommends s3cmd && \
	rm -rf /var/lib/apt/lists/* && \
	apt-get clean -y

ENTRYPOINT ["/entrypoint.sh"]
CMD ["--help"]
