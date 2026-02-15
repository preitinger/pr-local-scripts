#!/bin/sh

pr-local-scripts/script/build-with-sw_pnpm.sh $1 &&
pnpm run start

