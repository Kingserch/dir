#!/bin/bash
 
###########################################################
#  description: public key authentication in one step     #
#  author     : king                                      #
###########################################################
 
privkey="$HOME/.ssh/id_rsa"
publickey="$HOME/.ssh/id_rsa.pub"
 
# Usage help
if [ $# -ne 1 ];then
   echo "Usage:$0 [user@]hostname"
   exit 1
fi
 
# test private/publick key exist or not, and the privilege 600 or not
if [ -f "$privkey" -a -f "$publickey" ];then
   privkey_priv=`stat -c %a $privkey`
   if [ "$privkey_priv" -ne 600 ];then
       echo "The privilege of private key ~/.ssh/id_rsa is not 600, exit now."
       exit 1
   fi
else
   echo "private/public key is not exist, it will create it"
   ssh-keygen -t rsa -f $privkey -N ''
   echo "keys created over, it located on $HOME/.ssh/"
fi
 
ssh-copy-id "-o StrictHostKeyChecking=no $1"
 
if [ $? -eq 0 ];then
   echo -e "\e[31m publickey copy over \e[0m"
else
   echo "ssh can't to the remote host"
   exit 1
fi
