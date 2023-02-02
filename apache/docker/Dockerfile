FROM almalinux:8
# args
ARG WEB_ROOT_DIRECTORY
ARG WEB_CONTAINER_PORTNUM
# import rpm sigunature & dnf install
RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-AlmaLinux \
    && dnf -y update && dnf -y install \
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
    # timezone
    glibc-locale-source \
    # cleaning
    && dnf clean all \
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
# rpm remi repository
RUN rpm -ivh http://rpms.famillecollet.com/enterprise/remi-release-8.rpm \
    && rpm --import http://rpms.famillecollet.com/RPM-GPG-KEY-remi
# disable default module
RUN dnf module reset -y php
# install php 7.4
RUN dnf module install -y php:remi-7.4
# php
RUN dnf -y install \
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