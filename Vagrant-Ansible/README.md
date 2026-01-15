# Infrastructure as Code: Secure FTPS & DNS Deployment

This project automates the deployment of a secure networking infrastructure using **Vagrant** for virtual machine provisioning and **Ansible** for automated configuration. It features a secure FTPS server and a dedicated Bind9 DNS server.

## 📁 Project Structure

* **Vagrantfile**: Defines the multi-machine infrastructure (FTP and DNS servers).
* **ansible**:
  * `hosts.ini`: Inventory file defining server IP addresses and SSH keys.
  * `playbook.yml`: The main automation script for installing and configuring all services.
* **conf**: Configuration templates.
  * `vsftpd.conf`: Secure FTP server configuration with SSL/TLS.
  * `named.conf.local` & `named.conf.options`: BIND9 DNS configurations.
  * `db.isrv.test`: DNS zone database.
  * `.message`: Welcome message for FTP users.

---

## 🏗️ Infrastructure Overview (Vagrant)

The environment consists of two Debian-based virtual machines (`debian/bookworm64`):

| Server | Hostname | IP Address | Service |
| :--- | :--- | :--- | :--- |
| **FTP Server** | `ftp.isrv.test` | `192.168.56.10` | vsftpd (FTPS) |
| **DNS Server** | `dns.isrv.test` | `192.168.56.11` | Bind9 |

Provisioning is handled in a single pass using the Ansible provisioner defined in the `Vagrantfile`.

---

## 🛠️ Automated Configuration (Ansible)

The `playbook.yml` handles three primary roles:

### 1. Secure FTPS Setup

* **Software**: Installs `vsftpd` and `openssl`.
* **Security**: Generates a self-signed RSA 2048-bit SSL certificate at `/etc/ssl/private/vsftpd.pem`.
* **FTPS Policy**: Forces SSL for both logins and data transfers (`force_local_data_ssl=YES`).
* **User Isolation**: Implements a Chroot jail for all users, except for user **maria**, who is explicitly added to the `chroot_list` to allow navigation.

### 2. DNS Services (Bind9)

* **Software**: Installs and enables the `bind9` service.
* **Zone Management**: Deploys the `isrv.test` domain configuration and database files to `/etc/bind/`.
* **Automation**: Includes a handler to automatically restart the DNS service whenever configuration files are updated.

### 3. User & Content Management

* **Users**: Automatically creates accounts for `luis`, `maria`, and `miguel` with encrypted passwords.
* **Structure**: Generates home directories and creates two test files (`file1.txt`, `file2.txt`) for each user with `0760` permissions.
* **Anonymous Access**: Configures a public directory at `/srv/ftp/pub` with a custom welcome message (`.message`).

---

## 🚀 Deployment Instructions

### Prerequisites

* Vagrant and VirtualBox installed.
* Ansible installation.

### Execution

Simply navigate to the project root and run:

```bash
vagrant up
```
