! /bin/bash

#sh bundle.sh

/bin/bash -l -c "bundle install"
export PATH=$PATH:$HOME/bin:/var/lib/gems/1.8/bin
bundle exec rails s -p 3000 -b '0.0.0.0'
