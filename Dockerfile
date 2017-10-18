FROM ledermann/base
FROM ubuntu:12.04
FROM ruby:2.3.3

MAINTAINER Thiago Soares <thiagosoarescruz0@gmail.com>

## Install Build essentials
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs-legacy mysql-client \
libssl-dev apt-utils

# Install MySQL client
RUN apt-get update && \
      apt-get -y install sudo

RUN useradd -m docker && echo "docker:docker" | chpasswd && adduser docker sudo

#USER docker
#RUN docker ALL = NOPASSWD: /sbin/poweroff, /sbin/start, /sbin/stop

# Install MySQL client
RUN sudo apt-get install -y mysql-client && \
    sudo apt-get autoremove -y && \
    sudo rm -rf /var/lib/apt/lists/*


# Set some config
ENV RAILS_LOG_TO_STDOUT true

# Mkdir
RUN mkdir -p /home/app

# Workdir
WORKDIR /home/app/

#Add Docker path
ADD docker /home/app/

WORKDIR /home/app

# ADD gems
ADD Gemfile /home/app/Gemfile
ADD Gemfile.lock /home/app/Gemfile.lock

#Add sidekiq pid
ADD sidekiq.pid /home/app/tmp/pids/

#Run bundle
RUN bundle install

# Add the Rails app
ADD . /home/app

# Create user and group
RUN groupadd --gid 9999 app && \
    useradd --uid 9999 --gid app app && \
    chown -R app:app /home/app

#Expose app port
EXPOSE 80 300 9000

# Save timestamp of image building
RUN date -u > BUILD_TIME

#ADD /docker/host /etc/hosts

# Start up
#CMD "docker/startup.sh"