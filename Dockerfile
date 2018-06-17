FROM ruby:2.5.1
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /IMS
WORKDIR /IMS
COPY Gemfile /IMS/Gemfile
COPY Gemfile.lock /IMS/Gemfile.lock
RUN bundle install
COPY . /IMS
