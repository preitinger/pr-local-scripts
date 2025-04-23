#!/bin/sh

workspace="$1"
feature_branch="$2"

if [ "${workspace}" = "" -o "${feature_branch}" = "" ]
then
    echo "usage: $0 <path to project workspace> <feature branch>"
    exit 1
fi

project=$(basename $(realpath "${workspace}")) &&
echo "workspace ${workspace}" &&
echo "feature_branch ${feature_branch}" &&
echo "project ${project}" &&
cd "${workspace}" &&
ls app && echo 'workspace enthält Verzeichnis app; fahre fort...' || ( echo 'workspace enthält kein Verzeichnis app; bitte Argument 1 überprüfen.' && false ) &&
echo 'Breche for git switch local ab zu Testzwicken' && false &&

git switch local &&
cd /../${project}_MAIN &&
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
