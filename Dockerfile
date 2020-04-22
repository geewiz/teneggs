FROM ruby:2.6.5

RUN apt-get update -qq && apt-get install -y \
    build-essential

ENV APP_PATH=/app
RUN mkdir $APP_PATH
WORKDIR $APP_PATH

RUN gem install bundler
ADD Gemfile $APP_PATH/Gemfile
ADD Gemfile.lock $APP_PATH/Gemfile.lock
RUN bundle install

ADD . $APP_PATH
