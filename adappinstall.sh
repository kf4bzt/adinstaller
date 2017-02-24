#!/bin/bash
#
#This script will execute yum commands for RedHat / CentOS to install
#packages needed for the AD implementation
#

hostname = $(hostname)

#
#Install the packages needed for remote authentication. I added the -y switch to automatically
#issue yes to the yum installer.
#

yum -y install realmd sssd oddjob oddjob-mkhomedir adcli samba-common samba-common-tools ntpdate ntp krb5-workstation

#
#Make sure that the ntp service daemon is enabled, updated with the AD Realm
#and set to be on at boot up
#
#For RHEL 7 and CentOS 7, the systemctl command is used due to the implementation of systemd
#For RHEL 6 and CentOS 6 and below, a service ntpd start will work
#

systemctl enable ntpd.service
chkconfig --levels 2345 ntpd on
ntpdate DC01.bic-bill.com
systemctl start ntpd.service

#
#There are some files which need to be copied into place to make the connection
#To the AD Realm successful. You will need the /etc/krb5.conf file, the /etc/sssd/sssd.conf file
#and the /etc/samba/smb.conf file. 
#

cp krb5.conf /etc/krb5.conf
cp sssd.conf /etc/sssd/sssd.conf
cp smb.conf /etc/samba/smb.conf

#
#Now restart all services that have to do with this project
#

systemctl restart krb5
systemctl restart sssd
systemctl smb

#
#Test the configuration and send output to a text file labeled the server hostname
#
#realm list - gives back information about the AD Realm
#realm discover - checks to make sure the connection to the AD Realm is up and pulls information
#adcli info - pulls domain specific information about an AD domain name
#

realm list >> $hostname
realm discover >> $hostname
adcli info bic-bill.com >> $hostname


