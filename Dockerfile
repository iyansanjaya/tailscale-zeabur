# Gunakan base image yang sesuai dengan aplikasi Anda, contoh: node, python, alpine
FROM alpine:latest

# Install dependensi yang dibutuhkan (contoh menggunakan apk untuk Alpine)
RUN apk update && apk add ca-certificates iptables iproute2 curl

# Unduh dan ekstrak binary Tailscale statis
WORKDIR /app
RUN curl -O https://pkgs.tailscale.com/stable/tailscale_1.60.0_amd64.tgz && \
    tar xzf tailscale_1.60.0_amd64.tgz --strip-components=1 && \
    rm tailscale_1.60.0_amd64.tgz

# Copy file aplikasi Anda dan entrypoint
COPY . .
RUN chmod +x entrypoint.sh

# Atur entrypoint untuk mengeksekusi script kita
ENTRYPOINT ["./entrypoint.sh"]

# Perintah default aplikasi Anda (akan menggantikan "$@" di entrypoint)
CMD ["node", "app.js"]