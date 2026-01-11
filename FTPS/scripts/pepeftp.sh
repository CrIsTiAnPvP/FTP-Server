#!/bin/bash

if [ -n "$1" ]; then
    exec > "$1" 2>&1
fi

if [ -d /home/pepe/pruebasFTP ]; then
	rm -r /home/pepe/pruebasFTP
fi

echo -ne "\e[35mCreating \e[34mpruebasFTP \e[35mdirectory inside pepe user home...\e[0m\n"
mkdir -p /home/pepe/pruebasFTP
sleep .5

if [ -f /home/pepe/pruebasFTP/datos1.txt ]; then
	rm /home/pepe/pruebasFTP/datos1.txt
fi

echo -ne "\e[35mCreating \e[34mdatos1.txt \e[35mfile inside pruebasFTP directory...\e[0m\n"
cd /home/pepe/pruebasFTP || exit
touch datos1.txt
sleep .5

if [ -f check ]; then
	rm check
fi
if [ -d img ]; then
	rm -r img
fi

echo -e "\e[35mConecting to ftp.cica.es as anonymous user\e[0m"
sleep 1

lftp ftp.cica.es -u anonymous, << EOF
! [ -t 1 ] && clear
!/bin/echo -ne "\e[32mConnected successfully\e[0m\n\n"
!/bin/echo -ne "\e[33mLets see where we are --> \e[36m"
pwd
!echo 
!/bin/echo -ne "\e[33mLets see where we are (locally) --> \e[36m"
lpwd
!echo
!/bin/echo -e "\e[33mListing remote files:\e[0m"
ls
!echo
!/bin/echo -e "\e[33mListing local files:\e[0m"
!ls
!echo
!/bin/echo -e "\e[33mDownloading \e[36m/pub/check \e[33mfile from server to local\e[0m"
get /pub/check
!echo
!bash -c 'ls | grep -q check && echo -e "\e[33mThe file check has been downloaded \e[36msuccessfully\e[0m" || echo -e "\e[33mThe file check is \e[31mNOT present\e[0m"' 
!ls -l check
!echo
!/bin/echo -e "\e[33mLets create a local directory \e[36mimg\e[0m"
!mkdir img
!ls -ld img
!echo
!/bin/echo -e "\e[33mLets try to upload \e[36mdatos1.txt\e[33m to the server\e[0m"
put datos1.txt
!echo
EOF