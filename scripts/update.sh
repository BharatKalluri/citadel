#!/usr/bin/env bash

set -e

# verify that the app exists in installed_apps
if [ ! -d "$INSTALLED_APPS_DIR/$1" ]; then
    echo "App $1 not found in installed_apps!"
    exit 1
fi

# docker compose down if the app is running
cd "$INSTALLED_APPS_DIR/$1"
docker compose down

# copy the app from app_store to installed_apps
cp -r "$APP_STORE_DIR/$1" "$INSTALLED_APPS_DIR/$1"

# start the app
cd "$INSTALLED_APPS_DIR/$1"
docker compose up -d
