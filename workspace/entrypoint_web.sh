#!/bin/bash

# gen key & certificate
## localhost
openssl req -new -newkey rsa:2048 -nodes \
        -out /etc/pki/tls/certs/localhost.csr \
        -keyout /etc/pki/tls/private/localhost.key \
        -subj "/C=/ST=/L=/O=/OU=/CN=www.example.com"
openssl x509 -days 365 -req \
        -signkey /etc/pki/tls/private/localhost.key \
        -in /etc/pki/tls/certs/localhost.csr \
        -out /etc/pki/tls/certs/localhost.crt
## .env domain
openssl req -new -newkey rsa:2048 -nodes \
        -out /etc/ssl/private/server.csr \
        -keyout /etc/ssl/private/server.key \
        -subj "/C=/ST=/L=/O=/OU=/CN=*.${2}"
openssl x509 -days 365 -req \
        -signkey /etc/ssl/private/server.key \
        -in /etc/ssl/private/server.csr \
        -out /etc/ssl/private/server.crt

# setting file replace and copy
sed -e "s/WEB_ROOT_DIRECTORY/${1}/gi" \
    -e "s/WEB_DOMAIN/${2}/gi" \
    -e "s/WEB_HOST_PORTNUM/${3}/gi" \
    -e "s/WEB_CONTAINER_PORTNUM/${4}/gi" \
    -e "s/WEB_HOST_PORTSSL/${5}/gi" \
    -e "s/WEB_CONTAINER_PORTSSL/${6}/gi" \
        /template/apache/apache_vh.conf > /etc/httpd/conf.d/${1}.conf
sed -e "s/WEB_ROOT_DIRECTORY/${1}/gi" \
    -e "s/WEB_DOMAIN/${2}/gi" \
    -e "s/WEB_HOST_PORTNUM/${3}/gi" \
    -e "s/WEB_CONTAINER_PORTNUM/${4}/gi" \
    -e "s/WEB_HOST_PORTSSL/${5}/gi" \
    -e "s/WEB_CONTAINER_PORTSSL/${6}/gi" \
        /template/apache/apache_vh_ssl.conf > /etc/httpd/conf.d/${1}_ssl.conf

cp /template/apache/php.conf /etc/httpd/conf.d/php.conf
cp /template/apache/ssl.conf /etc/httpd/conf.d/ssl.conf
cp /template/apache/modules/00-mpm.conf /etc/httpd/conf.modules.d/00-mpm.conf

# Apache start
/usr/sbin/httpd -DFOREGROUND &

# PHP
/usr/sbin/php-fpm &

# SSH
sed -ri 's/^#PermitRootLogin yes/PermitRootLogin yes/' /etc/ssh/sshd_config
echo "${7}:${8}" | chpasswd
ssh-keygen -t rsa -N "" -f /etc/ssh/ssh_host_rsa_key
/usr/sbin/sshd -D &

# WP CLI
if [ "$9" = 'true' ]; then
    cd ~
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp
    # permission
    usermod -aG wheel,apache ${10}
    chown -R apache:apache /var/www/${1}/web
    find /var/www/${1}/web/ -type f -exec chmod 666 {} \;
    find /var/www/${1}/web/ -type d -exec chmod 777 {} \;
fi

# FTP
useradd ${10}
echo ${11} | passwd --stdin ${10}

cp /template/vsftpd/chroot_list /etc/vsftpd/chroot_list

sed -e "s/WEB_FTP_USER/${10}/gi" \
        /template/vsftpd/user_list > /etc/vsftpd/user_list
sed -e "s/WEB_ROOT_DIRECTORY/${1}/gi" \
        /template/vsftpd/WEB_FTP_USER > /etc/vsftpd/user_conf/${10}

/usr/sbin/vsftpd &
