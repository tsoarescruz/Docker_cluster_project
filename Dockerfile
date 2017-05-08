FROM resin/rpi-raspbian:latest

FROM ruby:2.3.3

MAINTAINER Thiago Soares <thiagosoarescruz0@gmail.com>

# Install MySQL client
#RUN apt-get update && \
#    apt-get install -y mysql-client && \
#    apt-get autoremove -y && \
#    rm -rf /var/lib/apt/lists/*

# Install Build essentials
RUN apt-get update
RUN atp-get -qy install curl ca-certificates
RUN apt-get install -y build-essential
RUN apt-get install -y libpq-dev
RUN apt-get install -y nodejs-legacy
RUN apt-get install -y mysql-client

# Set some config
ENV RAILS_LOG_TO_STDOUT true

# Workdir
RUN mkdir -p /home/app
WORKDIR /home/app

# Install gems
ADD Gemfile* /home/app/
ADD docker /home/app/docker/
RUN bundle install

# Add the Rails app
ADD . /home/app

# Create user and group
RUN groupadd --gid 9999 app && \
    useradd --uid 9999 --gid app app && \
    chown -R app:app /home/app

# Expose app port
EXPOSE 3000 443

# Save timestamp of image building
RUN date -u > BUILD_TIME

# Start up
#CMD "docker/startup.sh"
