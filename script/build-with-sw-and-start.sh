#!/bin/sh

project=$1

if [ "${project}" = "" ]
then
    echo "usage: $0 <project>"
    exit 1
fi

cd ../serviceWorker-for-pr-push-newsletter3 &&
npm run build && npm run "copy to ${project}" && cd "../${project}" && npm run build+start
