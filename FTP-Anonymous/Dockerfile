# Initial Image & name
FROM fauria/vsftpd AS ftp-anonymous

RUN echo "-- Mirror de Opensuse para 'sistema.sol'" > /etc/motd

# Expose FTP ports
EXPOSE 20 21 21100-21110

# Copy configuration files
COPY conf/vsftpd.conf /etc/vsftpd/vsftpd.conf
COPY conf/banner.msg /etc/vsftpd/banner.msg