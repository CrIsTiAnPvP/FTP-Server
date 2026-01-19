#!/bin/bash

if [ -n "$1" ]; then
    exec > "$1" 2>&1
fi

grep -q ftp /etc/passwd && echo -ne "\e[32mFTP user exists\e[0m" || echo -e "\e[31mFTP user does NOT exist\e[0m"
echo -ne "\e[33m --> \e[36m"
grep ftp /etc/passwd

grep -q ftp /etc/group && echo -ne "\e[32mFTP group exists\e[0m" || echo -e "\e[31mFTP group does NOT exist\e[0m"
echo -ne "\e[33m --> \e[36m"
grep ftp /etc/group

echo -ne "\e[0m"

if [ -d /srv/ftp ]; then
	[ "$(stat -c %U /srv/ftp)" = "root" ] && echo -ne "\e[32m/srv/ftp owned by root\e[0m" || echo -e "\e[31m/srv/ftp NOT owned by root\e[0m"
	echo -ne "\e[33m --> \e[36m"
	ls -lad /srv/ftp
	echo -ne "\e[0m"
else
	echo -e "\e[31m/srv/ftp does NOT exist\e[0m"
fi
