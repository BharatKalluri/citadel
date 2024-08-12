# go through all installed apps and run docker compose down
for app in $(ls $CITADEL_ROOT_DIR/installed_apps); do
    cd "$CITADEL_ROOT_DIR/installed_apps/$app"
    echo "Stopping $app"
    docker compose down
done

echo "will run backup"

# restart all installed_apps
for app in $(ls $CITADEL_ROOT_DIR/installed_apps); do
    cd "$CITADEL_ROOT_DIR/installed_apps/$app"
    echo "Starting $app"
    docker compose up -d
done

echo "Backup complete!"
