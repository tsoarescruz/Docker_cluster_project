FROM ruby:2.3.3

MAINTAINER Thiago Soares <thiagosoarescruz0@gmail.com>

## Install Build essentials
RUN apt-get update -qq && apt-get install -y build-essential wkhtmltopdf libpq-dev nodejs-legacy mysql-client
#openssl xorg libssl-dev

# Install MySQL client
RUN apt-get update && \
    apt-get install -y mysql-client && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

# Set some config
ENV RAILS_LOG_TO_STDOUT true

# Workdir
RUN mkdir -p /home/app
WORKDIR /home/app

# Add gems
ADD Gemfile* /home/app/

#Add Docker path
ADD docker /home/app/docker/

#Add sidekiq pid
ADD sidekiq.pid /home/app/tmp/pids/

#Run bundle
RUN bundle install

#RUN bash docker/bundle.sh

# Add the Rails app
ADD . /home/app

# Create user and group
RUN groupadd --gid 9999 app && \
    useradd --uid 9999 --gid app app && \
    chown -R app:app /home/app


# Add the nginx site and config
#RUN rm -rf /etc/nginx/sites-available/default
#ADD docker/nginx.conf /etc/nginx/nginx.conf

#Expose app port
EXPOSE 80 3000

# Save timestamp of image building
RUN date -u > BUILD_TIME

# Start up
#CMD "docker/startup.sh"