#! /bin/bash

docker-compose run --rm app rails g scaffold note title body:text
#docker-compose run --rm app bash -lc 'rails g scaffold note title body:text'