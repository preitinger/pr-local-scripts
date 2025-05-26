#!/bin/sh

project=$1

if [ "${project}" = "" ]
then
    echo "usage: $0 <project>"
    exit 1
fi

# Pre-check the following for list-to-cache.sh already here, so that no needless build is done.
if [ "${MONGODB_URI}" = "" ]
then
    echo 'It is required that MONGODB_URI is set to a valid connection string.'
    exit 1
fi

cd ../serviceWorker-for-pr-push-newsletter3 &&
npm run build && npm run "copy to ${project}" && cd "../${project}" && npm run build &&
pr-local-scripts/script/list-to-cache.sh .
