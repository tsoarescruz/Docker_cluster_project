FROM ledermann/base
FROM ubuntu:12.04
FROM ruby:2.3.3

MAINTAINER Thiago Soares <thiagosoarescruz0@gmail.com>

RUN apt-get update && \
      apt-get -y install sudo

RUN useradd -m docker && echo "docker:docker" | chpasswd && adduser docker sudo

#USER docker
#RUN docker ALL = NOPASSWD: /sbin/poweroff, /sbin/start, /sbin/stop

# Install MySQL client
RUN sudo apt-get install -y mysql-client && \
    sudo apt-get autoremove -y && \
    sudo rm -rf /var/lib/apt/lists/*

# Workdir
RUN mkdir -p /home/app/docker/wkhtmltopdf

## Install Build essentials
RUN sudo apt-get update -qq && sudo apt-get install -y build-essential libpq-dev nodejs-legacy mysql-client apt-utils

# Install wkhtmltopdf
RUN sudo apt-get install openssl build-essential libssl-dev -y

RUN sudo apt-get update && apt-get install -y libxrender1 libxext6 fonts-lato --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.4/wkhtmltox-0.12.4_linux-generic-amd64.tar.xz
RUN tar xf wkhtmltox-0.12.4_linux-generic-amd64.tar.xz
RUN mv wkhtmltox /home/app/docker/wkhtmltopdf
RUN chmod +x /home/app/docker/wkhtmltopdf

#ADD /docker/wkhtmltopdf/fontconfig.xml /etc/fonts/conf.d/10-wkhtmltopdf.conf

#RUN export TO=`which imgkit | sed 's:/imgkit:/wkhtmltoimage:'` && apt-get install imgkit --install-wkhtmltoimage

# Set some config
ENV RAILS_LOG_TO_STDOUT true

# Workdir
#RUN mkdir -p /home/app
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

#Expose app port
EXPOSE 80 300

ADD /docker/host /etc/hosts

# Save timestamp of image building
RUN date -u > BUILD_TIME

# Start up
#CMD "docker/startup.sh"

