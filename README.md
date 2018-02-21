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
- Certificate requests (Certbot)

All machine-variable data (website application code and databases) is stored in Docker volumes. Refer to `docker-compose.yml` for a complete list of used volumes. Docker volumes are reachable on the host by their physical location in `/var/lib/docker/volumes/`.

## Setup

1. Generate new Diffie-Hellman parameters

```bash
$ openssl dhparam -out nginx/dhparams.pem 2048
```

2. Comment out the `ssl_certificate` and `ssl_certificate_key` lines in the NGINX configuration files

3. Start the web server in HTTP-only mode

```bash
$ docker-compose up -d
```

4. Request certificates

```bash
$ ./certbot.sh
```

5. Uncomment the `ssl_certificate` and `ssl_certificate_key` lines in the NGINX configuration files

6. Reload the NGINX configuration

```bash
$ docker kill -s HUP `docker-compose ps -q nginx`
```

7. Set up a cron job to request new certificates every less than three months
