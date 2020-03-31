FROM ruby:2.6.2

RUN apt-get update -qq && apt-get install -y \
  build-essential

RUN mkdir /app
WORKDIR /app

RUN gem install bundler
ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN bundle install

ADD . /app

