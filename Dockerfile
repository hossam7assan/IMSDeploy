FROM ruby:2.5.1
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /IMSDeploy
WORKDIR /IMSDeploy
COPY Gemfile /IMSDeploy/Gemfile
COPY Gemfile.lock /IMSDeploy/Gemfile.lock
RUN bundle install
COPY . /IMSDeploy
