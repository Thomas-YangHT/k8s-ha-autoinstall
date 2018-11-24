<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
</head>

<?php

function  show_link(){ 
        $DIRNAME= $_GET["DIRNAME"]; 
		$DIR= $_GET["DIR"];
		$FILE= $_GET["FILE"];
		$LESSON02=array(
		    "01.%BB%F9%B1%BE%B8%C5%C4%EE.py" => "01.基本概念.py",          
			"02.%BB%F9%B1%BE%D3%EF%B7%A8.py" => "02.基本语法.py",            
			"03.%B1%E4%C1%BF%BA%CD%B1%EA%CA%B6%B7%FB.py" => "03.变量和标识符.py",                      
			"04.%CA%FD%D6%B5.py" => "04.数值.py",                                        
			"05.%D7%D6%B7%FB%B4%AE.py" => "05.字符串.py",                                     
			"06.%B8%F1%CA%BD%BB%AF%D7%D6%B7%FB%B4%AE.py" => "06.格式化字符串.py",            
			"07.%B8%B4%D6%C6%D7%D6%B7%FB%B4%AE.py" => "07.复制字符串.py",                                 
			"08.%B2%BC%B6%FB%D6%B5%BA%CD%BF%D5%D6%B5.py" => "08.布尔值和空值.py",                         
			"09.%C0%E0%D0%CD%BC%EC%B2%E9.py" => "09.类型检查.py",                                   
			"10.%C0%E0%D0%CD%D7%AA%BB%BB.py" => "10.类型转换.py",                                
			"11.%CB%E3%CA%F5%D4%CB%CB%E3%B7%FB.py" => "11.算术运算符.py",                         
			"12.%B8%B3%D6%B5%D4%CB%CB%E3%B7%FB.py" => "12.赋值运算符.py",                      
			"13.%B9%D8%CF%B5%D4%CB%CB%E3%B7%FB.py" => "13.关系运算符.py",                  
			"14.%C2%DF%BC%AD%D4%CB%CB%E3%B7%FB.py" => "14.逻辑运算符.py",                  
			"15.%CC%F5%BC%FE%D4%CB%CB%E3%B7%FB.py" => "15.条件运算符.py",   
			"16.%D4%CB%CB%E3%B7%FB%B5%C4%D3%C5%CF%C8%BC%B6.py" => "16.运算符的优先级.py" 
		);
	    $LESSON03=array(
			"01.%CC%F5%BC%FE%C5%D0%B6%CF%D3%EF%BE%E4.py" => "01.条件判断语句.py",
			"02.input%BA%AF%CA%FD.py" => "02.input函数.py",                      
			"03.if-else.py" => "03.if-else.py",                                  
			"04.if-elif-else.py" => "04.if-elif-else.py",                        
			"05.if%C1%B7%CF%B0.py" => "05.if练习.py",                            
			"06.%D1%AD%BB%B7%D3%EF%BE%E4.py" => "06.循环语句.py",                
			"07.%C1%B7%CF%B0.py" => "07.练习.py",                                
			"08.%C1%B7%CF%B0.py" => "08.练习.py",                                
			"09.%C1%B7%CF%B0.py" => "09.练习.py",                                
			"10.%D1%AD%BB%B7%C7%B6%CC%D7.py" => "10.循环嵌套.py",                
			"11.99%B3%CB%B7%A8%B1%ED.py" => "11.99乘法表.py",                    
			"12.%D6%CA%CA%FD%C1%B7%CF%B0.py" => "12.质数练习.py",                
			"13.break%BA%CDcontinue.py" => "13.break和continue.py",              
			"14.%C1%B7%CF%B0%B5%C4%D3%C5%BB%AF.py" => "14.练习的优化.py",        
			"15.game1.0.py" => "15.game1.0.py"    
		);
	    $LESSON04=array(
			"01.%C1%D0%B1%ED%B5%C4%BC%F2%BD%E9.py" => "01.列表的简介.py",
			"02.%C7%D0%C6%AC.py" => "02.切片.py",
			"03.%CD%A8%D3%C3%B2%D9%D7%F7.py" => "03.通用操作.py",
			"04.%D0%DE%B8%C4%D4%AA%CB%D8.py" => "04.修改元素.py",
			"05.%C1%D0%B1%ED%B5%C4%B7%BD%B7%A8.py" => "05.列表的方法.py",
			"06.%B1%E9%C0%FA%C1%D0%B1%ED.py" => "06.遍历列表.py",         
			"07.EMS%C1%B7%CF%B0.py" => "07.EMS练习.py",
			"08.range.py" => "08.range.py",                               
			"09.%D4%AA%D7%E9.py" => "09.元组.py",                         
			"10.%BF%C9%B1%E4%B6%D4%CF%F3.py" => "10.可变对象.py",         
			"11.%D7%D6%B5%E4.py" => "11.字典.py",                         
			"12.%D7%D6%B5%E4%B5%C4%CA%B9%D3%C3.py" => "12.字典的使用.py", 
			"13.%B1%E9%C0%FA%D7%D6%B5%E4.py" => "13.遍历字典.py",         
			"14.%BC%AF%BA%CF.py" => "14.集合.py",                         
			"15.%BC%AF%BA%CF%B5%C4%D4%CB%CB%E3.py" => "15.集合的运算.py" 
		);
	    $LESSON05=array(
			"01.%BA%AF%CA%FD%BC%F2%BD%E9.py" => "01.函数简介.py",                                
			"02.%BA%AF%CA%FD%B5%C4%B2%CE%CA%FD.py" => "02.函数的参数.py",                        
			"03.%B2%BB%B6%A8%B3%A4%B2%CE%CA%FD.py" => "03.不定长参数.py",                        
			"04.%B7%B5%BB%D8%D6%B5.py" => "04.返回值.py",                                        
			"05.%CE%C4%B5%B5%D7%D6%B7%FB%B4%AE.py" => "05.文档字符串.py",                        
			"06.%D7%F7%D3%C3%D3%F2%D3%EB%C3%FC%C3%FB%BF%D5%BC%E4.py" => "06.作用域与命名空间.py",
			"07.%B5%DD%B9%E9.py" => "07.递归.py",                                                
			"08.%B8%DF%BD%D7%BA%AF%CA%FD.py" => "08.高阶函数.py",                                
			"09.%B1%D5%B0%FC.py" => "09.闭包.py",                                                  
			"10.%D7%B0%CA%CE%C6%F7.py" => "10.装饰器.py" 
		);
	    $LESSON06=array(
            "__pycache__/" => "__pycache__/",                                       
            "hello/" => "hello/",                                                   
            "01.%C0%E0%B5%C4%BC%F2%BD%E9.py" => "01.类的简介.py",                   
            "02.%B6%A8%D2%E5%C0%E0.py" => "02.定义类.py",                           
            "03.%B6%D4%CF%F3%B5%C4%B3%F5%CA%BC%BB%AF.py" => "03.对象的初始化.py",   
            "04.%C1%B7%CF%B0.py" => "04.练习.py",                                   
            "05.%B7%E2%D7%B0.py" => "05.封装.py",                                   
            "06.%B7%E2%D7%B0.py" => "06.封装.py",                                   
            "07.%B7%E2%D7%B0.py" => "07.封装.py",                                   
            "08.%BC%CC%B3%D0.py" => "08.继承.py",                                   
            "09.%D6%D8%D0%B4.py" => "09.重写.py",                                   
            "10.%BC%CC%B3%D0.py" => "10.继承.py",                                   
            "11.%B6%E0%D6%D8%BC%CC%B3%D0.py" => "11.多重继承.py",                   
            "12.%B6%E0%CC%AC.py" => "12.多态.py",                                   
            "13.%C0%E0%D6%D0%B5%C4%CA%F4%D0%D4%BA%CD%B7%BD%B7%A8.py" => "13.类中的属性和方法.py", 
            "14.%C0%AC%BB%F8%BB%D8%CA%D5.py" => "14.垃圾回收.py",             
            "15.%CC%D8%CA%E2%B7%BD%B7%A8.py" => "15.特殊方法.py",             
            "16.%C4%A3%BF%E9.py" => "16.模块.py",                             
            "17.%C4%A3%BF%E9.py" => "17.模块.py",                             
            "18.%B0%FC.py" => "18.包.py",                                     
            "19.Python%B5%C4%B1%EA%D7%BC%BF%E2.py" => "19.Python的标准库.py", 
            "m.py" => "m.py",                                                 
            "test.py" => "test.py",                                           
            "test_module.py" => "test_module.py"    		
		);
	    $LESSON07=array(
            "01.%D2%EC%B3%A3.py" => "01.异常.py",                                        
            "02.%D2%EC%B3%A3%B6%D4%CF%F3.py" => "02.异常对象.py",                        
            "03.%C5%D7%B3%F6%D2%EC%B3%A3.py" => "03.抛出异常.py",                        
            "04.%B4%F2%BF%AA%CE%C4%BC%FE.py" => "04.打开文件.py",                        
            "05.%B9%D8%B1%D5%CE%C4%BC%FE.py" => "05.关闭文件.py",                        
            "06.%CE%C4%BC%FE%B5%C4%B6%C1%C8%A1.py" => "06.文件的读取.py",                
            "07.%CE%C4%BC%FE%B6%C1%C8%A1.py" => "07.文件读取.py",                        
            "08.%CE%C4%BC%FE%B5%C4%D0%B4%C8%EB.py" => "08.文件的写入.py",                
            "09.%CE%C4%BC%FE.py" => "09.文件.py",                                        
            "10.%B6%C1%C8%A1%CE%C4%BC%FE%B5%C4%CE%BB%D6%C3.py" => "10.读取文件的位置.py",
            "11.%CE%C4%BC%FE%B5%C4%C6%E4%CB%FB%B2%D9%D7%F7.py" => "11.文件的其他操作.py",
            "aa.flac" => "aa.flac",                                         
            "demo.txt" => "demo.txt",                                       
            "demo2.txt" => "demo2.txt",                                     
            "demo3.txt" => "demo3.txt",                                     
            "demo4.txt" => "demo4.txt",                                     
            "demo5.txt" => "demo5.txt" 		
		);		
        echo "<b><a href=\"http://search.yunwei.edu:8097/py-book.php?DIRNAME=lesson_01_computer_base\">lesson_01_计算机基础知识 </a> </b></br>";
        echo "<b><a href=\"http://search.yunwei.edu:8097/py-book.php?DIRNAME=lesson_02_Python_zero\">  lesson_02_Python入门</a> </b></br>";
		echo "<font size=\"2\">";
		foreach ($LESSON02 as $KEY => $VALUE){
			echo "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<a href=\"http://search.yunwei.edu:8097/py-book.php?DIR=lesson_02_Python_zero&FILE=".$KEY."\">".$VALUE."</a>";
		}
		echo "</font>";
		echo "</br>";
        echo "<b><a href=\"http://search.yunwei.edu:8097/py-book.php?DIRNAME=lesson_03_flow_control\"> lesson_03_流程控制语句</a></b> </br>";
		echo "<font size=\"2\">";
		foreach ($LESSON03 as $KEY => $VALUE){
			echo "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<a href=\"http://search.yunwei.edu:8097/py-book.php?DIR=lesson_03_flow_control&FILE=".$KEY."\">".$VALUE."</a>";
		}
		echo "</font>";
		echo "</br>";
		echo "<b><a href=\"http://search.yunwei.edu:8097/py-book.php?DIRNAME=lesson_04_list\"> lesson_04_序列</a></b> </br>";
		echo "<font size=\"2\">";
 		foreach ($LESSON04 as $KEY => $VALUE){
			echo "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<a href=\"http://search.yunwei.edu:8097/py-book.php?DIR=lesson_04_list&FILE=".$KEY."\">".$VALUE."</a>";
		}
		echo "</font>";
		echo "</br>";
        echo "<b><a href=\"http://search.yunwei.edu:8097/py-book.php?DIRNAME=lesson_05_function\"> lesson_05_函数</a></b> </br>";
		echo "<font size=\"2\">";
 		foreach ($LESSON05 as $KEY => $VALUE){
			echo "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<a href=\"http://search.yunwei.edu:8097/py-book.php?DIR=lesson_05_function&FILE=".$KEY."\">".$VALUE."</a>";
		}
		echo "</font>";
		echo "</br>";		
        echo "<b><a href=\"http://search.yunwei.edu:8097/py-book.php?DIRNAME=lesson_06_object\">lesson_06_对象</a></b> </br>";
		echo "<font size=\"2\">";
 		foreach ($LESSON06 as $KEY => $VALUE){
			echo "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<a href=\"http://search.yunwei.edu:8097/py-book.php?DIR=lesson_06_object&FILE=".$KEY."\">".$VALUE."</a>";
		}
		echo "</font>";
		echo "</br>";
        echo "<b><a href=\"http://search.yunwei.edu:8097/py-book.php?DIRNAME=lesson_07_exception_file\">lesson_07_异常和文件  </a></b></br>";
		echo "<font size=\"2\">";
 		foreach ($LESSON07 as $KEY => $VALUE){
			echo "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<a href=\"http://search.yunwei.edu:8097/py-book.php?DIR=lesson_07_exception_file&FILE=".$KEY."\">".$VALUE."</a>";
		}
		echo "</font>";
		echo "</br>";		 
		echo "<hr>";
        if( isset($DIRNAME)   ){
             show_DIRNAME($DIRNAME); 
        }

        if( isset($DIR) && isset($FILE) ){
			 show_FILE($DIR,$FILE);
		}
}
function  show_FILE($DIR="",$FILE=""){
   #echo "DIR:".$DIR;
   #echo "FILE:".$FILE;
   exec("cat /py-book/01-code-note/$DIR/code/$FILE",$tmp,$tmpout);
   
   #echo "$tmpout:".$tmpout;
   foreach ($tmp as $a){
	   
	   if (strpos($a,"#") === false){
		   $a="<div style=\"color:red\">&nbsp&nbsp&nbsp&nbsp".str_replace(" ","&nbsp",$a)."</div>";
	   }
       echo "&nbsp&nbsp&nbsp&nbsp".$a."</br>"; 
   } 		
}


function  show_DIRNAME($DIRNAME=0){
   exec("cat /py-book/01-code-note/$DIRNAME/README.md",$tmp,$tmpout);
   
   #echo "$tmpout:".$tmpout;
   foreach ($tmp as $a){
	   
	   if (strpos($a,"#") !== false){
		   $a="<div style=\"color:blue\">".$a."</div>";
	   }
       echo $a."</br>"; 
   } 
}


show_link();

?>
