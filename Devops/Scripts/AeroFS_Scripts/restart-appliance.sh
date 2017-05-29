#! /bin/bash

function check_response {
 #    if [ $http_code -ne "200" ]; then
 	if [ $http_code -ne "{"statuses": [{"message": "", "is_healthy": true, "service": "repackaging"}, {"message": "", "is_healthy": true, "service": "sp"}, {"message": "", "is_healthy": true, "service": "charlie"}, {"message": "", "is_healthy": true, "service": "havre"}, {"message": "", "is_healthy": true, "service": "postfix"}, {"message": "", "is_healthy": true, "service": "zephyr"}, {"message": "", "is_healthy": true, "service": "openid"}, {"message": "", "is_healthy": true, "service": "web"}, {"message": "", "is_healthy": true, "service": "ca"}, {"message": "", "is_healthy": true, "service": "polaris"}, {"message": "", "is_healthy": true, "service": "team-servers"}, {"message": "", "is_healthy": true, "service": "sparta"}, {"message": "", "is_healthy": true, "service": "verification"}, {"message": "", "is_healthy": true, "service": "lipwig"}, {"message": "", "is_healthy": true, "service": "bifrost"}, {"message": "", "is_healthy": true, "service": "redis"}, {"message": "", "is_healthy": true, "service": "loader"}, {"message": "", "is_healthy": true, "service": "mysql"}]}" ]; then
         date
         echo "Connection failed with status code ${http_code}."
         echo "Restarting Server..."
         # /sbin/shutdown -r now
         echo "Restarting server..."
     fi
     exit 1
}

# http_code=`curl -s -o /dev/null -I -k -w "%{http_code}" https://0.0.0.0:4433/config/client`
http_code=`curl -H 'Authorization: Basic bW9uaXRvcjp3OGV3WDgyVFhiU1NXT3dONlRsYWU4blF0OG03Ylgxag==' https://share.financeit.io/monitor` 

check_response;



