#!/bin/sh

workspace="$1"

if [ "${workspace}" = "" ]
then
    echo "usage: $0 <path to project root>"
    exit 1
fi

cd "${workspace}" &&

curBranch=$(git branch --show-current) &&

if [ "${curBranch}" = "master" ]
then
    git branch -m main
fi &&

curBranch=$(git branch --show-current) &&

if [ ! "${curBranch}" = "main" ]
then
    echo "Nicht in Branch main wie erwartet; breche ab."
    exit 1
fi &&

git switch -c common &&
git push --set-upstream origin common &&
git switch -c local &&
git push --set-upstream origin local

