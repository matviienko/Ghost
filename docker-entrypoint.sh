#!/bin/bash
set -e

npm install

# grunt symlink --skip-update

grunt init --skip-update

exec "$@"