#!/bin/bash

# Check if backup destination is provided
if [ -z "$1" ]; then
  echo "Usage: $0 /path/to/backup/destination"
  exit 1
fi

# Backup destination (e.g., /mnt/backup_drive)
BACKUP_DEST="/Volumes/$1"

CONFIG_FILE=".backup"

if [[ ! -f "$CONFIG_FILE" ]]; then
    echo "Error: '$CONFIG_FILE' does not exist."
    exit 1
fi

mkdir -p "$BACKUP_DEST/Users/guy"

# Rsync options
RSYNC_OPTS="-avh --delete"

while IFS= read -r file; do
    directory=$(dirname "$file")
    filename=$(basename "$file")
  
    DEST="$BACKUP_DEST$directory"

  #  echo "Backup destination: $DEST"
  
    echo "Backing up $file to $DEST"
    rsync $RSYNC_OPTS "$file" "$DEST"
done < "$CONFIG_FILE"

echo "Backup complete."
