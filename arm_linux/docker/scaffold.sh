#! /bin/bash

#  Genereate scaffold to project
docker-compose run --rm app bash -lc 'rails g scaffold note title body:text'