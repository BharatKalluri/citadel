# Citadel

A self hosted setup powered by docker compose & caddy. 

A passion project, for more details [read this post](https://notes.bharatkalluri.com/2024/08/08/the-self-hosting-dream/).

## Setup instructions

- setup env file as per .env.sample
- `source .env`, these env vars decide where the app data is placed and which email should be used to retrieve certificates
- create a docker network called caddy. `docker network create caddy`
- spin up servers using docker compose up command

make sure the domain being setup is pointing is set up to this IP. caddy requires root since it binds to 443 and 8080.

## Vision

- a cli with the following interface
  - `citadel setup`: asks and sets up env vars in `.profile`, uses in all the following docker commands. creates the caddy network. locks down the firewall to only expose 80 & 443 and spins the firewall up.
  - `citadel install com.usememos.memos`: copies the template docker compose file into a `installed_apps` directory with some modifications (as needed). and then starts the docker compose file with the required env variables setup.
  - `citadel auth com.usememos.memos <password>`: adds basic auth in front of the service. ideally have rate limiting & other protections here in place.
  - `citadel stop com.usememos.memos`: stops the corresponding service
  - `citadel remove com.usememos.memos`: spins down the docker compose stack & removes the folder from `installed_apps`
  - `citadel backup`: backs up the entire state including volumes into a particular directory. there will be an app in the app store which can funnel this backup to a service of choice (S3, google drive etc..)
  - `citadel list`: lists all apps available from the origin. `--installed` will only show the installed apps
- run all the apps inside user scope
- manage dependencies for services. allow for apps to read other apps state.
- app store, similar to umbrel app store
- auto scale to another instance if needed. everything works, including backups.
