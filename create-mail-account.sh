#!/usr/bin/env sh

set -e

if [ -z "$1" ]; then
  echo "Uso: ./create-mail-account.sh usuario@dominio.com"
  exit 1
fi

EMAIL="$1"

echo "👉 Criando conta: $EMAIL"
docker exec -it mailserver setup email add "$EMAIL"

echo "✅ Conta criada com sucesso"
