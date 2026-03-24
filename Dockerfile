# Gunakan base image Node.js yang berbasis Alpine
FROM node:20-alpine

# Install dependensi sistem yang dibutuhkan Tailscale
RUN apk update && apk add ca-certificates iptables iproute2 curl

WORKDIR /app
# Unduh dan ekstrak Tailscale
RUN curl -L -O https://pkgs.tailscale.com/stable/tailscale_latest_amd64.tgz && \
    tar xzf tailscale_latest_amd64.tgz --strip-components=1 && \
    rm tailscale_latest_amd64.tgz

# Copy seluruh file aplikasi Anda (package.json, app.js, entrypoint.sh, dll)
COPY . .

# Install dependensi aplikasi Node.js Anda (jika ada package.json)
# Hapus baris ini jika aplikasi Anda tidak butuh npm install
RUN npm install

# Beri izin eksekusi untuk script entrypoint
RUN chmod +x entrypoint.sh

# Jalankan via entrypoint
ENTRYPOINT ["./entrypoint.sh"]

# Pastikan nama file app.js sesuai dengan file utama aplikasi Anda
CMD ["node", "app.js"]