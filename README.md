# Citadel

A self hosted setup powered by docker compose & caddy. 

A passion project, for more details [read this post](https://notes.bharatkalluri.com/2024/08/08/the-self-hosting-dream/).

## Setup

- make sure your DNS has an A record for `*.citadel.<domainname>` set to point to the IP address of the machine. For example, I have an A record against `*.citadel.bharatkalluri.com` to point to the IP address of my machine.

- clone citadel to the home directory. ideally on a fresh install running root.
```sh
git clone https://github.com/BharatKalluri/citadel.git ~/citadel
```

- run the setup script. it will ask some questions & set citadel up. once done, source profile.
```sh
~/citadel/scripts/citadel setup
```

## Usage

### List
- list apps with
```sh
citadel list
```
- installed apps can be shown by
```sh
citadel list --installed
```

### Installing apps
- you are ready to start installing your apps of choice. For example, let's install a notes app like google keep called `memos`
```sh
citadel install memos
```

- navigate to `memos.citadel.<domain name>` & you should see a signup page!

### Removing apps

- To remove `memos`

```sh
citadel remove memos
```

This should delete the corresponding app data, remove the application from the server
