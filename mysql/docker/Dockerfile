FROM centos:centos7
# yum install
RUN yum -y update && yum -y install \
    epel-release \
    sudo \
    less \
    procps \
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
RUN rpm -ivh https://dev.mysql.com/get/mysql80-community-release-el7-7.noarch.rpm \
    && YEAR=$(sudo date | sudo awk 'END{print $1}' | sudo sed -e 's/年//g') \
    && rpm --import https://repo.mysql.com/RPM-GPG-KEY-mysql-${YEAR}
# disable repository mysql8.0 & enable repository mysql5.7
RUN yum-config-manager --disable mysql80-community && yum-config-manager --enable mysql57-community
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