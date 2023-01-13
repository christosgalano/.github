#!/bin/bash

# Fetch all repositories and keep only their full names (user/repo)
repos=$(curl \
    -H "Accept: application/vnd.github+json" \
    -H "Authorization: Bearer $1" \
    -H "X-GitHub-Api-Version: 2022-11-28" \
https://api.github.com/user/repos | jq -r '.[].full_name')


# Create a content label to every repository
for repo in $repos;
do
    printf "Creating content label to $repo ...\n"
    curl \
    -X POST \
    -H "Accept: application/vnd.github+json" \
    -H "Authorization: Bearer $1" \
    -H "X-GitHub-Api-Version: 2022-11-28" \
    https://api.github.com/repos/$repo/labels \
    -s -d '{"name":"content","description":"Cloud-on-Rails related","color":"0052cc"}'
    printf "\n\n"
done
