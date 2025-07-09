# Build arguments
ARG BUILD_FROM
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_DESCRIPTION
ARG BUILD_NAME
ARG BUILD_REF
ARG BUILD_REPOSITORY
ARG BUILD_VERSION

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
    case "${BUILD_ARCH}" in \
        amd64) ARCH="x86_64" ;; \
        aarch64) ARCH="aarch64" ;; \
        armv7) ARCH="armv7" ;; \
        armhf) ARCH="armv7" ;; \
        i386) ARCH="i686" ;; \
        *) echo "Unsupported architecture: ${BUILD_ARCH}" && exit 1 ;; \
    esac \
    && RUSTDESK_VERSION="1.1.10-3" \
    && echo "Downloading RustDesk server for architecture: ${ARCH} (BUILD_ARCH: ${BUILD_ARCH})" \
    && curl -fsSL "https://github.com/rustdesk/rustdesk-server/releases/download/${RUSTDESK_VERSION}/rustdesk-server-linux-${ARCH}.zip" \
        -o /tmp/rustdesk-server.zip \
    && unzip /tmp/rustdesk-server.zip -d /opt/ \
    && rm /tmp/rustdesk-server.zip \
    && chmod +x /opt/rustdesk-server-linux-${ARCH}/* \
    && ln -s /opt/rustdesk-server-linux-${ARCH}/hbbs /usr/local/bin/hbbs \
    && ln -s /opt/rustdesk-server-linux-${ARCH}/hbbr /usr/local/bin/hbbr

# Labels
LABEL \
    io.hass.name="${BUILD_NAME}" \
    io.hass.description="${BUILD_DESCRIPTION}" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version="${BUILD_VERSION}" \
    maintainer="Benjamin Nicol <benjamin.nicol@example.com>" \
    org.opencontainers.image.title="${BUILD_NAME}" \
    org.opencontainers.image.description="${BUILD_DESCRIPTION}" \
    org.opencontainers.image.vendor="Home Assistant Community Add-ons" \
    org.opencontainers.image.authors="Benjamin Nicol" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.url="https://github.com/rustdesk/rustdesk-server" \
    org.opencontainers.image.source="https://github.com/Benicol/rustdesk-addon" \
    org.opencontainers.image.documentation="https://github.com/Benicol/rustdesk-addon/blob/main/README.md" \
    org.opencontainers.image.created="${BUILD_DATE}" \
    org.opencontainers.image.revision="${BUILD_REF}" \
    org.opencontainers.image.version="${BUILD_VERSION}"

# Expose ports
EXPOSE 21115 21116 21117 21118 21119

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
    CMD /healthcheck.sh

# Run
CMD [ "/run.sh" ]
