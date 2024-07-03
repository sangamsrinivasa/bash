#!/bin/bash

# Define variables
DB_USER="your_db_user"
DB_PASSWORD="your_db_password"
DB_NAME="your_db_name"
BACKUP_DIR="/path/to/backup"
RETENTION_DAYS=7
LOG_FILE="/path/to/db_backup.log"
DATE=$(date +%Y%m%d_%H%M%S)

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Backup the database
mysqldump -u "$DB_USER" -p"$DB_PASSWORD" "$DB_NAME" > "$BACKUP_DIR/$DB_NAME_$DATE.sql"
if [ $? -eq 0 ]; then
    echo "Database backup successful: $DATE" >> "$LOG_FILE"
else
    echo "Database backup failed: $DATE" >> "$LOG_FILE"
    exit 1
fi

# Cleanup old backups
find "$BACKUP_DIR" -type f -name "*.sql" -mtime +$RETENTION_DAYS -exec rm {} \;
if [ $? -eq 0 ]; then
    echo "Old backups cleaned up: $DATE" >> "$LOG_FILE"
else
    echo "Cleanup of old backups failed: $DATE" >> "$LOG_FILE"
fi

