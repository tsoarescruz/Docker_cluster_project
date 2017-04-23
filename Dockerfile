FROM ruby:2.3.3
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /phalanx
WORKDIR /phalanx
ADD Gemfile /phalanx/Gemfile
ADD Gemfile.lock /phalanx/Gemfile.lock
RUN bundle install
ADD . /phalanx