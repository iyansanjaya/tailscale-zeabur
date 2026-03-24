#!/bin/sh

# Jalankan daemon Tailscale di background
/app/tailscaled --tun=userspace-networking --socks5-server=localhost:1055 --outbound-http-proxy-listen=localhost:1056 &

# Tunggu sebentar agar daemon siap
sleep 3

# Cek apakah TS_AUTHKEY ada sebelum mencoba login
if [ -z "${TS_AUTHKEY}" ]; then
  echo "GAGAL: Variabel TS_AUTHKEY tidak ditemukan di Zeabur!"
else
  echo "Mencoba login ke Tailscale..."
  /app/tailscale up --authkey=${TS_AUTHKEY} --hostname=zeabur-app
fi

echo "Memulai aplikasi utama..."
exec "$@"