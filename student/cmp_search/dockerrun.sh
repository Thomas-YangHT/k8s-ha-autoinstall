docker run --name search \
-v /opt/nginxlog:/var/log/nginx \
-v /opt/cmp_search/nginxphp:/etc/nginx \
-v /opt/cmp_search/search.php:/usr/share/nginx/html/index.php \
-v /opt/cmp_search/py-book.php:/usr/share/nginx/html/py-book.php \
-v /opt/cmp_search/startphp.sh:/startphp.sh \
-v /export/download/school/man.linuxde.net:/man.yunwei.edu \
-v /export/download/school/python:/py-book \
-v /opt/cmp_search/sudoers:/etc/sudoers \
-p 8097:80 \
--restart always \
-d 192.168.254.211:5000/centos.fcgi \
sh startphp.sh
