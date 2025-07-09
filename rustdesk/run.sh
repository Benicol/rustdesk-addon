#!/usr/bin/with-contenv bashio
# ==============================================================================
# Home Assistant Add-on: RustDesk Server
# Runs RustDesk server
# ==============================================================================

# Read configuration
RELAY_SERVER=$(bashio::config 'relay_server')
ENCRYPTED_ONLY=$(bashio::config 'encrypted_only')
PUBLIC_KEY=$(bashio::config 'public_key')
WEB_CONSOLE_ENABLED=$(bashio::config 'web_console_enabled')
WEB_CONSOLE_USER=$(bashio::config 'web_console_user')
WEB_CONSOLE_PASSWORD=$(bashio::config 'web_console_password')
LOG_LEVEL=$(bashio::config 'log_level')

# Set log level
case "${LOG_LEVEL}" in
    "debug")
        export RUST_LOG="debug"
        ;;
    "info")
        export RUST_LOG="info"
        ;;
    "warn")
        export RUST_LOG="warn"
        ;;
    "error")
        export RUST_LOG="error"
        ;;
    *)
        export RUST_LOG="info"
        ;;
esac

bashio::log.info "Starting RustDesk server..."

# Change to data directory
cd /data

# Generate key if not exists
if [ ! -f "/data/id_ed25519" ]; then
    bashio::log.info "Generating new server key..."
    ssh-keygen -t ed25519 -f /data/id_ed25519 -N ""
fi

# Set up relay server option
RELAY_OPTION=""
if [ -n "${RELAY_SERVER}" ]; then
    RELAY_OPTION="-r ${RELAY_SERVER}"
fi

# Set up encryption option
ENCRYPTION_OPTION=""
if [ "${ENCRYPTED_ONLY}" = "true" ]; then
    ENCRYPTION_OPTION="-e"
fi

# Set up public key option
KEY_OPTION=""
if [ -n "${PUBLIC_KEY}" ]; then
    echo "${PUBLIC_KEY}" > /data/id_ed25519.pub
    KEY_OPTION="-k /data/id_ed25519.pub"
fi

# Start hbbr (relay server) in background
bashio::log.info "Starting RustDesk relay server (hbbr)..."
hbbr &
HBBR_PID=$!

# Start web console if enabled
if [ "${WEB_CONSOLE_ENABLED}" = "true" ]; then
    bashio::log.info "Web console enabled. Username: ${WEB_CONSOLE_USER}"
    WEB_CONSOLE_OPTION="-w ${WEB_CONSOLE_USER}:${WEB_CONSOLE_PASSWORD}"
else
    WEB_CONSOLE_OPTION=""
fi

# Start hbbs (signal server)
bashio::log.info "Starting RustDesk signal server (hbbs)..."
bashio::log.info "Server is ready!"

# Show public key
if [ -f "/data/id_ed25519.pub" ]; then
    PUBLIC_KEY_CONTENT=$(cat /data/id_ed25519.pub)
    bashio::log.info "Public Key: ${PUBLIC_KEY_CONTENT}"
fi

# Execute hbbs with all options
exec hbbs ${RELAY_OPTION} ${ENCRYPTION_OPTION} ${KEY_OPTION} ${WEB_CONSOLE_OPTION}
