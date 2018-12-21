import yaml   
import commands

path='user_data'
f=open(path)  
CONFDIC=yaml.load(f) 
user=CONFDIC['users'][0]['name']
sshkey=CONFDIC['users'][0]['ssh-authorized-keys'][0]
hostname=CONFDIC['hostname']
ifname=CONFDIC['centos']['units'][0]['name']
ifcfg=CONFDIC['centos']['units'][0]['content']
ifcfgpath='' 
#ifcfgpath='/etc/sysconfig/network-scripts/'
sshkeypath=''
#sshkeypath='/root/.ssh/'

(status,datevalue) = commands.getstatusoutput('echo """'+ifcfg+'""">'+ifcfgpath+ifname)
(status,datevalue) = commands.getstatusoutput('echo """'+sshkey+'""">'+sshkeypath+'authorized_keys')
(status,datevalue) = commands.getstatusoutput('hostnamectl set-hostname '+hostname)

print CONFDIC['users'][0]['name']
print CONFDIC['users'][0]['ssh-authorized-keys'][0]
print CONFDIC['hostname']
print CONFDIC['centos']['units'][0]['name']
print CONFDIC['centos']['units'][0]['content'].split('\n')

#messages=CONFDIC['centos']['units'][0]['content'].split('\n')
#dicmess={}
#for  m  in messages :
#    if m.find('=') != -1:
#        tmp=m.split('=')
#        dicmess[tmp[0]]=tmp[1]
#for key in dicmess:
#    print 'dicmess:',key,dicmess[key]

