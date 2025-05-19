#!/bin/sh

pr-local-scripts/script/version-sub-inc.sh $1 &&
pr-local-scripts/script/build-with-sw-and-start.sh $1 &&

printf '\n    version-sub-inc_build-with-sw_start.sh - The End.\n\n'
