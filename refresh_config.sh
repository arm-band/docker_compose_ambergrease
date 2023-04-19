rm ./apache/confd/*.conf
rm ./apache/log/*.log
rm ./php/error_log/*.log
find ./vsftpd/user_conf/ -type f | grep -v -E "\.gitkeep" | xargs rm -rf
rm ./vsftpd/log/*.log
rm ./cert/server.*
rm ./mysql/cnfd/*.cnf
rm ./mysql/log/*.log