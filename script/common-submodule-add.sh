#!/bin/sh

# Wichtige Voraussetzungen für die Anwendung dieses Skripts:
# branch local in project root (1. Argument)
# Nichts gestaged, sonst wird das mi SUBMODULE ADD mit commitet.
# Sauberer branch main in ${workspace}/../${project}_MAIN

workspace="$1"
submodule="$2"

if [ "${submodule}" = "" ]
then
    echo "usage: $0 <path to project root> <repository to add as submodule in app/_lib/submodules>"
    exit 1
fi

project=$(basename $(realpath ${workspace})) &&
echo "project ${project}" &&
echo "Skip rest while testing" && false &&
cd "${workspace}" &&
ls app && echo 'workspace enthält Verzeichnis app; fahre fort...' || ( echo 'workspace enthält kein Verzeichnis app; bitte Argument 1 überprüfen.' && false ) &&
mkdir -p "app/_lib/submodules" &&
cd "app/_lib/submodules" &&
pwd &&
git submodule add --force ${submodule} &&
git commit -m "SUBMODULE ADD ${submodule}" &&
cd .. &&
rsync -a --exclude='.*' "submodules" "../../../${project}_MAIN/app/_lib/" &&
cd "../../../${project}_MAIN" &&
git switch main && # zur Sicherheit


echo 'The End.' ||
echo 'ERROR'

# TODO Copy ${workspace}/app/_lib/submodules folder without .git files to ${workspace}/../${workspace}_MAIN/app/_lib/
# Then, commit -m 'Copied content of submodules'