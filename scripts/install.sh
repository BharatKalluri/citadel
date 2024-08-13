#!/usr/bin/env bash

set -e

# verify if docker network caddy exists, if not create
if [ -z "$(docker network ls --filter name=caddy -q)" ]; then
    echo "Creating docker network since it does not exist: caddy"
    docker network create caddy
fi

# verify that the app exists in the app store
if [ ! -d "$APP_STORE_DIR/$1" ]; then
    echo "App $1 not found in app store!"
    exit 1
fi

# create installed_apps directory if it doesn't exist
if [ ! -d "$INSTALLED_APPS_DIR" ]; then
    mkdir "$INSTALLED_APPS_DIR"
fi

cp -r "$APP_STORE_DIR/$1" "$INSTALLED_APPS_DIR/$1"

# copy contents of app_data from installed apps into the $CITADEL_APP_DATA_DIR
cp -r "$INSTALLED_APPS_DIR/$1/app_data" "$APP_DATA_DIR/$1"

cd "$INSTALLED_APPS_DIR/$1"

# change owner of the app data directory to 1000:1000
chown -R 1000:1000 $APP_DATA_DIR/$1

docker compose up -d
echo "Installed $1!"
