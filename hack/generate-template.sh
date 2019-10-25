#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ROOT_DIR=${DIR}/..

if [ -d "${ROOT_DIR}/.git" ]
then
    echo "There is a .git here you probably don't want to run me."
    exit
fi

cd ${ROOT_DIR}

echo "Checking for hardcoded names"
echo

grep -r myexample . | grep -v hack

PRE_COUNT=$(grep -r myexample . | grep -v hack | wc -l |xargs)

find . \( -type d -name .git -prune \) -or \( -type d -name hack -prune \) -o -type f -exec \
    sed -i ''  -e "s#github.com/metcalfc/myexample#github.com/{{GITHUB_ORG}}/myexample#g" {} \;
find . \( -type d -name .git -prune \) -or \( -type d -name hack -prune \) -o -type f -exec \
    sed -i ''  -e "s#metcalfc/myexample#{{HUB_USER}}/myexample#g" {} \;
find . \( -type d -name .git -prune \) -or \( -type d -name hack -prune \) -o -type f -exec \
    sed -i ''  -e "s/myexample/{{PROJECT}}/g" {} \;

echo
echo "Checking for now templated names"
echo
grep -r "{{PROJECT}}" . | grep -v hack
POST_COUNT=$(grep -r {{PROJECT}} . | grep -v hack | wc -l | xargs)

echo
echo "Pre: ${PRE_COUNT} Post: ${POST_COUNT}"

if [[ "${PRE_COUNT}" == "${POST_COUNT}" ]]; then
    echo "Self destruct hack dir"
    rm -rf $ROOT_DIR/hack
fi
