#!/bin/sh

# 1. Jalankan mesin Tailscale di latar belakang
/app/tailscaled --tun=userspace-networking --socks5-server=localhost:1055 &

# 2. Tunggu 3 detik agar mesin siap
sleep 3

# 3. Otentikasi dan iklankan sebagai Exit Node
/app/tailscale up --authkey=${TS_AUTHKEY} --hostname=zeabur-vpn --advertise-exit-node

echo "Tailscale VPN siap dan berjalan!"

# 4. Tahan container agar terus hidup dan menjaga koneksi VPN
tail -f /dev/null