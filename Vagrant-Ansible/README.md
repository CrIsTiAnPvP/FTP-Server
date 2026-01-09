# Automated FTP & DNS Infrastructure (Vagrant + Ansible)

## Description

A comprehensive automation project to deploy a full-scale network environment including an FTP server and a DNS resolver.

## Components

* **Infrastructure**: Virtual Machines managed via `Vagrantfile`.
* **Provisioning**: Ansible roles for modular configuration.
* **DNS Service**: BIND9 configuration to resolve the `ftp.example.test` domain.

## Project Management

* Organized via **GitHub Projects** (Kanban board).
* Code quality enforced by `ansible-lint`.
* Automated validation of DNS records (A, PTR, CNAME) and FTP connectivity.

## Deployment

Run `vagrant up` to automatically trigger the Ansible playbooks and set up the entire environment from scratch.
