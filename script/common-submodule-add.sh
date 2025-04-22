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