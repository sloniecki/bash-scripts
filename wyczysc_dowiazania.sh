#!/bin/bash

#parameters check
if [ $# -ne 2 ];then
   echo "error, not 2 parameters were given"  
   echo "Usage: wyczysc_dowiazania.sh [destination directory] [log file]"
   exit 1
fi

#check if log file  is normal file and exists
if [ ! -f "$2" ];then
   echo "log file is not a normal file or does not exist"
   exit 2
fi

#check premisions for log file 
if ! [[ -w "$2" && -r "$2" ]];then
   echo "you dont have premisions to read or write in log file"
   exit 3
fi

#check premisions to directory
if ! [[ -w "$1" && -r "$1" && -x "$1" ]];then
   echo "you dont have premisions to read, write or execute in directory"
   exit 4
fi

#deleting sym links 
for file in "$1"/*; do
   if [[ -L "$file" && -w "$file" ]];then
      link=true
      read -p "Do you want to delete $file (y/n):  " del
      if [ "$del" == "y" ];then
         rm "$file"
         echo "$file" >> "$2"
      fi
   fi
done

#if there is not any symlinks in directory
if [ ! "$link" ];then
   echo "no symbolic links in directory or no premisions to delete them"
   exit 5
fi

