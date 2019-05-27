# CoCOS

Repository containing the infrastructure code for the CoCOS server.

## Infrastructure

The CoCOS server is hosted by IDLab, UGent. It currently consists of one server with the following specs:

- 1x Xeon E5-2640 @ 2.40GHz
- 1G RAM
- 100G disk

The server is reachable at the following locations:

- cocos.atlantis.ugent.be
- cocos.education
- cocos.digital
- 157.193.215.95

The user hosting the applications is `cocos`. This user is the only user capable of remotely logging in, and only using pubkey authentication. The user also has sudo-access (password is the same as the username).

```bash
$ ssh cocos@cocos.atlantis.ugent.be
```

The application code (this repository) is stored in `/home/cocos/cocos/`. It describes a setup based on Docker containers:

- Web server (NGINX)
- PHP server (PHP-FPM)
- Database (MariaDB)

All machine-variable data (website application code and databases) is stored in Docker volumes. Refer to `docker-compose.yml` for a complete list of used volumes. Docker volumes are reachable on the host by their physical location in `/var/lib/docker/volumes/`.

## Setup

1. Start the web server

```bash
$ docker-compose up -d
```

## Update

1. Update the repository

```bash
$ git pull
```

2. Rebuild the images

```bash
$ docker-compose build
```

3. Restart the PHP container

```bash
$ docker-compose up -d --no-deps php
```
