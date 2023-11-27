#!/bin/bash

#parameters check
if [ $# -lt 1 ];then
   echo "Parameters not given"
   echo "Usage: sudo user_konta.sh [username1] [username2] ..."
   exit 1
fi

#user creation
for user in $@;do

   if id -u "$user" >/dev/null 2>&1; then
      echo "user: $user already exists"
   else
      useradd -m "$user"
      echo -e "$user\n$user" | passwd "$user"  >/dev/null 2>&1
      passwd -e "$user" > /dev/null 2>&1
      echo "user: $user created sucessfully"
   fi	
done
