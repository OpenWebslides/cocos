#!/usr/bin/env bash
#
# certbot.sh - Run CertBot to renew Let's Encrypt certificates
#

# Renew certificates
docker-compose -f docker-compose.yml -f docker-compose.certbot.yml run --rm certbot \
  certonly --agree-tos --email florian@floriandejonckheere.be \
  --renew-by-default -n --text --webroot -w /data/letsencrypt/ \
  -d cocos.education \
  -d www.cocos.education \
  -d my.cocos.education \
  -d publications.cocos.education

docker-compose -f docker-compose.yml -f docker-compose.certbot.yml run --rm certbot \
  certonly --agree-tos --email florian@floriandejonckheere.be \
  --renew-by-default -n --text --webroot -w /data/letsencrypt/ \
  -d cocos.digital \
  -d www.cocos.digital

# Reload NGINX configuration
docker-compose exec nginx nginx -s reload
