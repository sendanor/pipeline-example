#!/bin/bash
# USAGE: ./pipeline-script.sh WORK_DIR OUTPUT_FILE [SLEEP_TIME]

WORK_DIR="$1"
OUTPUT_FILE="$2"

if test 0 -lt "$3"; then
  SLEEP_TIME="$3"
else
  SLEEP_TIME=3
fi

set -e

if test -d "$WORK_DIR"; then
  :
else
  echo 'ERROR: Work directory does not exist: '"$WORK_DIR" >&2
  exit 1
fi

if test -e "$WORK_DIR/$OUTPUT_FILE"; then
  :
else

  # Wait for the file to exist
  if which inotifywait; then
    while read i; do if [ "$i" = "$OUTPUT_FILE" ]; then break; fi; done \
       < <(inotifywait  -e create,open --format '%f' --quiet "$WORK_DIR" --monitor)
  else
    while test ! -e "$WORK_DIR/$OUTPUT_FILE"; do sleep "$SLEEP_TIME"; done
  fi

fi

echo "$WORK_DIR/$OUTPUT_FILE"

