ps auxwww|grep uwsgi|grep -v python|awk '{print $2}'|xargs kill -9
