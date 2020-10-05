#!/bin/bash

set -e

bundle install
yarn install --check-files --frozen-lockfile

# Remove a potentially pre-existing server.pid for Rails.
rm -f /app/tmp/pids/server.pid

# Run the command.
exec "$@"
