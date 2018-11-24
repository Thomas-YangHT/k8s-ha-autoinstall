<?php

function  show_logform(){ 
        $linenum= $_POST["linenum"]; #log query line number
        echo "<form name='formlog' action='$PHP_SELF' method='post' >\n";
        echo "输入查询".$hn."行数(Max 1000行):<input type='text' name='linenum' value='100'>\n";
        echo "<input name='submitlog' class='shiny-blue' type='submit' value='查询' /> \n";
        echo " </form> \n";
        if( isset($linenum)   ){
             show_log($linenum); 
             exec("sudo sh -c \"echo $linenum >/root/linenum\"",$tmp,$out);
        }
   
}

function  show_log($linenum=0){
   if($linenum>1000){$linenum=1000;}
   if($linenum<=0){$linenum=100;}
   exec("sudo -u root tail -n $linenum /root/dk.log",$tmp4,$tmpout);
   foreach ($tmp4 as $a){
        echo "$a</br>"; 
   } 
}

show_logform();

?>