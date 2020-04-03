#!/bin/sh
set -e

sh -c "s3cmd --no-check-certificate --access_key=$ACCESS_KEY --secret_key=$SECRET_KEY --verbose --human-readable-sizes --stop-on-error $*"
