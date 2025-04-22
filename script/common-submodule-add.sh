#!/bin/sh

submodule="$1"

if [ "${submodule}" = "" ]
then
    echo "usage: $0 <repository to add as submodule in app/submodules>"
    exit 1
fi

#mkdir -p 