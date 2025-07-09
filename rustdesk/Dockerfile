# Build arguments
ARG BUILD_FROM=ghcr.io/hassio-addons/base:15.0.7

# https://developers.home-assistant.io/docs/add-ons/configuration#add-on-dockerfile
FROM $BUILD_FROM

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install dependencies
RUN \
    apk add --no-cache \
        curl \
        jq \
        bash \
        unzip \
        openssh-keygen

# Setup base directories
RUN mkdir -p /data

# Copy run script
COPY run.sh /
COPY healthcheck.sh /
RUN chmod a+x /run.sh /healthcheck.sh

# Download and install RustDesk server based on architecture
RUN \
    case "$(uname -m)" in \
        x86_64) ARCH="x86_64" ;; \
        aarch64) ARCH="aarch64" ;; \
        armv7l) ARCH="armv7" ;; \
        i686) ARCH="i686" ;; \
        *) echo "Unsupported architecture: $(uname -m)" && exit 1 ;; \
    esac \
    && RUSTDESK_VERSION="1.1.10-3" \
    && echo "Downloading RustDesk server for architecture: ${ARCH}" \
    && curl -fsSL "https://github.com/rustdesk/rustdesk-server/releases/download/${RUSTDESK_VERSION}/rustdesk-server-linux-${ARCH}.zip" \
        -o /tmp/rustdesk-server.zip \
    && unzip /tmp/rustdesk-server.zip -d /opt/ \
    && rm /tmp/rustdesk-server.zip \
    && chmod +x /opt/rustdesk-server-linux-${ARCH}/* \
    && ln -s /opt/rustdesk-server-linux-${ARCH}/hbbs /usr/local/bin/hbbs \
    && ln -s /opt/rustdesk-server-linux-${ARCH}/hbbr /usr/local/bin/hbbr

# Labels
LABEL \
    io.hass.name="RustDesk Server" \
    io.hass.description="Run a RustDesk server for remote desktop connections" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version="${BUILD_VERSION}" \
    maintainer="Home Assistant Community" \
    org.opencontainers.image.title="RustDesk Server" \
    org.opencontainers.image.description="Run a RustDesk server for remote desktop connections" \
    org.opencontainers.image.vendor="Home Assistant Community Add-ons" \
    org.opencontainers.image.authors="Home Assistant Community" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.url="https://github.com/rustdesk/rustdesk-server" \
    org.opencontainers.image.source="https://github.com/yourusername/rustdesk-addon"

# Expose ports
EXPOSE 21115 21116 21117 21118 21119

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
    CMD /healthcheck.sh

# Run
CMD [ "/run.sh" ]
