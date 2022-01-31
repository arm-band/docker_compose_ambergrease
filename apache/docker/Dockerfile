FROM almalinux:8
# args
ARG WEB_ROOT_DIRECTORY
ARG WEB_DOMAIN
ARG WEB_HOST_PORTNUM
ARG WEB_CONTAINER_PORTNUM
ARG WEB_HOST_PORTSSL
ARG WEB_CONTAINER_PORTSSL
# timezone
RUN \cp -pf /usr/share/zoneinfo/Japan /etc/localtime
# yum install
RUN dnf -y update && yum -y install \
    epel-release \
    sudo \
    less \
    procps \
    # network ss (instaed of netstat)
    iproute \
    # apache
    httpd-devel \
    # zip
    zip \
    unzip \
    # SSL
    openssl \
    mod_ssl \
    # SSH
    openssh-server
# add last
RUN echo ServerName www.example.com:${WEB_CONTAINER_PORTNUM} >> /etc/httpd/conf/httpd.conf
# RUN echo ServerTokens Prod >> /etc/httpd/conf/httpd.conf
# rpm
RUN rpm -ivh http://rpms.famillecollet.com/enterprise/remi-release-8.rpm \
    && rpm --import http://rpms.famillecollet.com/RPM-GPG-KEY-remi
# disable default module
RUN dnf module reset -y php
# install php 7.4
RUN dnf module install -y php:remi-7.4
# php
RUN yum -y install php php-devel php-pdo php-mysqlnd php-mbstring php-gd php-pear php-pecl-apc-devel zlib-devel php-xml php-mcrypt php-pecl-xdebug
# composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
 && php composer-setup.php \
 && php -r "unlink('composer-setup.php');" \
 && mv composer.phar /usr/local/bin/composer
# php log
RUN mkdir /var/log/php
RUN chown apache /var/log/php
RUN chmod 755 /var/log/php
# SSL
RUN mkdir -p /etc/ssl/private
# volume directory
RUN mkdir /template
RUN mkdir /var/www/${WEB_ROOT_DIRECTORY}
RUN mkdir /var/www/${WEB_ROOT_DIRECTORY}/web
RUN mkdir /workspace
# SSH
RUN mkdir /var/run/sshd