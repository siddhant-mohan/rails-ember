#!/bin/bash
if hash wget 2>/dev/null; then          # suppressing error in case of command not found
  echo "downloading with wget"
else
  echo "could not find wget command exiting"
  exit 1
fi

script_dir=`dirname $0`

cd $script_dir/vendor/scripts/production
echo "updating production environment"
wget http://builds.emberjs.com/beta/ember-data.prod.js
wget http://builds.emberjs.com/release/ember.prod.js
mv ember.prod.js.1 ember.prod.js
mv ember-data.prod.js.1 ember-data.prod.js
echo "updated production environment"

cd ../development
echo "updating development environment"
wget http://builds.emberjs.com/release/ember.js
wget http://builds.emberjs.com/beta/ember-data.js
mv ember.js.1 ember.js
mv ember-data.js.1 ember-data.js
echo "updated development environment"

