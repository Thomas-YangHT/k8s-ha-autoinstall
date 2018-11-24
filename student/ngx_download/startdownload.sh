rm -rf /var/log/nginx
rm -rf /etc/nginx 
ln -s /nfs253/download/ /opt/download
ln -s /nfs253/config/nginxlog /var/log/nginx
ln -s /nfs253/config/ngx_download /etc/nginx

#/usr/bin/spawn-fcgi -a 0.0.0.0 -p 9000 -u nginx -g nginx -f /usr/bin/php-cgi -C 10
/usr/sbin/nginx -g 'daemon off;' -c /etc/nginx/nginx.conf
