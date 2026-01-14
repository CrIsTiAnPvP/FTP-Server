FROM debian:trixie

################ METADATA #################
LABEL org.opencontainers.image.authors="Cristian Alonso Contreras (CrIsTiiAnPvP)"
LABEL version="1.0"
LABEL description="Docker image for a NIS activity, with a FTPS server using vsftpd and SSL certificates from Let's Encrypt"
LABEL website="cristianac.es"
LABEL org.opencontainers.image.source="https://github.com/CrIsTiAnPvP/FTP-Server"
###########################################

################# Environment #################
ENV domain=example.test
ENV host=ftp.$domain
###############################################

################# INITIAL SETUP #################
#Create shared volume
RUN mkdir /shared && chmod 777 /shared
VOLUME /shared

# Install vsftpd, openssl, lftp client
RUN apt update && apt install -y openssl lftp vsftpd

# Generate SSL certificates
RUN mkdir -p /etc/ssl/private /etc/ssl/certs
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/ssl/private/$domain.pem \
    -out /etc/ssl/private/$domain.pem \
    -subj "/C=ES/ST=Granada/L=Granada/O=IZV/OU=Informatica/CN=$host"
RUN chmod 600 /etc/ssl/private/$domain.pem

# Create users
RUN useradd -m pepe && echo "pepe:pepe" | chpasswd && \
	useradd -m luis && echo "luis:luis" | chpasswd && \
	useradd -m maria && echo "maria:maria" | chpasswd && \
	useradd -m miguel && echo "miguel:miguel" | chpasswd

# Create files:
WORKDIR /home/luis
USER luis
RUN touch luis1.txt luis2.txt
WORKDIR /home/maria
USER maria
RUN touch maria1.txt maria2.txt

# Return to root user
USER root
WORKDIR /
#################################################

############ Activity 1 Setup ############
# Copy and set execute permissions to the script
RUN mkdir /scripts
COPY scripts/pepeftp.sh /scripts/pepeftp.sh
RUN chmod +x /scripts/pepeftp.sh
COPY scripts/checkftp.sh /scripts/checkftp.sh
RUN chmod +x /scripts/checkftp.sh
##########################################

############ FTP SERVER CONFIGURATION ############
# Expose FTP ports
EXPOSE 20 21 21100-21110

# Copy configuration file
RUN mv /etc/vsftpd.conf /etc/vsftpd.conf.bak
COPY conf/vsftpd.conf /etc/vsftpd/vsftpd.conf
#Replace domain placeholder in vsftpd.conf
RUN sed -i "s/\$domain/${domain}/g" /etc/vsftpd/vsftpd.conf

#Create public directory for anonymous user and add welcome message
RUN mkdir -p /srv/ftp/pub && chmod 755 /srv/ftp/pub
COPY conf/.message /srv/ftp/pub/.message

#Allow maria to not be jailed
RUN echo "maria" > /etc/vsftpd/chroot_list
##################################################

################# ENTRYPOINT #################
COPY scripts/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
###############################################