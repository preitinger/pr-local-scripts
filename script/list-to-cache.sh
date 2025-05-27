#!/bin/sh

workspace=$(realpath "$1")
project=$2
versionMain=$3
versionSub=$4

if [ "${workspace}" = "" -o "${project}" = "" -o "${versionMain}" = "" -o "${versionSub}" = "" ]
then
    echo "usage: $0 <path to project root> <project name> <main version> <sub version>"
    exit 1
fi

if [ "${MONGODB_URI}" = "" ]
then
    echo 'It is required that MONGODB_URI is set to a valid connection string.'
    exit 1
fi

list=$(echo '[' &&

# BEGIN   Would be nice if the chunks were identical when built locally and on vercel which they are not, unfortunately.

# cd "${workspace}/.next/static" && 
# find . -type f | sed -r 's/\.(.*)/"\/_next\/static\1",/' &&

# END

( cat local/additionalToCache.txt | sed -r 's/(.*)/"\1",/' ) &&
#cd "${workspace}/app" &&
#find . -name 'page\.tsx' | sed -r 's/^\.(.*)\/page\.tsx$/"\1",/' &&
echo ']') &&

echo "the list is $list" &&
mongosh --eval 'use sw' --eval "db.sw.updateOne({_id:'${project}v${versionMain}.${versionSub}'}, {\$set: {toCache: ${list}}}, {upsert: true})" ${MONGODB_URI} &&
echo "      $0    -     The End."
