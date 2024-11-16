#!/bin/bash

# Function to execute a Terraform command
run_terraform() {
    local action=$1
    local directory=$2
    terraform -chdir="$directory" $action
}

# Parse arguments
while getopts "a:d:" opt; do
    case $opt in
        a)
            action=$OPTARG
            ;;
        d)
            directory=$OPTARG
            ;;
        *)
            echo "Usage: $0 -a <action> -d <directory>"
            exit 1
            ;;
    esac
done

# Validate input
if [[ -z $action || -z $directory ]]; then
    echo "Both action and directory must be specified."
    exit 1
fi

# Run Terraform command
run_terraform $action "terraform/$directory"
