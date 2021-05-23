#!/bin/bash

SYSDBPATH="/var/lib/mysql/data/sys/"
DBINDFILE="sys_config.ibd"
SOCKFILE="/var/lib/mysql/mysql.sock"

# setting file replace and copy
sed -e "s/DB_CONTAINER_PORTNUM/${1}/gi" /template/mysql/base.cnf > /etc/my.cnf.d/base.cnf

cp /template/mysql/20-default-authentication-plugin.cnf /etc/my.cnf.d/20-default-authentication-plugin.cnf
cp /template/mysql/40-paas.cnf /etc/my.cnf.d/40-paas.cnf
cp /template/mysql/50-my-tuning.cnf /etc/my.cnf.d/50-my-tuning.cnf

# mysql initialize
if [ ! -e $SYSDBPATH$DBINDFILE ]; then
    /usr/sbin/mysqld --user=mysql --initialize &
    # wait for initialize process
    wait
    echo "mysqld initialized"
    /usr/sbin/mysqld --user=mysql &
    echo "mysqld boot"
    # wait for the mysql.sock file to be created
    # If you do not wait, you will get the error below when executing the command to change the password.
    # ERROR 2002 (HY000): Can't connect to local MySQL server through socket '/var/lib/mysql/mysql.sock' (2)
    while [ ! -e $SOCKFILE ]
    do
      sudo sleep 1
    done
    # get the init password
    DB_INIT_PASSWORD=$(sudo grep 'temporary password' /var/log/mysql/mysql-error.log | sudo awk '{print $13}')
    # change root password
    sudo mysql -u root -p${DB_INIT_PASSWORD} --connect-expired-password -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${2}'; CREATE USER '${3}'@'%' IDENTIFIED BY '${4}'; GRANT ALL ON *.* TO 'admin'@'%'; FLUSH PRIVILEGES;"
else
    /usr/sbin/mysqld --user=mysql &
    echo "mysqld boot"
fi
