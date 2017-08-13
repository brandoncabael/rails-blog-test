#!/bin/bash

set -e

DB_HOST=$(echo $DATABASE_URL| cut -d'@' -f 2 | cut -d'/' -f 1);

echo "DB HOST: $DB_HOST"

./wait-for-it.sh ${DB_HOST} --strict --timeout=60

# bundle exec rake db:create
# bundle exec rake db:migrate

exec "$@"