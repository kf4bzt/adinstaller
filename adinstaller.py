#!/bin/python
# This script is used to transfer and kick off a remote script
# which will install packages needed for Active Directory
# implementation on linux servers.

import os, subprocess
import re
import sys
import string
import datetime
import paramiko
from time import strftime
# import pexpect

# Hardcode credentials

username = 'username'
password = 'password'
cmd = 'uname -a'
file_name = 'serverlist'
host = ''
iplist = open(file_name, 'r')
temp = open('temp.txt', 'a')
for data in iplist:
        host = data

# Now execute the command for each host within the loop and
# store it in another file

ssh = paramiko.SSHClient()
ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
ssh.connect(host, username=username, password=password)
stdin, stdout, stderr = ssh.exec_command(cmd)

# VIEW THE OUTPUT ALONG WITH A TIME STAMP

output = stdout.readlines()
date = strftime("%d-%m-%Y")
time = strftime("%H:%M:%S")
print >>temp, date, time, host, str(output)


temp.close()


iplist.close()