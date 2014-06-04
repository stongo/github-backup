#!/bin/bash
ORG="$1"
REPO="$2"
AUTHENTICATION_API_TOKEN="${GITHUB_AUTH_TOKEN:?"must be set and non-empty"}:x-oauth-basic"

read -r -p "Are you sure you want to delete \"$REPO\" repository from \"$1\" on github? [y/N] " response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]
then
    curl -u $AUTHENTICATION_API_TOKEN -X DELETE https://api.github.com/repos/${ORG:?"must be set and non-empty"}/${REPO:?"must be set and non-empty"}
    echo "Repository \"$REPO\" deleted"
else
    echo "You must answer yes to continue. Aborting."
fi