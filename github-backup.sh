#!/bin/sh

#
# Simple shell script to backup all GitHub repos
# Usage: github-backup.sh <organization>
#

set -ex

ORG="$1"
AUTHENTICATION_API_TOKEN="${GITHUB_AUTH_TOKEN:?"must be set and non-empty"}:x-oauth-basic"
REPOS_API_URL="https://api.github.com/orgs/${ORG}/repos?type=owner"
DATE=$(date +"%Y%m%d")
TEMP_DIR="github_${ORG}_${DATE}"
BACKUP_FILE="${TEMP_DIR}.tgz"

mkdir "$TEMP_DIR" && cd "$TEMP_DIR"
curl -u $AUTHENTICATION_API_TOKEN -s "$REPOS_API_URL" | grep -Eo '"clone_url": "[^"]+"' | awk '{print $2}' | xargs -n 1 git clone --mirror
cd -
tar zcf "$BACKUP_FILE" "$TEMP_DIR"
rm -rf "$TEMP_DIR"

