rm ./apache/confd/*.conf
rm ./apache/log/*.log
find ./apache/www/ -type f | grep -v -E "\.gitkeep" | xargs rm -rf
rm ./php/error_log/*.log
find ./vsftpd/user_conf/ -type f | grep -v -E "\.gitkeep" | xargs rm -rf
rm ./vsftpd/log/*.log
rm ./cert/server.*
rm ./mysql/cnfd/*.cnf
rm ./mysql/log/*.log
find ./mysql/data/ -type f | grep -v -E "\.gitkeep" | xargs rm -rf