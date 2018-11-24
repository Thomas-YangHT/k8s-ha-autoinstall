#!/usr/bin/python
# -*- coding: UTF-8 -*-
from flask import Flask
from flask import request
import MySQLdb
import sys,urllib,urllib2
import commands

def GETD():
    ClassName="1807"
    TestLevel=1
    conn=MySQLdb.connect(host='172.16.254.110',user='yanght',passwd='yanght',db='students',port=3306,charset='utf8')
    cur=conn.cursor()
    sql1=("select a.name,b.* from base as a,chengji as b where a.stud_no=b.stud_no and a.stud_no like '"+ClassName+"%'")
    sql=("select * from base order by stud_no")
    if TestLevel == 1 :
        sql=sql1
    ret=sql
    count=cur.execute(sql)
    ret+= 'there has %s rows record.' % (count)
    ret+=ClassName
#    if count != 0 :
#        result1=cur.fetchall()
#    for row1 in result1 :
#        for i in row1 :
#            ret+=" %s " % i
                
    index = cur.description
    result = []
    row = {}
    for res in cur.fetchall():
        for i in range(len(index)-1):
            row[index[i][0]] = res[i]
        result.append(row)
    for key in row :
        ret+= key+':'+"%s, " % row[key]
    print result
    conn.commit()
    cur.close()
    conn.close()
   # except MySQLdb.Error,e:
   #     ret= "Mysql Error %d: %s" % (e.args[0], e.args[1])
    content=ret
    print content

GETD()

