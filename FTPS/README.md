# Secure FTPS Server with Docker

## Description

This project implements a secure FTP server (FTPS) using Docker. It focuses on protecting user credentials and data through SSL/TLS encryption, ensuring a production-ready environment.

## Security Features

* **Encryption**: Mandatory SSL/TLS for both login and data transfer (SSLv3/TLS).
* **Certificate**: Uses a custom certificate located at `/etc/ssl/certs/example.test.pem`.
* **User Isolation (Chroot)**: 
* Local users are jailed to their home directories.
* Specific exceptions can be configured via a `chroot_list`.
* **Traffic Control**:
* Local users: Limited to 5 MB/s.
* Anonymous users: Limited to 2 MB/s.

## Deployment Steps

1. **Generate Certificate**: Create the `.pem` file using OpenSSL.
2. **Docker Compose**: Define volumes to persist data and mount the configuration and certificates.
3. **Client Testing**: Verify the "Lock" icon in Filezilla or use `lftp` for CLI secure connections.

## Port Mapping

* **21**: Command port.
* **Passive Ports**: Range (e.g., 30000-30009) must be opened in Docker for data transfer.
