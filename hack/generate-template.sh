#!/bin/bash

# How to update the template from this repository
# cd ~/src/golang-template/services/golang
# rm -rf assets
# cp -r ~/src/myexample ./assets
# cd ./assets
# rm -rf .git
# ./hack/generate-template.sh

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ROOT_DIR=${DIR}/..

if [ -d "${ROOT_DIR}/.git" ]
then
    echo "There is a .git here you probably don't want to run me."
    exit
fi

cd "${ROOT_DIR}" || (echo "Can't cd to ${ROOT_DIR}" && exit)

echo "Checking for hardcoded names"
echo

grep -r myexample . | grep -v hack

PRE_COUNT=$(grep -r myexample . | grep -v -c hack)

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
POST_COUNT=$(grep -r '{{PROJECT}}' . | grep -v -c hack)

echo
echo "Pre: ${PRE_COUNT} Post: ${POST_COUNT}"

if [[ "${PRE_COUNT}" == "${POST_COUNT}" ]]; then
    echo "Self destruct hack dir"
    rm -rf "${ROOT_DIR}/hack"
fi
