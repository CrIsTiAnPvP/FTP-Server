# FTPS Server Deployment with Bind9 DNS Integration

This project implements a secure **FTPS server** using `vsftpd` with SSL/TLS encryption, integrated with a local **Bind9 DNS server**. The deployment is fully containerized and orchestrated using the **Docker Compose plugin**.

## 📁 Project Structure

* **conf/**: Configuration files for the services.
  * **bind9/**: DNS zone and configuration files (`named.conf`, `db.example.test`).
  * `vsftpd.conf`: Secure FTP configuration with SSL/TLS enabled.
  * `.message`: Custom directory welcome message.
* **scripts/**: Automation and testing scripts.
  * `entrypoint.sh`: Main container startup script.
  * `pepeftp.sh`: Automated FTP client testing script.
  * `checkftp.sh`: System verification script (users, groups, and permissions).
* **docker-compose.yml**: Orchestration for the `ftps` and `dns` containers.
* **Dockerfile**: Custom Debian-based image for the FTPS service.

---

## 🛠️ Key Configurations

### 1. Secure FTP (`vsftpd.conf` & Dockerfile)

* **Encryption**: Forced SSL/TLS for both data and login sessions (`force_local_data_ssl=YES`, `force_local_logins_ssl=YES`).
* **Certificates**: Automatically generated self-signed RSA 2048-bit certificates via OpenSSL during the build process.
* **User Management**: 
* Creates local users (`pepe`, `luis`, `maria`, `miguel`) with predefined home directories.
  * **Chroot Jail**: All users are jailed by default except for those explicitly listed in `chroot_list` (e.g., `maria`).
* **Anonymous Access**: Public directory enabled at `/srv/ftp/pub` with a custom welcome message.

---

### 2. DNS Integration (`bind9`)

* A dedicated container runs **Bind9** to provide name resolution within the internal network.
* The FTPS container is configured to use the Bind9 container (`192.168.69.10`) as its primary DNS server.

---

## 🚀 Automation & Verification

The project includes an automated workflow to verify the environment's integrity immediately upon deployment.

### 1. Main Entrypoint (`entrypoint.sh`)

At runtime, the container executes the following sequence:

* **Environment Setup**: Creates shared tracking files (`pepe.txt`, `checkftp.txt`) in the `/shared` volume with specific permissions (`766`).

* **Automated Testing**: Executes `pepeftp.sh` as user `pepe`.

* **System Verification**: Executes `checkftp.sh` as user `root` to validate the environment.

* **Service Launch**: Starts the `vsftpd` daemon in the foreground.

---

### 2. System Verification (`checkftp.sh`)

This script performs automated checks on the server's internal state:

* **User/Group Validation**: Checks if the `ftp` user and `ftp` group exist in the system.

* **Directory Ownership**: Verifies that the `/srv/ftp` directory is owned by the `root` user.
* **Visual Feedback**: Uses color-coded output to report status (Green for success, Red for failure).

---

### 3. Client Simulation (`pepeftp.sh`)

An automated test script using the `lftp` client to simulate real operations:

* **Cleanup**: Removes previous test directories and files (`pruebasFTP`, `img`, `datos1.txt`).

* **FTP Operations**: Connects to `ftp.cica.es` as an anonymous user to:
  * List remote and local files.
  * Download the `/pub/check` file and verify its presence.
  * Create a local directory (`img`) and upload a test file (`datos1.txt`).

---

### 4. FTP Client Exercise - RedIRIS (`Filezilla`)

#### 1. Which mode did the client use (active or passive) when downloading the server's file list?

The client used **Passive Mode**. In the FileZilla log, although it connects to port 21 for commands, the standard behavior for modern clients like FileZilla is to send the `PASV` command to establish a data connection that can bypass firewalls.

#### 2. What is the IP address of the `ftp.rediris.es` server?

The IP address is **130.206.13.2**. This can be seen in the status log: `Connecting to 130.206.13.2:21...`.

#### 3. In the message `227 Entering Passive Mode (h1,h2,h3,h4,p1,p2)`, what do the last two numbers mean?

The last two numbers (**163** and **170**) are used to calculate the **TCP port number** that the server has opened for the data transfer. 
The formula to get the port is:  

$$(p1 \times 256) + p2$$

#### 4. File Download

The file `welcome.msg` was successfully located in the remote directory and downloaded to the local path `/home/alumnom/`.

---

## 🌐 Deployment Instructions

### 1. Networking Setup

The project uses a custom bridge network `ftps_net` with the `192.168.69.0/24` subnet:

* **DNS Server**: `192.168.69.10`
* **FTPS Server**: `192.168.69.11`

### 2. Execution (Docker Compose Plugin)

To build and start the entire infrastructure:

```bash
docker compose up -d
```
