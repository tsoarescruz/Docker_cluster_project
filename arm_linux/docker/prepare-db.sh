#! /bin/bash

# If database exists, migrate. Otherweise create and seed
docker-compose run --rm app bash -lc 'bin/rails db:environment:set RAILS_ENV=development'
docker-compose run --rm app bash -lc 'rake db:reset'
echo "Done!"
