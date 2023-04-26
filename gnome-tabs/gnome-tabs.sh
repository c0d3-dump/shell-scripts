#!/bin/bash

for i in $@
do
    if test -d ./$i; then
        gnome-terminal --tab -- bash -ic "cd ./$i; exec bash;"
    else
        echo "Directory does not exists: '$i'"
    fi
done