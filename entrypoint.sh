#!/bin/sh

# Jalankan daemon Tailscale di background dengan mode userspace
/app/tailscaled --tun=userspace-networking --socks5-server=localhost:1055 --outbound-http-proxy-listen=localhost:1056 &

# Tunggu beberapa detik agar daemon siap
sleep 3

# Otentikasi ke jaringan Tailscale menggunakan variabel environment
/app/tailscale up --authkey=${TS_AUTHKEY} --hostname=zeabur-app

# Jalankan aplikasi utama Anda
# Ganti baris di bawah ini dengan perintah untuk menjalankan aplikasi Anda
# Contoh untuk Node.js: exec node server.js
# Contoh untuk Python: exec python main.py
echo "Tailscale aktif! Memulai aplikasi utama..."
exec "$@"