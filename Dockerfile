FROM ruby:2.4.1-slim

LABEL maintainer "Charlie McClung <charlie@cmr1.com>"

RUN apt-get update && apt-get install -qq -y --no-install-recommends \
      build-essential nodejs libpq-dev

ENV INSTALL_PATH /blog
RUN mkdir -p $INSTALL_PATH

WORKDIR $INSTALL_PATH

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock

RUN bundle install

COPY . .

ENTRYPOINT [ "./docker-entrypoint.sh" ]

CMD bundle exec puma -C config/puma.rb
