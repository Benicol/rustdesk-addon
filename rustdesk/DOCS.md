## Summary

This Home Assistant add-on provides a complete RustDesk server implementation, allowing you to host your own remote desktop server within your Home Assistant environment.

## Features

- **Complete RustDesk Server**: Includes both hbbs (signal server) and hbbr (relay server)
- **Web Management Console**: Browser-based server management interface
- **Multi-Architecture Support**: Works on aarch64, amd64, armv7, and i386 architectures
- **Secure by Default**: Optional encryption-only mode and configurable authentication
- **Easy Configuration**: Simple YAML-based configuration through Home Assistant UI
- **Automatic Key Management**: Generates server keys automatically if not provided
- **Health Monitoring**: Built-in health checks and status monitoring
- **Comprehensive Logging**: Configurable log levels for debugging and monitoring

## Quick Start

1. **Install the Add-on**

   - Add this repository to your Home Assistant
   - Install the "RustDesk Server" add-on
   - Start the add-on

2. **Get Connection Details**

   - Check the add-on logs for the server's public key
   - Note your Home Assistant server's IP address

3. **Configure RustDesk Clients**
   - Set ID Server to your Home Assistant IP
   - Set Relay Server to your Home Assistant IP
   - Enter the public key from the logs

## Technical Details

### Ports Used

- **21115/tcp**: NAT type test port
- **21116/tcp & udp**: Signal server (hbbs) ports
- **21117/tcp**: Relay server (hbbr) port
- **21118/tcp**: Web console HTTP port
- **21119/tcp**: Web console HTTPS port

### Data Persistence

- Server keys are stored in `/data/` and persist across restarts
- Configuration is managed through Home Assistant's add-on system

### Security Considerations

- Change default web console credentials
- Consider enabling encryption-only mode for production use
- Ensure appropriate firewall rules are in place
- Use strong passwords for web console access

## Troubleshooting

### Common Issues

1. **Clients can't connect**: Check firewall settings and ensure ports are open
2. **Public key not showing**: Wait for server initialization to complete
3. **Web console not accessible**: Verify web console is enabled and credentials are correct

### Debug Mode

Enable debug logging by setting `log_level` to `debug` in the configuration.

## Support

For issues specific to this add-on, please check:

- Add-on logs in Home Assistant
- RustDesk official documentation
- Home Assistant community forums

## License

This add-on is provided under the MIT License. RustDesk server binaries are subject to their own licensing terms.
