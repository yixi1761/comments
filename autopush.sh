#!/bin/bash
git add .
msg=修改时间:$(date "+%Y-%m-%d,%H:%M")
echo $msg
git commit -m ${msg}
git push coding master

