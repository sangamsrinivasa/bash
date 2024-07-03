#!/bin/bash

# Define variables
SOURCE_DIR="/path/to/source"
BACKUP_DIR="/path/to/backup"
LOG_FILE="/path/to/backup.log"
DATE=$(date +%Y%m%d_%H%M%S)

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Perform the backup using rsync
rsync -avh --delete "$SOURCE_DIR" "$BACKUP_DIR/$DATE" >> "$LOG_FILE" 2>&1

# Check if rsync was successful
if [ $? -eq 0 ]; then
    echo "Backup successful: $DATE" >> "$LOG_FILE"
else
    echo "Backup failed: $DATE" >> "$LOG_FILE"
fi

