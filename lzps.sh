#!/bin/bash

read -p "Enter commit message (or press Enter to use default): " commit_message

if [ -z "$commit_message" ]; then
    commit_message="pushed with lzps"
fi

git add .

git commit -m "$commit_message"

git push origin main
