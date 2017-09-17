#! /bin/bash

#sh bundle.sh
sh scaffold.sh
sh prepare-db.sh
docker-compose up
