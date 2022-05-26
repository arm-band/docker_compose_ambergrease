FROM centos:7
# args
ARG DB_ROOT_PASSWORD
ARG DB_HOST_PORTNUM
ARG DB_CONTAINER_PORTNUM
# import rpm sigunature & yum install
RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7 \
    && yum -y update && yum -y install \
    epel-release \
    sudo \
    less \
    # network ss (instaed of netstat)
    iproute \
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
# rpm
RUN yum -y localinstall https://dev.mysql.com/get/mysql80-community-release-el7-6.noarch.rpm
RUN YEAR=$(sudo date | sudo awk 'END{print $1}' | sudo sed -e 's/年//g') \
    && rpm --import https://repo.mysql.com/RPM-GPG-KEY-mysql-${YEAR}
# mysql
RUN yum -y install \
    mysql-community-devel \
    mysql-community-server
# mysql log
RUN mkdir /var/log/mysql
# mkdir and owner and so on
RUN chown -R mysql:mysql /var/log/mysql
RUN chown -R mysql /var/lib/mysql/
RUN chgrp -R mysql /var/lib/mysql/
RUN mkdir /template
RUN mkdir /workspace