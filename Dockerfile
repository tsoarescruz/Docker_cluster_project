FROM ubuntu:18.04
FROM ruby:2.3.3

MAINTAINER Thiago Soares <thiagosoarescruz0@gmail.com>

RUN rm /etc/apt/sources.list
RUN echo "deb http://archive.debian.org/debian/ jessie main" | tee -a /etc/apt/sources.list
RUN echo "deb-src http://archive.debian.org/debian/ jessie main" | tee -a /etc/apt/sources.list
RUN echo "Acquire::Check-Valid-Until false;" | tee -a /etc/apt/apt.conf.d/10-nocheckvalid
RUN echo 'Package: *\nPin: origin "archive.debian.org"\nPin-Priority: 500' | tee -a /etc/apt/preferences.d/10-archive-pin

# Install Build essentials and MySQL client
RUN apt update -qq && apt install -qq --force-yes build-essential \
    libpq-dev libmysqlclient-dev ca-certificates curl tzdata\
    libssl-dev apt-utils nodejs openssh-server openssh-client git redis-server  && \
    # apt autoremove -qq --force-yes && \
    rm -rf /var/lib/apt/lists/*

# Set some config
ENV RAILS_LOG_TO_STDOUT true
ENV RAILS_ENV=development


# CP nginx
COPY nginx/conf.d/nginx.conf /etc/ngnix/nginx.conf/

# RM nginx
RUN rm -f phalanx.nginx

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
RUN bundle install --no-rdoc --no-ri

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

# Start up
#CMD "docker/startup.sh"
