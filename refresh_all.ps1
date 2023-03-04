rm ./apache/confd/*.conf
rm ./apache/log/*_log
Remove-Item ./apache/www/* -Exclude .gitkeep -Recurse -Force
rm ./php/error_log/*.log
Remove-Item ./vsftpd/user_conf/* -Exclude .gitkeep
rm ./vsftpd/log/*.log
rm ./cert/server.*
rm ./mysql/cnfd/*.cnf
rm ./mysql/log/*.log
Remove-Item ./mysql/data/* -Exclude .gitkeep -Recurse -Force