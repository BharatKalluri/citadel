#!/usr/bin/env bash

set -e

# verify the app exists in installed_apps
if [ ! -d "$CITADEL_ROOT_DIR/installed_apps/$1" ]; then
    echo "App $1 not found in installed_apps!"
    exit 1
fi

# docker compose down if the app is running
cd "$CITADEL_ROOT_DIR/installed_apps/$1"

docker compose down

# remove the app from installed_apps
rm -rf "$CITADEL_ROOT_DIR/installed_apps/$1"

echo "Removed $1!"
