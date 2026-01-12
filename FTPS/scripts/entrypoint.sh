#!/bin/bash

set -eux

touch /shared/output.txt && chmod 766 /shared/output.txt

su - pepe -c "/scripts/pepeftp.sh /shared/output.txt"
exec vsftpd /etc/vsftpd/vsftpd.conf 2>&1