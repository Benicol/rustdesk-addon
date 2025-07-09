# RustDesk Server Add-on

![Supports aarch64 Architecture][aarch64-shield] ![Supports amd64 Architecture][amd64-shield] ![Supports armv7 Architecture][armv7-shield] ![Supports i386 Architecture][i386-shield]

RustDesk is an open-source remote desktop application that allows you to control another computer remotely. This add-on provides a RustDesk server for your Home Assistant instance.

## About

This add-on runs a RustDesk server (hbbs and hbbr) that allows RustDesk clients to connect and establish remote desktop sessions through your Home Assistant server.

RustDesk consists of two main components:

- **hbbs** (signal server): Handles connection requests and NAT traversal
- **hbbr** (relay server): Relays traffic when direct connection isn't possible

## Installation

1. Add this repository to your Home Assistant add-on store
2. Install the "RustDesk Server" add-on
3. Configure the add-on (see configuration section below)
4. Start the add-on

## Configuration

### Add-on Configuration

```yaml
relay_server: ''
encrypted_only: false
public_key: ''
web_console_enabled: true
web_console_user: 'admin'
web_console_password: 'rustdesk'
log_level: 'info'
```

### Option: `relay_server`

Specify a custom relay server address. Leave empty to use the built-in relay server.

### Option: `encrypted_only`

When set to `true`, only encrypted connections will be allowed.

### Option: `public_key`

Custom public key for the server. If not specified, a new key will be generated.

### Option: `web_console_enabled`

Enable the web console for server management (default: true).

### Option: `web_console_user`

Username for the web console (default: "admin").

### Option: `web_console_password`

Password for the web console (default: "rustdesk").

### Option: `log_level`

Set the logging level. Options: `debug`, `info`, `warn`, `error` (default: "info").

## Usage

1. Start the add-on
2. Check the logs to get the server's public key
3. Configure your RustDesk clients to use your Home Assistant server's IP address
4. Use the public key in your RustDesk client configuration

### Ports

The add-on uses the following ports:

- **21115/tcp**: NAT type test
- **21116/tcp & 21116/udp**: Signal server (hbbs)
- **21117/tcp**: Relay server (hbbr)
- **21118/tcp**: Web console (HTTP)
- **21119/tcp**: Web console (HTTPS)

### Client Configuration

In your RustDesk client:

1. Go to Settings → Network
2. Set ID Server to your Home Assistant IP address
3. Set Relay Server to your Home Assistant IP address
4. Enter the public key shown in the add-on logs

## Web Console

If enabled, you can access the web console at:

- HTTP: `http://[HOME_ASSISTANT_IP]:21118`
- HTTPS: `https://[HOME_ASSISTANT_IP]:21119`

Use the configured username and password to log in.

## Support

For support with this add-on, please visit:

- [RustDesk Official Documentation](https://rustdesk.com/docs/)
- [RustDesk GitHub Repository](https://github.com/rustdesk/rustdesk)

## Authors & Contributors

This add-on is created and maintained by the Home Assistant community.

[aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
[amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg
[armv7-shield]: https://img.shields.io/badge/armv7-yes-green.svg
[i386-shield]: https://img.shields.io/badge/i386-yes-green.svg
