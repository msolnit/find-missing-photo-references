#!/bin/bash

PHOTOS_LIBRARY="$HOME/Pictures/Photos Library.photoslibrary"
PHOTOS_DB="$PHOTOS_LIBRARY/database/photos.db"
PHOTOS_DB_LOCK="$PHOTOS_DB.lock"

if [ -f "$PHOTOS_DB_LOCK" ]; then
  echo "The photo database is locked.  Please exit the Photos app, wait a few seconds, and try again."
  exit 1
fi

REFERENCE_LIST=$(mktemp)

sqlite3 "$PHOTOS_DB" "select '/' || imagepath from rkmaster where fileIsReference and not isintrash" > $REFERENCE_LIST

while read imagepath
do
  if [ ! -f "$imagepath" ]; then
    echo "$imagepath is missing."
  fi
done < $REFERENCE_LIST

rm $REFERENCE_LIST
