docker run --name uwsgi \
-v /opt/python/uwsgi:/uwsgi \
--restart=always \
--dns=192.168.32.1 \
-e TZ='Asia/Shanghai' \
-p 8101:80 \
-d python \
sh /uwsgi/startpython.sh
