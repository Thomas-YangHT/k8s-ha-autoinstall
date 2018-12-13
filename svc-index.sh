sh install.sh getsvc|awk -F'out:' '{print $2}'|\
grep -vP "None|dns|^$"|head -n -1|\
awk '{print $2"\t"$4"\t"$6}'|\
sed -e 's/:/ :/g' -e "s#/TCP##g"|\
awk 'NR==1{print "<h1>SVC simple index</h1>(add route first by: <b>route add  10.0.0.0 mask 255.0.0.0 [your any nodeIP]</b>)</br></br>"}\
NR>1{print "<li>"$0"\t\t\t\t<a href=\"http://"$2":"$3"\">http://"$1"</a>\
\t<a href=\"https://"$2":"$3"\">https://"$1"</a></li></br>"}'\
> svc.html
