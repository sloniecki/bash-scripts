#!/bin/bash

#parameters check
if [ $# -lt 2 ];then
   echo "error, less then 2 parameters were given"  
   echo "Usage: prawa_dostepu.sh [premisions (eg.777)] [file1] [file2] ..."
   exit 1
fi

#check if premisions are 3 numbers from 0 to 7
if [[ ! $1 =~ ^[0-7]+$ ]] || [ ${#1} -ne 3 ] ; then
   echo "error, wrong first parameter"
   echo "first parameter should contain 3 digits from 0 to 7"
   exit 2
fi

#changing premisions 
for file in "${@:2}";do
   if [ ! -w "$file" >/dev/null 2>&1 ]; then
      echo "flie:$file do not exist or you dont have premisions to modify it"
      continue
   else
      chmod "$1" "$file"
      echo "$file premisions changed successfully"
   fi
done

