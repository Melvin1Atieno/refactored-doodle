#!/bin/bash
#sets a shell option to immediately exit if any command being run exits with a non-zero exit code. 
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /myapp/tmp/pids/server.pid

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"