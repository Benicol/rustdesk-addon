# RustDesk Server Home Assistant Add-on

![Supports aarch64 Architecture][aarch64-shield] ![Supports amd64 Architecture][amd64-shield] ![Supports armv7 Architecture][armv7-shield] ![Supports i386 Architecture][i386-shield]

![Project Stage][project-stage-shield] ![License][license-shield]

A Home Assistant add-on that provides a complete RustDesk server implementation for hosting your own remote desktop server.

## About

RustDesk is an open-source remote desktop application that allows you to control computers remotely. This Home Assistant add-on packages both the RustDesk signal server (hbbs) and relay server (hbbr) into an easy-to-deploy container.

### Features

- 🖥️ **Complete RustDesk Server**: Includes both hbbs and hbbr components
- 🌐 **Web Management Console**: Browser-based server administration
- 🔒 **Security Options**: Encryption-only mode and custom authentication
- 🏗️ **Multi-Architecture**: Supports ARM and x86 platforms
- ⚙️ **Easy Configuration**: Simple setup through Home Assistant UI
- 🔑 **Automatic Key Management**: Generates server keys automatically
- 📊 **Health Monitoring**: Built-in status checks and logging

## Installation

### Method 1: Add Repository URL

1. In Home Assistant, go to **Supervisor** → **Add-on Store**
2. Click the **⋮** menu in the top right corner
3. Select **Repositories**
4. Add this repository URL: `https://github.com/Benicol/rustdesk-addon`
5. Find "RustDesk Server" in the add-on store and install it

### Method 2: Manual Installation

1. Clone this repository to your Home Assistant addons directory:
   ```bash
   cd /usr/share/hassio/addons/local/
   git clone https://github.com/Benicol/rustdesk-addon.git
   ```
2. Restart Home Assistant
3. Install the add-on from the Local Add-ons section

## Configuration

### Basic Configuration

```yaml
relay_server: ''
encrypted_only: false
public_key: ''
web_console_enabled: true
web_console_user: 'admin'
web_console_password: 'your-secure-password'
log_level: 'info'
```

### Configuration Options

| Option                 | Description                           | Default              |
| ---------------------- | ------------------------------------- | -------------------- |
| `relay_server`         | Custom relay server address           | `""` (use built-in)  |
| `encrypted_only`       | Only allow encrypted connections      | `false`              |
| `public_key`           | Custom server public key              | `""` (auto-generate) |
| `web_console_enabled`  | Enable web management console         | `true`               |
| `web_console_user`     | Web console username                  | `"admin"`            |
| `web_console_password` | Web console password                  | `"rustdesk"`         |
| `log_level`            | Logging level (debug/info/warn/error) | `"info"`             |

## Usage

### 1. Start the Add-on

1. Install and configure the add-on
2. Start the add-on
3. Check the logs for the server's public key and connection details

### 2. Configure RustDesk Clients

In your RustDesk client applications:

1. Go to **Settings** → **Network**
2. Set **ID Server** to your Home Assistant IP address
3. Set **Relay Server** to your Home Assistant IP address
4. Enter the **public key** shown in the add-on logs
5. Save the settings

### 3. Web Console Access

If enabled, access the web console at:

- **HTTP**: `http://[YOUR_HA_IP]:21118`
- **HTTPS**: `https://[YOUR_HA_IP]:21119`

Log in with the configured username and password.

## Network Requirements

### Ports

The add-on uses these ports:

| Port  | Protocol | Purpose              |
| ----- | -------- | -------------------- |
| 21115 | TCP      | NAT type test        |
| 21116 | TCP/UDP  | Signal server (hbbs) |
| 21117 | TCP      | Relay server (hbbr)  |
| 21118 | TCP      | Web console (HTTP)   |
| 21119 | TCP      | Web console (HTTPS)  |

### Firewall Configuration

Ensure these ports are accessible from your network:

- For local network only: Allow ports 21115-21119 on your local network
- For internet access: Forward ports 21115-21119 to your Home Assistant server

## Security Considerations

### Recommended Security Settings

1. **Change Default Credentials**

   ```yaml
   web_console_user: 'your-username'
   web_console_password: 'your-strong-password'
   ```

2. **Enable Encryption-Only Mode**

   ```yaml
   encrypted_only: true
   ```

3. **Use Custom Public Key** (optional)
   ```yaml
   public_key: 'your-custom-public-key'
   ```

### Network Security

- Use a firewall to restrict access to RustDesk ports
- Consider using a VPN for remote access
- Regularly update the add-on to get security fixes

## Troubleshooting

### Common Issues

**Q: Clients can't connect to the server**

- Check that ports 21115-21117 are open and accessible
- Verify the correct IP address and public key are configured
- Check Home Assistant and add-on logs for errors

**Q: Web console is not accessible**

- Ensure `web_console_enabled` is set to `true`
- Verify port 21118/21119 is accessible
- Check the configured username and password

**Q: Public key not displaying in logs**

- Wait for the server to fully initialize (may take 30-60 seconds)
- Check for any startup errors in the logs
- Restart the add-on if necessary

### Debug Mode

Enable detailed logging:

```yaml
log_level: 'debug'
```

This will provide more detailed information in the add-on logs.

### Log Analysis

Check the add-on logs for:

- Server startup messages
- Connection attempts
- Error messages
- Public key information

## Development

### Building Locally

1. Clone the repository
2. Build the Docker image:
   ```bash
   cd rustdesk
   docker build -t local/rustdesk-addon .
   ```

### Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## Support

- **Issues**: [GitHub Issues](https://github.com/Benicol/rustdesk-addon/issues)
- **RustDesk Documentation**: [Official Docs](https://rustdesk.com/docs/)
- **Home Assistant Community**: [Community Forum](https://community.home-assistant.io/)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- [RustDesk Team](https://github.com/rustdesk/rustdesk) for the excellent remote desktop solution
- [Home Assistant](https://www.home-assistant.io/) community for the platform
- Contributors and testers who helped improve this add-on

---

[aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
[amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg
[armv7-shield]: https://img.shields.io/badge/armv7-yes-green.svg
[i386-shield]: https://img.shields.io/badge/i386-yes-green.svg
[project-stage-shield]: https://img.shields.io/badge/project%20stage-experimental-yellow.svg
[license-shield]: https://img.shields.io/github/license/Benicol/rustdesk-addon.svg
