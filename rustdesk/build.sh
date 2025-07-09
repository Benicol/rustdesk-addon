#!/usr/bin/with-contenv bashio

bashio::log.info "Building RustDesk Server add-on..."

# Build configuration
CONFIG_PATH=/data/options.json

# Validate configuration
if bashio::config.has_value 'web_console_password'; then
    if [ ${#bashio::config 'web_console_password'} -lt 6 ]; then
        bashio::log.fatal "Web console password must be at least 6 characters long!"
        bashio::exit.nok
    fi
fi

# Check if required ports are available
for port in 21115 21116 21117 21118 21119; do
    if ! bashio::net.port_available ${port}; then
        bashio::log.warning "Port ${port} is already in use. This may cause issues."
    fi
done

bashio::log.info "Build completed successfully!"
