#!/bin/sh

# This script is for setting up a fresh clone of a repository.
# Recommended to copy it into the root directory of the default branch 'main'.

cd $(dirname "$0")
project=$(basename ${PWD})
echo "project ${project}"

git switch local &&
git submodule update --init --recursive &&

pnpm install &&
git worktree add "../${project}_MAIN" main &&
cd "../${project}_MAIN" &&
pnpm install &&
cd - &&



echo 'The End.'