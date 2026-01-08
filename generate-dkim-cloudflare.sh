#!/usr/bin/env sh

set -e

if [ -z "$1" ]; then
  echo "Uso: ./generate-dkim-cloudflare.sh dominio.com"
  exit 1
fi

DOMAIN="$1"
DKIM_FILE="/opt/auto-deploy/mailserver/config/opendkim/keys/$DOMAIN/mail.txt"

echo "👉 Gerando DKIM para $DOMAIN"
docker exec -it mailserver setup config dkim

if [ ! -f "$DKIM_FILE" ]; then
  echo "❌ Arquivo DKIM não encontrado em $DKIM_FILE"
  exit 1
fi

echo
echo "=============================="
echo "➡️  COLE ISSO NO CLOUDFLARE"
echo "=============================="
echo "Tipo: TXT"
echo "Nome: mail._domainkey"
echo -n "Valor: "

# remove aspas, parênteses e quebras de linha
sed -e '1d' \
    -e '$d' \
    -e 's/^[[:space:]]*"//' \
    -e 's/"[[:space:]]*$//' \
    "$DKIM_FILE" | tr -d '\n'

echo
echo "=============================="
echo "✅ DKIM pronto"
