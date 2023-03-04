FROM centos:centos7
# args
ARG WEB_ROOT_DIRECTORY
ARG WEB_CONTAINER_PORTNUM
ARG ARG PHP_VERSION
# yum install
RUN yum -y update && yum -y install \
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
    openssh-server \
    # vsftpd
    vsftpd \
    # passwd
    passwd \
    # timezone
    glibc-locale-source \
    # cleaning
    && yum clean all \
    # locale, timezone
    && localedef -f UTF-8 -i ja_JP ja_JP.UTF-8 \
    && ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
# local & timezone
ENV LANG="ja_JP UTF-8" \
    LANGUAGE="ja_JP:ja" \
    LC_ALL="ja_JP.UTF-8" \
    TZ="Asia/Tokyo"
# add last
RUN echo ServerName www.example.com:${WEB_CONTAINER_PORTNUM} >> /etc/httpd/conf/httpd.conf
# RUN echo ServerTokens Prod >> /etc/httpd/conf/httpd.conf
# rpm
RUN rpm -ivh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm \
    && rpm --import http://rpms.famillecollet.com/RPM-GPG-KEY-remi
# enable repository remi & remi
RUN yum-config-manager --enable remi && yum-config-manager --enable remi-php${PHP_VERSION}
# php
RUN yum -y install \
    php \
    php-devel \
    php-pdo \
    php-mysqlnd \
    php-mbstring \
    php-gd \
    php-pear \
    php-pecl-apc-devel \
    zlib-devel \
    php-xml \
    php-mcrypt \
    php-pecl-xdebug
# disable repository remi & remi-php
RUN yum-config-manager --disable remi && yum-config-manager --disable remi-php${PHP_VERSION}
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
# FTP
RUN mkdir /var/log/vsftpd
RUN mkdir /etc/vsftpd/user_conf