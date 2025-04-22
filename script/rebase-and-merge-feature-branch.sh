#!/bin/sh

feature_branch="$1"

if [ "$1" = "" ]
then
    echo "usage: $0 <feature branch>"
    exit 1
fi

git switch local &&
cd $(dirname $0)/../../pr-example-next-private-submodules_MAIN &&
git rebase --onto common local "${feature_branch}" &&
git switch common &&
git merge --ff-only "${feature_branch}" &&
git branch -d "${feature_branch}" &&
git switch main &&
git merge common -m 'merge common into main' &&
cd ../pr-example-next-private-submodules &&
git switch local &&
git merge common -m 'merge common into local' &&
echo 'The End' ||
echo 'ERROR!'
