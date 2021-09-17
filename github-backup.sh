#!/bin/sh

#
# Simple shell script to backup all GitHub repos
# Usage: github-backup.sh <organization>
#

set -ex

on_exit()
{
    if [ ! -z $TEMP_DIR ] && [ -d $TEMP_DIR ]; then
        rm -rf $TEMP_DIR
    fi
}

trap on_exit EXIT

ORG="$1"
AUTHENTICATION_API_TOKEN="${GITHUB_AUTH_TOKEN:?"must be set and non-empty"}:x-oauth-basic"
REPOS_API_URL="https://api.github.com/orgs/${ORG}/repos?type=owner"
DATE=$(date +"%Y%m%d")
TEMP_DIR=`mktemp -d`
BACKUP_FILE="`pwd`/github_${ORG}_${DATE}.tgz"
cd "$TEMP_DIR"
curl -u $AUTHENTICATION_API_TOKEN -s "$REPOS_API_URL" | grep -Eo '"clone_url": "[^"]+"' |\
 awk '{print $2}' | sed s"#\"https://#\"https://$GITHUB_AUTH_TOKEN@#" | xargs -n 1 git clone --mirror

tar zcf "$BACKUP_FILE" -C "$TEMP_DIR" .