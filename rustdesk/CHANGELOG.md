# Changelog

All notable changes to this add-on will be documented in this file.

## [1.0.0] - 2025-07-09

### Added

- Initial release of RustDesk Server add-on
- Support for RustDesk hbbs (signal server) and hbbr (relay server)
- Web console support with configurable authentication
- Configurable encryption settings
- Support for custom relay servers
- Automatic key generation
- Multi-architecture support (aarch64, amd64, armv7, i386)
- Comprehensive logging with configurable log levels

### Features

- **Signal Server (hbbs)**: Handles connection requests and NAT traversal
- **Relay Server (hbbr)**: Relays traffic when direct connection isn't possible
- **Web Console**: Browser-based management interface
- **Encryption Support**: Optional encrypted-only mode
- **Custom Keys**: Support for custom public keys
- **Auto-start**: Automatic startup with Home Assistant

### Configuration Options

- `relay_server`: Custom relay server configuration
- `encrypted_only`: Force encrypted connections only
- `public_key`: Custom server public key
- `web_console_enabled`: Enable/disable web management console
- `web_console_user`: Web console username
- `web_console_password`: Web console password
- `log_level`: Configurable logging level

### Network Ports

- 21115/tcp: NAT type test port
- 21116/tcp & 21116/udp: Signal server ports
- 21117/tcp: Relay server port
- 21118/tcp: Web console HTTP port
- 21119/tcp: Web console HTTPS port
