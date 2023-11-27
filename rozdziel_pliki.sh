#!/bin/bash

#parameters check
if [ $# -ne 3 ];then
   echo "error, not 3 parameters were given"  
   echo "Usage: rozdziel_pliki.sh [source file] [dest file1] [dest file2]"
   exit 1
fi

#check if parameters are normal files 
for file in "$@";do
   if [ ! -f "$file" ];then
      echo "$file is not a normal file"
      exit 2
   fi
done

#check if source file is readable 
if [ ! -r "$1" ];then
   echo "source file is not readable"
   exit 3
fi

#check if dest files are writable
if ! [[ -w "$2" && -w "$3" ]];then
   echo "destination files are not writable"
   exit 4
fi

#parse file
cat -n "$1" | while read line; do
   if [ $(($(echo "$line" |awk '{print $1}') % 2)) -eq 0 ];then
      echo "$line" >> "$2"
   else
      echo "$line" >> "$3"
   fi
done
