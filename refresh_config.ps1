rm ./apache/confd/*.conf
rm ./apache/log/*.log
rm ./php/error_log/*.log
Remove-Item ./vsftpd/user_conf/* -Exclude .gitkeep
rm ./vsftpd/log/*.log
rm ./cert/server.*
rm ./mysql/cnfd/*.cnf
rm ./mysql/log/*.log