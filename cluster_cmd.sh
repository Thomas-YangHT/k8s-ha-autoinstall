source ./CONFIG
ips=(`echo $NODES|sed 's/,/ /g'`)

for i in ${ips[*]}
do 
    [ -n "$1" ] && ssh $REMOTE_USER@$i $1
done
