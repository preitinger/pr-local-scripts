#!/bin/sh

workspace=$(realpath "$1")

if [ "${workspace}" = "" ]
then
    echo "usage: $0 <path to project root>"
    exit 1
fi

if [ "${MONGODB_URI}" = "" ]
then
    echo 'It is required that MONGODB_URI is set to a valid connection string.'
    exit 1
fi

project=$(basename $(realpath "${workspace}")) &&

list=$(echo '[' &&
cd "${workspace}/.next/static" && 
find . -type f | sed -r 's/\.(.*)/"\/_next\/static\1",/' &&
( cat ../../local/additionalToCache.txt | sed -r 's/(.*)/"\1",/' ) &&
#cd "${workspace}/app" &&
#find . -name 'page\.tsx' | sed -r 's/^\.(.*)\/page\.tsx$/"\1",/' &&
echo ']') &&

echo "the list is $list" &&
mongosh --eval 'use sw' --eval "db.sw.updateOne({_id:'${project}'}, {\$set: {toCache: ${list}}}, {upsert: true})" ${MONGODB_URI} &&
echo "      $0    -     The End."
