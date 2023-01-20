#!/bin/bash

### Functions ###

# Dispaly help message
function display_help() {
    echo "Usage: $0 -n name -c color -d description -a api_token -m mode"
    echo ""
    echo "Options:"
    echo " -n, --name          specify label name                            (required)"
    echo " -c, --color         specify label color                           (required)"
    echo " -d, --description   specify label description                     (required)"
    echo " -a, --api-token     specify api token                             (required)"
    echo " -m, --mode          specify the mode value ('create' or 'update') (required)"
    echo " -h, --help          display this help message and exit"
    echo ""
}

# Parse input
function parse_params() {
    TEMP=`getopt -o n:c:d:a:m:h --long name:,color:,description:,api-token:,mode:,help -n 'parse_params' -- "$@"`
    eval set -- "$TEMP"
    while true; do
        case "$1" in
            -n|--name)
                name="$2"
                shift 2
            ;;
            -c|--color)
                color="$2"
                shift 2
            ;;
            -d|--description)
                description="$2"
                shift 2
            ;;
            -a|--api-token)
                api_token="$2"
                shift 2
            ;;
            -m|--mode)
                mode="$2"
                shift 2
            ;;
            -h|--help)
                display_help
                exit 0
            ;;
            --)
                shift
                break
            ;;
            *)
                echo "Internal error!"
                display_help
                exit 1
            ;;
        esac
    done
}

# Check if all required options are provided
function validate_params() {
    if [ -z "$name" ] || [ -z "$color" ] || [ -z "$description" ] || [ -z "$api_token" ]; then
        echo "Error: All options -n, -c, -d, -a, -m are required"
        display_help
        exit 1
    fi
    if [[ "$mode" != "create" && "$mode" != "update" ]]; then
        echo "Error: Invalid mode, options are 'create' or 'update'"
        display_help
        exit 1
    fi
}

# Create a label
function create_label() {
    curl -s \
    -X POST \
    -H "Accept: application/vnd.github+json" \
    -H "Authorization: Bearer $api_token" \
    -H "X-GitHub-Api-Version: 2022-11-28" \
    https://api.github.com/repos/$repo/labels \
    -d "{\"name\": \"$name\", \"description\": \"$description\" , \"color\": \"$color\"}"
}

# Update a label, if it does not exist create it
function update_label() {
    status_code=$(curl -s \
        -X PATCH \
        -H "Accept: application/vnd.github+json" \
        -H "Authorization: Bearer $api_token" \
        -H "X-GitHub-Api-Version: 2022-11-28" \
        https://api.github.com/repos/$repo/labels/$name \
        -d "{\"name\": \"$name\", \"description\": \"$description\" , \"color\": \"$color\"}" \
        --write-out '%{http_code}' \
    --output /dev/null)
    if [ "$status_code" -eq 404 ]; then
        printf "Creating $name label since it was not found in $repo ...\n"
        create_label
    fi
}


### Script ###

parse_params "$@"
validate_params

# Fetch all repositories and keep only their full names (user/repo)
repos=$(curl -s \
    -H "Accept: application/vnd.github+json" \
    -H "Authorization: Bearer $api_token" \
    -H "X-GitHub-Api-Version: 2022-11-28" \
https://api.github.com/user/repos | jq -r '.[].full_name')


# # Create create a label to every repository
for repo in $repos;
do
    if [[ "$mode" == "create" ]]; then
        printf "Creating $name label to $repo ...\n"
        create_label
    else
        printf "Updating $name label to $repo ...\n"
        update_label
    fi
    printf "\n"
done



./label.sh \
-n content \
-c 252a30 \
-d "Blog related" \
-a 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 \
-m update