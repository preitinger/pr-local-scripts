#!/bin/sh

workspace="$1"

if [ "${workspace}" = "" ]
then
    echo "usage: $0 <path to project root>"
    exit 1
fi

project=$(basename $(realpath ${workspace})) &&
echo "project ${project}" &&
cd "${workspace}" &&
( ls app && echo 'workspace enthält Verzeichnis app; fahre fort...' || ( echo 'workspace enthält kein Verzeichnis app; bitte Argument 1 überprüfen.' && false ) ) &&

git submodule update --init --recursive &&
echo 'Verzeichnis nach submodule update ...' &&
pwd &&
rm -rf "../${project}_MAIN/app/_lib/submodules" &&
rsync -a --exclude='.*' "app/_lib/submodules" "../${project}_MAIN/app/_lib/" &&
cd "../${project}_MAIN" &&
git switch main && # zur Sicherheit
git add app/_lib/submodules &&
echo 'Before commit of branch "main".' &&
if ! git commit -m 'Copied content of all common submodules from branch local.'
then
    echo "Warnung: commit nicht durchgeführt - in Ordnung nur, wenn ${project}_MAIN sich wirklich nicht geändert hat."
fi &&



echo 'submodules-to-main.sh - The End.' ||
( echo 'submodules-to-main.sh - ERROR' && false )
