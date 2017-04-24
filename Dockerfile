FROM ruby:2.3.3
MAINTAINER Thiago Soares <thiagosoarescruz0@gmail.com>

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs-legacy mysql-client
RUN mkdir /phalanx
WORKDIR /phalanx

COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install --jobs 20 --retry 5
COPY . ./
EXPOSE 3000

ADD Gemfile /phalanx/Gemfile
ADD Gemfile.lock /phalanx/Gemfile.lock
RUN bundle install
ADD . /phalanx

#RUN RAILS_ENV=production bundle exec rake assets:precompile --trace
#CMD ["rails","server","-b","0.0.0.0"]

#CMD ["bundle", "exec", "rails", "db:reset"]
#CMD ["bundle", "exec", "rails", "s" "-p 3000", "-b", "0.0.0.0"]
