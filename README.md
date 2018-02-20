# CoCOS

Repository containing the infrastructure code for the CoCOS server.

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
