#!/bin/bash

# File to store the list of URLs
URL_FILE="urls.txt"

# Check if the required file exists; if not, create it
if [ ! -e "$URL_FILE" ]; then
    touch "$URL_FILE"
fi

# Function to add a URL to the list
add_url() {
    echo "$1" >> "$URL_FILE"
    echo "URL added: $1"
}

# Function to run and open all URLs in the browser
open_urls() {
    while IFS= read -r url; do
        echo "Opening URL: $url"
        # You can modify this command based on your system/browser
        # For example, on Linux with a default web browser:
        xdg-open "$url"
        # For macOS:
        # open "$url"
        # For Windows:
        # start "" "$url"
    done < "$URL_FILE"
}

# Function to list all saved URLs
list_urls() {
    cat "$URL_FILE"
}

# Function to delete a specific URL
delete_url() {
    if [ -z "$1" ]; then
        echo "Usage: $0 delete <url>"
    else
        grep -v "$1" "$URL_FILE" > "$URL_FILE.tmp" && mv "$URL_FILE.tmp" "$URL_FILE"
        echo "URL deleted: $1"
    fi
}

# Main script
case "$1" in
    "add")
        if [ -z "$2" ]; then
            echo "Usage: $0 add <url>"
        else
            add_url "$2"
        fi
        ;;
    "open")
        open_urls
        ;;
    "list")
        list_urls
        ;;
    "delete")
        if [ -z "$2" ]; then
            echo "Usage: $0 delete <url>"
        else
            delete_url "$2"
        fi
        ;;
    *)
        echo "Usage: $0 {add <url> | open | list | delete <url>}"
        ;;
esac
