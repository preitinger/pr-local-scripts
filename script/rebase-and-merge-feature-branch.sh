#!/bin/sh

project="$1"
feature_branch="$2"

if [ "${project}" = "" -o "${feature_branch}" = "" ]
then
    echo "usage: $0 <project name> <feature branch>"
    exit 1
fi


git switch local &&
cd $(dirname $0)/../../../${project}_MAIN &&
git rebase --onto common local "${feature_branch}" &&
git switch common &&
git merge --ff-only "${feature_branch}" &&
git branch -d "${feature_branch}" &&
git switch main &&
git merge common -m 'merge common into main' &&
cd ../${project} &&
git switch local &&
git merge common -m 'merge common into local' &&
echo 'The End' ||
echo 'ERROR!'
