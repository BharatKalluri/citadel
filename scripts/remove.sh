#!/usr/bin/env bash

set -e

# verify the app exists in installed_apps
if [ ! -d "$INSTALLED_APPS_DIR/$1" ]; then
    echo "App $1 not found in installed_apps!"
    exit 1
fi

# docker compose down if the app is running
cd "$INSTALLED_APPS_DIR/$1"

docker compose down

# remove the app from installed_apps
rm -rf "$INSTALLED_APPS_DIR/$1"

echo "Removed $1!"
