/usr/sbin/nginx -c /uwsgi/nginx.conf
[ -d /run/uwsgi ] || mkdir /run/uwsgi
uwsgi /uwsgi/testflk.ini
while [[ true ]]; do 
    sleep 1 
done
