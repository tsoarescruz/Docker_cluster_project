#FROM hypriot/rpi-ruby:latest
FROM resin/rpi-raspbian:jessie
#FROM armhf/ubuntu
MAINTAINER Thiago Soares <thiagosoarescruz0@gmail.com>

# Install MySQL client
RUN apt-get update -qq

# Install Build essentials
RUN apt-get update -yq 

RUN apt-get install -y mysql-client build-essential ca-certificates curl build-essential \
    libpq-dev nodejs nodejs-legacy mysql-server libmysqlclient-dev && \
    sudo apt-get autoremove -y && \
    sudo rm -rf /var/lib/apt/lists/*

# Mkdir
RUN mkdir -p /home/app

# Workdir
WORKDIR /home/app/

#Add Docker path
ADD docker /home/app/

#Add sidekiq pid
ADD sidekiq.pid /home/app/tmp/pids/

# ADD gems
ADD Gemfile /home/app/Gemfile
ADD Gemfile.lock /home/app/Gemfile.lock

###### Testes do RVM

# install RVM, Ruby, and Bundler
RUN \curl -sSL https://rvm.io/mpapis.asc | gpg --import -
RUN \curl -L http://get.rvm.io | bash -s stable
RUN /bin/bash -l -c "source /etc/profile.d/rvm.sh"
RUN /bin/bash -l -c "rvm install 2.3.3"
RUN /bin/bash -l -c "gem install bundle --no-ri --no-rdoc"
#RUN /bin/bash -l -c "apt-get install -y rubygems"
#RUN /bin/bash -l -c "gem install rails"

# Workdir
#WORKDIR /home/app/

#Run bundle
RUN /bin/bash -l -c "bundle install"

# Add the Rails app
ADD . /home/app

# Create user and group
RUN groupadd --gid 9999 app
RUN useradd --uid 9999 --gid app app
RUN chown -R app:app /home/app

# Save timestamp of image building
RUN date -u > BUILD_TIME

# Expose app port
EXPOSE 80 3000

