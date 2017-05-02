#! /bin/bash

# Wait for MySQL
until $(curl --output /dev/null --silent --head --fail http://$MYSQL_HOST:3306); do
  echo 'Waiting for MySQL...'
  sleep 1
done
echo "MySQL is up and running"