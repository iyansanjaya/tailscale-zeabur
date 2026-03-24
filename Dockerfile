FROM alpine:latest

# Install dependensi dasar jaringan
RUN apk update && apk add ca-certificates iptables iproute2 curl

WORKDIR /app

# Unduh dan ekstrak Tailscale dengan parameter -L agar tidak error
RUN curl -L -O https://pkgs.tailscale.com/stable/tailscale_latest_amd64.tgz && \
    tar xzf tailscale_latest_amd64.tgz --strip-components=1 && \
    rm tailscale_latest_amd64.tgz

# Copy script untuk menjalankan Tailscale
COPY entrypoint.sh .
RUN chmod +x entrypoint.sh

# Eksekusi script
CMD ["./entrypoint.sh"]