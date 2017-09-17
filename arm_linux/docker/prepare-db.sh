#! /bin/bash

# If database exists, migrate. Otherweise create and seed
#docker-compose run --rm app rake db:reset
docker-compose run --rm app bash -lc 'rake db:reset'
#echo "Done!"
