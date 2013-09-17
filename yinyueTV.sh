#!/bin/bash
# Program:
#       下载音悦台上的MV
# History:
# 2012/12/29        yangning       First Release
# 
# 2013/03/11	    yangning       Second Release
# 增加了清理重复下载的html网页功能；去掉了Title后的'\r',即dos2unix
#
# 2013/05/13        yangning       Third Release
# 清除用户强制中断后未完成的下载
export PATH
DIR=/mnt/myData3/MV/
dir=~/bin/

cd $dir

# 若中断下载，清除下载过的html及.mp4文件并退出
trap 'rm -f "${Title}.mp4" ${FILE} && exit 0' INT

# 给定url 下载网页
if [ -z $1 ]; then
    echo Usage:$0 URL.
    exit 1
fi

var=$1
FILE=`echo ${var##*/}`
wget $1 -O $FILE
dos2unix $FILE

# 分析下载的html文件，找出含有hcVideoUrl的那一行，提取url
#Title=`cat $FILE | grep "<title>" | cut -c 9- | cut -d '-' -f 1-2`
Player=`grep "<title>" $FILE | cut -c 17-` # 歌手名字
Video=`grep -A 1 "<title>" $FILE | tail -n 1 | cut -d '-' -f 2` # mv名字
Title="$Video--$Player"
VideoUrl=`cat $FILE | grep hcVideoUrl | cut -d "'" -f 2`
wget -O "${Title}.mp4" $VideoUrl

# 移动MV到指定目录    
if [ -e $DIR ] && [ -d $DIR ]; then
    mv "${Title}.mp4" $DIR/
fi

# 清理垃圾
rm ${FILE}

exit 0
