docker run --rm \
  -v /opt/auto-deploy/mailserver/certs:/etc/letsencrypt \
  -v /opt/auto-deploy/mailserver/cloudflare.ini:/cloudflare.ini:ro \
  certbot/dns-cloudflare certonly \
  --dns-cloudflare \
  --dns-cloudflare-credentials /cloudflare.ini \
  -d mail.thiagosol.com \
  --agree-tos \
  -m contato@thiagosol.com \
  --non-interactive

CERT_DIR="$(ls -d /opt/auto-deploy/mailserver/certs/live/mail.thiagosol.com* | head -n 1)"

sudo cp "$CERT_DIR/fullchain.pem" /opt/auto-deploy/mailserver/secrets/tls/mail.thiagosol.com-cert.pem
sudo cp "$CERT_DIR/privkey.pem"   /opt/auto-deploy/mailserver/secrets/tls/mail.thiagosol.com-key.pem

sudo chmod 644 /opt/auto-deploy/mailserver/secrets/tls/mail.thiagosol.com-cert.pem
sudo chmod 600 /opt/auto-deploy/mailserver/secrets/tls/mail.thiagosol.com-key.pem

docker-compose restart mailserver