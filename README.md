# Citadel

A self hosted setup powered by docker compose & caddy. 

A passion project, for more details [read this post](https://notes.bharatkalluri.com/2024/08/08/the-self-hosting-dream/).

## Usage
- clone citadel to the home directory ideally. setup some directories for storage
```sh
git clone git@github.com:BharatKalluri/citadel.git ~/citadel
mkdir ~/storage/
```

- copy .env.sample to .env and change values appropriately
```sh
cd ~/citadel
cp .env.sample .env
```

- make sure your DNS has an A record for `*.citadel.<domainname>` set to point to the IP address of the machine. For example, I have an A record against `*.citadel.bharatkalluri.com` to point to the IP address of my machine.

- start caddy, caddy is the reverse proxy of choice. once caddy is up & running, you are ready to install apps
```sh
~/citadel/scripts/install.sh caddy
```

### Installing apps
- you are ready to start installing your apps of choice. For example, let's install a notes app like google keep called `memos`
```sh
~/citadel/scripts/install.sh memos
```

- navigate to `memos.citadel.<domain name>` & you should see a signup page!

### Removing apps

- To remove `memos`

```sh
~/citadel/scripts/remove.sh memos
```

This should delete the corresponding app data, remove the application from the server


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
