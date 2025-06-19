#!/bin/sh

DIRS=""
COMMAND_TO_RUN=""

while [ "$#" -gt 0 ]; do
  key="$1"
  case "$key" in
    --cmd)
      COMMAND_TO_RUN="$2"
      shift
      shift
      ;;
    *)
      DIRS="$DIRS \"$1\""
      shift
      ;;
  esac
done

if [ -z "$DIRS" ]; then
    echo "Error: No directories specified."
    echo "Usage: $0 <dir1> <dir2> ... [--cmd \"command to run\"]"
    exit 1
fi

eval set -- $DIRS
for dir in "$@"; do
    # Check if the directory actually exists.
    if [ -d "./$dir" ]; then
        if [ -n "$COMMAND_TO_RUN" ]; then
            BASH_CMD="cd './$dir'; echo '>>> Running command: $COMMAND_TO_RUN'; $COMMAND_TO_RUN; exec bash"
        else
            BASH_CMD="cd './$dir'; exec bash"
        fi
        gnome-terminal --tab -- bash -ic "$BASH_CMD"
    else
        echo "Directory does not exist: '$dir'"
    fi
done