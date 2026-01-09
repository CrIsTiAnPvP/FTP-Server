# Dockerized Anonymous FTP

## Description

This setup deploys a `vsftpd` server inside a Docker container, specifically pre-configured to act as an anonymous ftp server for OpenSuse updates for the `mirror.sistema.sol` domain.

## Docker Configuration Highlights

* **Image**: Based on `fauria/vsftpd`.
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

1. Run the sript: `chmod +x ./start.sh && ./start.sh`
