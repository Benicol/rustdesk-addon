#!/usr/bin/with-contenv bashio

# Wait for RustDesk server to be ready
bashio::log.info "Waiting for RustDesk server to be ready..."

# Check if hbbs is running
while ! pgrep -f "hbbs" > /dev/null; do
    sleep 1
done

# Check if hbbr is running  
while ! pgrep -f "hbbr" > /dev/null; do
    sleep 1
done

bashio::log.info "RustDesk server is ready!"

# Show connection information
if [ -f "/data/id_ed25519.pub" ]; then
    PUBLIC_KEY=$(cat /data/id_ed25519.pub)
    bashio::log.info "======================================"
    bashio::log.info "RustDesk Server Connection Information"
    bashio::log.info "======================================"
    bashio::log.info "Server Address: $(hostname -I | awk '{print $1}')"
    bashio::log.info "Public Key: ${PUBLIC_KEY}"
    bashio::log.info "======================================"
    bashio::log.info "Configure your RustDesk clients with the above information"
fi

# Show web console information if enabled
WEB_CONSOLE_ENABLED=$(bashio::config 'web_console_enabled')
if [ "${WEB_CONSOLE_ENABLED}" = "true" ]; then
    WEB_CONSOLE_USER=$(bashio::config 'web_console_user')
    SERVER_IP=$(hostname -I | awk '{print $1}')
    bashio::log.info "======================================"
    bashio::log.info "Web Console Access"
    bashio::log.info "======================================"
    bashio::log.info "HTTP:  http://${SERVER_IP}:21118"
    bashio::log.info "HTTPS: https://${SERVER_IP}:21119"
    bashio::log.info "Username: ${WEB_CONSOLE_USER}"
    bashio::log.info "======================================"
fi
