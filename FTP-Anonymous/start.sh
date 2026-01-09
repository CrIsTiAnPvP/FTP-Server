#!/bin/bash

set eux

# Build the docker image
docker build -t ftp-anonymous .

# Remove any existing container with the same name
docker rm -f ftp-anonymous 2>/dev/null || true

# Create data and logs directories if they don't exist
if [ ! -d "./data" ]; then
	mkdir ./data
fi
if [ ! -d "./logs" ]; then
	mkdir ./logs
fi

# Run the docker container
docker run -d --hostname mirror.sistema.sol --name ftp-anonymous -p 20:20 -p 21:21 -p 21100-21110:21100-21110 -v "./data:/home/vsftpd" -v "./logs:/var/log/vsftpd" ftp-anonymous

# Get IP addresses
docker_ip_addr=$(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' ftp-anonymous)
ip_addr=$(hostname -I | awk '{print $1}')

# Check if the container is running
if docker ps | grep -q ftp-anonymous; then
	echo -ne "\e[32m✓ FTP Anonymous server container is running\e[0m\n"
	echo -ne "\e[33m→ Connect using an FTP client to 127.0.0.1 | $docker_ip_addr | $ip_addr \e[0m\n"
	echo -ne "\e[33m→ To \e[31mstop \e[33mthe container, run: docker stop ftp-anonymous\e[0m\n"
else
	echo -ne "\e[31m✗ FTP Anonymous server container is not running\e[0m\n"
	echo -ne "\e[33m→ Check docker logs for errors (docker logs ftp-anonymous)\e[0m\n"
	exit 1
fi