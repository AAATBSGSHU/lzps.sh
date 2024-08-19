#!/bin/bash

usage() {
    echo "Usage: $0 [-f | -fwl]"
    echo "  -f    Force push (git push -f)"
    echo "  -fwl  Force push with lease (git push --force-with-lease)"
    exit 1
}

if [ "$#" -gt 1 ]; then
    usage
fi

case "$1" in
    -f)
        push_option="--force"
        ;;
    -fwl)
        push_option="--force-with-lease"
        ;;
    "")
        push_option=""
        ;;
    *)
        usage
        ;;
esac

read -p "Enter commit message (or press Enter to use default): " commit_message

if [ -z "$commit_message" ]; then
    commit_message="pushed with lzps"
fi

git add .
git commit -m "$commit_message"

if [ -z "$push_option" ]; then
    git push origin main
else
    git push $push_option origin main
fi
