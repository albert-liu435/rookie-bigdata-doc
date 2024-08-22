#!/bin/bash
source /etc/profile
cd /data/callcenter/callcenter-online-vue
#cd /data/callcenter/callcenter-vue
result=`git pull`
echo "$result"
if [[ $result == "Already up to date." ]]
then
  echo "Already up-to-date."
else
  #cp -r /data/callcenter/callcenter-online-vue/* /data/callcenter/callcenter-vue
  #cp -r /data/callcenter/callcenter-vue/* /data/callcenter/callcenter-online-vue
  #cd /data/callcenter/callcenter-online-vue/
  #rm -rf /data/callcenter/callcenter-online-vue/dist
  npm install
  npm run build-prod
  echo "deploy success"
fi
