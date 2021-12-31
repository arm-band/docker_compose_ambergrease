FROM almalinux:8
# args
ARG DB_ROOT_PASSWORD
ARG DB_HOST_PORTNUM
ARG DB_CONTAINER_PORTNUM
# timezone
RUN \cp -pf /usr/share/zoneinfo/Japan /etc/localtime
# yum install
RUN yum -y update && yum -y install \
    epel-release \
    sudo \
    less \
    # network ss (instaed of netstat)
    iproute
# rpm
RUN dnf -y localinstall https://dev.mysql.com/get/mysql80-community-release-el8-2.noarch.rpm
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