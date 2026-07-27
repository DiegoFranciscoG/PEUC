#!/bin/bash
# 1. Update and install Nginx + Certbot
apt update && apt install nginx certbot python3-certbot-nginx -y

# 2. Create directory for the web app
mkdir -p /var/www/peuc
chown -R www-data:www-data /var/www/peuc

# 3. Create Nginx Server Block with COOP/COEP headers (required for SQLite WASM)
cat << 'EOF' > /etc/nginx/sites-available/peuc
server {
    listen 80;
    listen [::]:80;
    server_name _; # Change this to your domain if you have one, e.g., peuc.com

    root /var/www/peuc;
    index index.html;

    # Headers strictly required for SQLite WASM (SharedArrayBuffer)
    add_header Cross-Origin-Opener-Policy "same-origin" always;
    add_header Cross-Origin-Embedder-Policy "require-corp" always;

    location / {
        try_files $uri $uri/ /index.html;
    }
}
EOF

# 4. Enable the site and restart nginx
ln -sf /etc/nginx/sites-available/peuc /etc/nginx/sites-enabled/
rm -f /etc/nginx/sites-enabled/default
nginx -t && systemctl restart nginx

# 5. Security (SSH Key only, disable root password login)
sed -i 's/^#*PermitRootLogin.*/PermitRootLogin prohibit-password/' /etc/ssh/sshd_config
sed -i 's/^#*PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config
systemctl restart sshd

echo "✅ Servidor Nginx configurado. Cabeceras WASM activas. SSH asegurado."
echo "⚠️ NOTA: Si vas a usar un dominio, edita /etc/nginx/sites-available/peuc y cambia 'server_name _;' por tu dominio, luego corre: certbot --nginx -d tudominio.com"
