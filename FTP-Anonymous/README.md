# Anonymous FTP Server Deployment (sistema.sol Mirror)

This repository contains the configuration and scripts required to deploy an anonymous FTP server based on **vsftpd** using Docker. The goal is to serve as a file mirror (e.g., OpenSUSE) under the `sistema.sol` domain.

## 📁 Project Structure

* **conf/**: Configuration files folder.
  * `vsftpd.conf`: FTP service configuration.
  * `banner.msg`: Custom welcome message.
* **Dockerfile**: Docker custom image definition.
* **start.sh**: Automation script for building and starting the service.
* **data/**: Local directory synced with the FTP root (created on startup).
* **logs/**: Local directory where activity logs are stored (created on startup).

---

## 🛠️ Applied Configuration

### 1. FTP Server (`vsftpd.conf`)

The server has been configured to allow public but restricted access:

* **Anonymous Access**: Enabled without requiring a password (`anonymous_enable=YES`).

* **Read-Only**: Write capabilities have been disabled for external users (`write_enable=NO`).

* **Chroot**: Users are jailed in their directory to prevent them from browsing the container's file system.

* **Traffic Limits**: Speed is limited to **50 Kbps** with a maximum of **200 simultaneous clients**.

* **Passive Mode**: Configured to operate within the `21100-21110` port range.

### 2. Docker Image (`Dockerfile`)

The image uses `fauria/vsftpd` as a base and performs the following tasks:

* Configures the internal `MOTD` (Message of the Day).
* Exposes ports `20`, `21`, and the passive range.
* Copies custom configuration files into the container.

---

## 🚀 Deployment Instructions

To launch the server automatically, use the `start.sh` script.

### What does the script do?

1. **Builds the image**: Creates the local Docker image tagged as `ftp-anonymous`.
2. **Cleans the environment**: Stops and removes any previous container named `ftp-anonymous`.
3. **Directory management**: Creates `./data` and `./logs` folders on the host if they do not exist.
4. **Launches the container**: Runs the container by mapping network ports and mounting volumes to ensure data persistence.

### Command to execute

```bash
chmod +x start.sh
./start.sh
