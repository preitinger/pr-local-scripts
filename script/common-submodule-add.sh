#!/bin/sh

# Wichtige Voraussetzungen für die Anwendung dieses Skripts:
# branch local in project root (1. Argument)
# Nichts gestaged, sonst wird das mi SUBMODULE ADD mit commitet.
# Sauberer branch main in ${workspace}/../${project}_MAIN

workspace="$1"
submodule="$2"

if [ "${workspace}" = "" -o "${submodule}" = "" ]
then
    echo "usage: $0 <path to project root> <repository to add as submodule in app/_lib/submodules>"
    exit 1
fi

abs_script_path=$(realpath $(dirname "$0"))
abs_workspace=$(realpath ${workspace})

project=$(basename $(realpath ${workspace})) &&
echo "project ${project}" &&
cd "${workspace}" &&
( ls app && echo 'workspace enthält Verzeichnis app; fahre fort...' || ( echo 'workspace enthält kein Verzeichnis app; bitte Argument 1 überprüfen.' && false ) ) &&
mkdir -p "app/_lib/submodules" &&
cd "app/_lib/submodules" &&
pwd &&
git submodule add --force ${submodule} &&
git commit -m "SUBMODULE ADD ${submodule}" &&
"${abs_script_path}/submodules-to-main.sh" "${abs_workspace}" &&


echo 'common-submodule-add.sh - The End.' ||
( echo 'common-submodule-add.sh - ERROR' && false )
