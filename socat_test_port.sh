source ./CONFIG
for i in `echo $master,$node|sed 's/,/ /g'`
do
 echo "1" | socat tcp:$i:22 stdio>/dev/null
done
