#!/usr/bin/env bash

set -e

# verify that the app exists in installed_apps
if [ ! -d "$CITADEL_ROOT_DIR/installed_apps/$1" ]; then
    echo "App $1 not found in installed_apps!"
    exit 1
fi

# docker compose down if the app is running
cd "$CITADEL_ROOT_DIR/installed_apps/$1"
docker compose down

# copy the app from app_store to installed_apps
cp -r "$CITADEL_ROOT_DIR/app_store/$1" "$CITADEL_ROOT_DIR/installed_apps/$1"

# start the app
cd "$CITADEL_ROOT_DIR/installed_apps/$1"
docker compose up -d
