#!/bin/bash

set -e

./wait-for-it.sh ${DATABASE_HOST}:${DATABASE_PORT} --strict --timeout=60

# bundle exec rake db:create
# bundle exec rake db:migrate

exec "$@"