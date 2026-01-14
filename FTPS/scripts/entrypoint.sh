#!/bin/bash

set -eux

touch /shared/pepe.txt && chmod 766 /shared/pepe.txt
touch /shared/checkftp.txt && chmod 766 /shared/checkftp.txt

su - pepe -c "/scripts/pepeftp.sh /shared/pepe.txt"
su - root -c "/scripts/checkftp.sh /shared/checkftp.txt"
exec vsftpd /etc/vsftpd/vsftpd.conf 2>&1