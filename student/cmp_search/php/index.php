<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
</head>

<?php

function  show_cmdform(){ 
        $CMD= $_POST["CMD"]; #log query line number
      #  echo "<meta http-equiv='Content-Type' content='text/html; charset=utf-8' /> ";
        echo "<form name='formlog' action='$PHP_SELF' method='post' >\n";
        echo "输入查询".$hn."command:<input type='text' name='CMD' value=''>\n";
        echo "<input name='submitlog' class='shiny-blue' type='submit' value='查询' /> \n";
        echo " </form> \n";
        if( isset($CMD)   ){
             show_cmd($CMD); 
             exec("sudo sh -c \"echo $CMD >/root/CMD\"",$tmp,$out);
        }
   
}

function  show_cmd($CMD=0){
   exec("cat /man.yunwei.edu/$CMD.html ",$tmp4,$tmpout);
   echo "$tmpout:".$tmpout;
   if($tmpout!=0){ 
       echo "Not exists,wait to download.. ";
       $down_cmd="sudo curl -o $CMD man.linuxde.net/$CMD 2>&1;sudo sed -i 's/man.linuxde.net/man.yunwei.edu/g' $CMD 2>&1;sudo mv $CMD /man.yunwei.edu/$CMD.html 2>&1;";
       exec($down_cmd,$tmp,$out);
       print_r ($tmp);
       echo $tmp[0].":".$out;
       echo "download finish,try again...";
       exec("cat /man.yunwei.edu/$CMD.html",$tmp4,$tmpout);
   #    $index_cmd="sudo ls /man.yunwei.edu/*html|awk '{print \"<a href=\\\"http://man.yunwei.edu/\"$1\"\\\">\"$1\" </a> </br>\"}' >/man.yunwei.edu/index.html";
       $index_cmd="sudo sh -c \"sh /man.yunwei.edu/gen_index2.sh >/man.yunwei.edu/index.html\"";
       exec($index_cmd,$tmp2,$out);
       print_r ($tmp2);
       echo "out:".$out;
   }
   foreach ($tmp4 as $a){
        echo "$a"; 
   } 
}

show_cmdform();

?>
