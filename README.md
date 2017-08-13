# README

## Docker usage

#### First time
```bash
# Build docker images for docker-compose
docker-compose build

# Create postgres database
docker-compose run blog bundle exec rake db:create

# Migrate database schema (if needed)
docker-compose run blog bundle exec rake db:migrate

# Run docker containers
docker-compose up
```

Visit http://localhost:3000

#### Subsequent runs
```bash
docker-compose up # Runs the current version of the docker images

docker-compose up --build # Rebuild & run (use this if Dockerfile changes)
```

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
