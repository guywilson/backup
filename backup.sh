#!/bin/bash

# Check if backup destination is provided
if [ -z "$1" ]; then
  echo "Usage: $0 /path/to/backup/destination"
  exit 1
fi

# Backup destination (e.g., /mnt/backup_drive)
BACKUP_DEST="/Volumes/$1"

mkdir -p "$BACKUP_DEST/Users/guy"

# List of directories to back up
SOURCE_DIRS=(
  "/Users/guy/.ssh"
  "/Users/guy/.gnupg"
  "/Users/guy/.local"
  "/Users/guy/.pfm"
  "/Users/guy/.pico-sdk"
  "/Users/guy/.viminfo"
  "/Users/guy/.vscode"
  "/Users/guy/.zprofile"
  "/Users/guy/.zshrc"
  "/Users/guy/Applications"
  "/Users/guy/development"
  "/Users/guy/playground"
  "/Users/guy/keep"
  "/usr"
  "/Applications"
  "/opt"
)

# Rsync options
RSYNC_OPTS="-avhr --delete"

# Iterate over each source directory
for SRC in "${SOURCE_DIRS[@]}"; do
  DEST="$BACKUP_DEST$SRC"

  echo "Backing up $SRC to $DEST"
  rsync $RSYNC_OPTS "$SRC/" "$DEST/"
done

echo "Backup complete."
