FROM almalinux:8
# args
ARG DB_ROOT_PASSWORD
ARG DB_HOST_PORTNUM
ARG DB_CONTAINER_PORTNUM
# import rpm sigunature & dnf install
RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-AlmaLinux \
    && dnf -y update && dnf -y install \
    epel-release \
    sudo \
    less \
    # network ss (instaed of netstat)
    iproute \
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
# rpm
RUN dnf -y localinstall https://dev.mysql.com/get/mysql80-community-release-el8-2.noarch.rpm
RUN YEAR=$(sudo date | sudo awk 'END{print $1}' | sudo sed -e 's/年//g') \
    && rpm --import https://repo.mysql.com/RPM-GPG-KEY-mysql-${YEAR}
# disable default module
RUN dnf -y module disable mysql
# mysql
RUN dnf -y install mysql-community-devel mysql-community-server
# mysql log
RUN mkdir /var/log/mysql
# mkdir and owner and so on
RUN chown -R mysql:mysql /var/log/mysql
RUN chown -R mysql /var/lib/mysql/
RUN chgrp -R mysql /var/lib/mysql/
RUN mkdir /template
RUN mkdir /workspace