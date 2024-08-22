#!/bin/bash
source /etc/profile
#source /bin/
if [ -z "$1" ];then

   echo "you need a date str , such as 2021010912122 yyyyMMddHHmmss"

   #return 1

  exit 1

fi

cd /data/callcenter/bestseller-callcenter/bestseller-callcenter-online
result=`git pull`
echo "$result"
cur_date=$1
#cur_date=`date+%Y%m%d%H%M%S`
echo "$cur_date"
if [[ $result == "Already up to date." ]]
then
  echo "Already up-to-date."
else
  #cp -r /data/callcenter/callcenter-online-vue/* /data/callcenter/callcenter-vue
  #rm -rf /data/callcenter/callcenter-online-vue/dist
  #npm install
  #npm run build
  mvn clean
  mvn compile
  mvn package
  mv /data/callcenter/bestseller-callcenter/bestseller-callcenter-online.jar /data/callcenter/bestseller-callcenter/bestseller-callcenter-online-${cur_date}.jar.bak
  cp -r /data/callcenter/bestseller-callcenter/bestseller-callcenter-online/target/bestseller-callcenter-online.jar /data/callcenter/bestseller-callcenter/
  cd /data/callcenter/bestseller-callcenter
  sh /data/callcenter/bestseller-callcenter/run.sh
  echo "deploy success"
fi
