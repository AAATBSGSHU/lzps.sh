#!/bin/bash

usage() {
    echo "Usage: $0 [-f | -fwl] [commit message]"
    echo "  -f    Force push (git push -f)"
    echo "  -fwl  Force push with lease (git push --force-with-lease)"
    echo "  [commit message]    Optional commit message. If not provided, will prompt."
    exit 1
}

push_option=""
commit_message=""

while [[ "$1" == -* ]]; do
    case "$1" in
        -f)
            push_option="--force"
            shift
            ;;
        -fwl)
            push_option="--force-with-lease"
            shift
            ;;
        *)
            usage
            ;;
    esac
done

if [ -n "$1" ]; then
    commit_message="$*"
fi

if [ -z "$commit_message" ]; then
    read -p "Enter commit message (or press Enter to use default): " commit_message
    if [ -z "$commit_message" ]; then
        commit_message="pushed with lzps"
    fi
fi

git add .
git commit -m "$commit_message"

if [ -z "$push_option" ]; then
    git push origin main
else
    git push $push_option origin main
fi
