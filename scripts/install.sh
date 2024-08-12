#!/usr/bin/env bash

set -e

# verify that the app exists in the app store
if [ ! -d "$CITADEL_ROOT_DIR/app_store/$1" ]; then
    echo "App $1 not found in app store!"
    exit 1
fi

cp -r "$CITADEL_ROOT_DIR/app_store/$1" "$CITADEL_ROOT_DIR/installed_apps/$1"
cd "$CITADEL_ROOT_DIR/installed_apps/$1"
docker compose up -d
echo "Installed $1!"
