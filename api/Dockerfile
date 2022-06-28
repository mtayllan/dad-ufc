FROM ruby:3.1.2-slim

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev

RUN mkdir /myapp
WORKDIR /myapp

COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock

RUN bundle install

# Copy the whole app
COPY . /myapp
