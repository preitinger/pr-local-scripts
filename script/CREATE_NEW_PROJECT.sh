#!/bin/sh

workspace="$1"
project="$2"

if [ "${workspace}" = "" -o "${project}" = "" ]
then
    echo "usage: $0 <workspace> <project name>"
    exit 1
fi


cd ${workspace} &&
npx create-next-app@latest ${project} &&
cd ${project} &&
gh repo create --private --source . --push &&
git switch -c common &&
git push --set-upstream origin common &&
git switch -c local &&
git push --set-upstream origin local &&
git submodule add git@github.com:preitinger/pr-local-scripts.git &&
git commit -m 'add pr-local-scripts' &&
mkdir -p local
touch local/additionalToCache.txt &&
echo "0 0" >local/lastVersion.txt &&
git add local &&
git commit -m 'add local/*' &&
echo '# MONGO_DB_URI=...' >.env.local &&
git worktree add "../${project}_MAIN" main &&
cp .env.*local "../${project}_MAIN" &&
cd "../${project}_MAIN" &&
rm -f .env.local &&
ln -s ../${project}/.env.local &&
npm install &&
cd - &&

printf '\n\n' &&
echo 'Don'\''t forget to ...
- install mongodb and/or bootstrap (see pr-local-scripts/script/install/*)
- edit .env*.local ...
- configure tsconfig.json (i.e. "exactOptionalPropertyTypes": true and/or "noErrorTruncation": true)
- Start a common feature branch with the command `Start common feature branch`.
- Finish it after some commits with the command `Finish common feature branch`.
- Add scripts in package.json like
    "incVersionsBuildStart": "MONGODB_URI=$(pr-local-scripts/script/print_MONGODB_URI.sh) ./pr-local-scripts/script/version-sub-inc_build-with-sw_start.sh pr-scheduler",
    "incVersionsBuild": "MONGODB_URI=$(pr-local-scripts/script/print_MONGODB_URI.sh) ./pr-local-scripts/script/version-sub-inc_build-with-sw.sh pr-scheduler"
' &&


printf "\n\n\n        $0     -    The End.\n\n"