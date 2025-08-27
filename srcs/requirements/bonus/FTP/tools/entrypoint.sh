#!/bin/bash
# Create FTP user
useradd -d /var/www/html -s /bin/bash $FTP_USER
echo "$FTP_USER:$FTP_PASS" | chpasswd
chown -R $FTP_USER:$FTP_USER /var/www/html

# Start vsftpd
/usr/sbin/vsftpd /etc/vsftpd.conf
