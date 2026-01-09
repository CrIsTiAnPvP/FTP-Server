# Dockerized Anonymous FTP Mirror

## Description

This setup deploys a `vsftpd` server inside a Docker container, specifically pre-configured to act as an anonymous mirror for OpenSuse updates for the `sistema.sol` domain.

## Docker Configuration Highlights

* **Image**: Based on `debian:stable` or `delfer/vsftpd`.
* **Network**: Listens on IPv4, mapping container port 21 to host port 21.
* **Security Policy**:
* **Anonymous Access**: Enabled (Read-only).
* **Local Users**: Disabled for maximum security.
* **Write Permissions**: Strictly forbidden.

## Resource Limits (Defined in `vsftpd.conf`)

* **Max Clients**: 200 simultaneous connections.
* **Bandwidth Limit**: 50KB/s per user to prevent network congestion.
* **Inactivity Timeout**: 30 seconds.

## Usage

1. Build the image: `docker build -t ftp-anonimo .`
2. Run the container: `docker run -d -p 21:21 --name ftp-mirror ftp-anonimo`
