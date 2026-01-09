# FTP Server Implementation & Automation Project

## Overview

This repository contains a collection of guides and technical specifications for deploying and configuring FTP (File Transfer Protocol) servers. The project covers different scenarios, from basic anonymous servers to secure (FTPS) implementations, and includes a full automation workflow using Vagrant and Ansible.

## Contents

1. **Anonymous FTP Configuration**: Basic setup for public file mirrors (With Docker Hub).
2. **Secure FTP (FTPS)**: Implementation of encrypted connections and user access control (With Docker Hub).
3. **Vagrant & Ansible Automation**: Infrastructure as Code (IaC) approach to deploy these services automatically (With Ansible).

## Core Technologies

* **Vagrant**: Virtual environment orchestration.
* **Ansible**: Configuration management and automation.
* **vsftpd**: The Very Secure FTP Daemon used as the server software.
* **BIND9**: Used for DNS resolution within the infrastructure.

## General Objectives

* To practice manual and automated server configuration.
* To understand FTP security protocols (SSL/TLS).
* To implement collaborative project management using GitHub.