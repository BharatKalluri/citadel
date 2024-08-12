#!/usr/bin/env bash

set -e

# go through all installed apps and run docker compose down
for app in $(ls $INSTALLED_APPS_DIR); do
    cd "$INSTALLED_APPS_DIR/$app"
    echo "Stopping $app"
    docker compose down
done

# create backup directory if it doesn't exist
if [ ! -d "$CITADEL_ROOT_DIR/backup" ]; then
    mkdir "$CITADEL_ROOT_DIR/backup"
fi

# install borgmatic if not installed using apt
if ! command -v borgmatic &>/dev/null; then
    echo "borgmatic not found, installing..."
    sudo apt-get install -y borgmatic
fi

# use tar to zip root directory excluding backup directory and .git directory
tar -czf "$CITADEL_ROOT_DIR/backup/backup-$(date +%Y-%m-%d-%H-%M-%S).tar.gz" --exclude="$CITADEL_ROOT_DIR/backup" --exclude="$CITADEL_ROOT_DIR/.git" "$CITADEL_ROOT_DIR"

# restart all installed_apps
for app in $(ls $INSTALLED_APPS_DIR); do
    cd "$INSTALLED_APPS_DIR/$app"
    echo "Starting $app"
    docker compose up -d
done

echo "Backup complete!"
