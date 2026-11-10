#!/bin/sh
set -e

# If command starts with an option or "server", prepend minio
if [ "${1}" = "server" ] || [ "${1}" = "minio" ] || [ "${1:0:1}" = "-" ]; then
    if [ "${1}" != "minio" ]; then
        set -- minio "$@"
    fi
fi

exec "$@"
