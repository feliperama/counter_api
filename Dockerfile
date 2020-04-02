FROM ruby:2.6.2

RUN apt-get install -y curl

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs postgresql-client

RUN mkdir /app

WORKDIR /app

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock

RUN gem update --system
RUN gem install bundler

# Workaround while Bundler is not patched:
# https://github.com/bundler/bundler/issues/7494
ENV PATH $GEM_HOME/bin:$BUNDLE_PATH/ruby/${RUBY_MAJOR}.0/bin:$PATH
ENV GEM_PATH $GEM_HOME:$BUNDLE_PATH/ruby/${RUBY_MAJOR}.0

RUN bundle install -j4

COPY . .

EXPOSE 3000

ENTRYPOINT "/app/entrypoint.sh"
