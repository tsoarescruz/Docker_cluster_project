#! /bin/bash

# If database exists, migrate. Otherweise create and seed
docker-compose run --rm web rake db:reset
#rake db:migrate 2>/dev/null || rake db:setup db:seed
echo "Done!"
