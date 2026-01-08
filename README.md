# mailserver

Fazer antes no Cloudflare:

1️⃣ DNS no Cloudflare (antes de subir o container)

Entre no Cloudflare → DNS do seu domínio.

🔹 A record
Tipo: A
Nome: mail
Conteúdo: IP_DA_SUA_VPS
Proxy: ❌ DNS only (NÃO pode ser proxy)
TTL: Auto
⚠️ Email não funciona com proxy Cloudflare ligado.

🔹 MX record
Tipo: MX
Nome: seudominio.com
Conteúdo/Host/Server: mail.seudominio.com
Prioridade: 10
TTL: Auto

🔹 SPF (TXT)
Tipo: TXT
Nome: seudominio.com
Valor:
v=spf1 mx -all

🔹 DMARC (TXT)
Tipo: TXT
Nome: _dmarc
Valor:
v=DMARC1; p=none; rua=mailto:postmaster@seudominio.com
