/usr/sbin/nginx -c /etc/nginx/nginx.conf
nohup /usr/bin/spawn-fcgi -a 0.0.0.0 -p 9000 -u nginx -g nginx -f /usr/bin/php-cgi -C 10
while [[ true ]]; do 
    sleep 1 
done 

