#!/bin/sh

workspace="$1"
submodule="$2"

if [ "${submodule}" = "" ]
then
    echo "usage: $0 <path to project root> <repository to add as submodule in app/_lib/submodules>"
    exit 1
fi

cd "${workspace}" &&
ls app && echo 'workspace enthält Verzeichnis app; fahre fort...' || ( echo 'workspace enthält kein Verzeichnis app; bitte Argument 1 überprüfen.' && false ) &&
workspace=${PWD} &&
mkdir -p "${workspace}/app/_lib/submodules" &&
cd "${workspace}/app/_lib/submodules" &&
pwd &&
git submodule add --force ${submodule} &&
git commit -m "SUBMODULE ADD ${submodule}" &&

echo 'The End.' ||
echo 'ERROR'

# TODO Copy ${workspace}/app/_lib/submodules folder without .git files to ${workspace}/../${workspace}_MAIN/app/_lib/
# Then, commit -m 'Copied content of submodules'