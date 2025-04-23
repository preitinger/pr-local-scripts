#!/bin/sh

submodule="$1"

if [ "${submodule}" = "" ]
then
    echo "usage: $0 <repository to add as submodule in app/_lib/submodules>"
    exit 1
fi

cd "$(dirname "$0")/../.." &&
workspace=${PWD} &&
mkdir -p "${workspace}/app/_lib/submodules" &&
cd "${workspace}/app/_lib/submodules" &&
pwd &&
git submodule add --force ${submodule} &&
git commit -m "SUBMODULE ADD ${submodule}" &&

echo 'The End.'

# TODO Copy ${workspace}/app/_lib/submodules folder without .git files to ${workspace}/../${workspace}_MAIN/app/_lib/
# Then, commit -m 'Copied content of submodules'