#!/bin/sh

cat .env.local | awk -f pr-local-scripts/awk/printMongoDbUri.awk
