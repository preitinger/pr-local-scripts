#!/bin/sh

project=$1

if [ "${project}" = "" ]
then
    echo "usage: $0 <project>"
    exit 1
fi

if [ -f local/lastVersion.txt ]
then
    echo 'Found local/lastVersion.txt, continue ...'
else
    echo 'FILE NOT FOUND: local/lastVersion.txt'
    exit 1
fi

read main sub <local/lastVersion.txt &&
newMain=${main} &&
newSub=$((sub + 1)) &&
echo "Last version ${main}.${sub}, incrementing to ${newMain}.${newSub}" &&

printf "import { TVersion } from '../submodules/pr-lib-utils/both';

export const VERSION: TVersion = {
    main: ${newMain},
    sub: ${newSub},
};
" >app/_lib/both/version.ts &&

echo "${newMain} ${newSub}" >local/lastVersion.txt &&

printf '\n         The End.\n\n' ||
( echo "       $0      -   ERROR." && false )

