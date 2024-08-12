#!/usr/bin/env bash

set -e

# verify if docker network caddy exists, if not create
if [ -z "$(docker network ls --filter name=caddy -q)" ]; then
    echo "Creating docker network since it does not exist: caddy"
    docker network create caddy
fi

# verify that the app exists in the app store
if [ ! -d "$CITADEL_ROOT_DIR/app_store/$1" ]; then
    echo "App $1 not found in app store!"
    exit 1
fi

# create installed_apps directory if it doesn't exist
if [ ! -d "$CITADEL_ROOT_DIR/installed_apps" ]; then
    mkdir "$CITADEL_ROOT_DIR/installed_apps"
fi

cp -r "$CITADEL_ROOT_DIR/app_store/$1" "$CITADEL_ROOT_DIR/installed_apps/$1"
cd "$CITADEL_ROOT_DIR/installed_apps/$1"
docker compose up -d
echo "Installed $1!"
