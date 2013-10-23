#!/bin/bash
# Program:
#      自动备份～下的文件
# History:
# 2012/12/27        yangning      First Release
# 2013/03/16        yangning      Second Release
# 增加了备份/root/下文件的功能
export PATH

if [ -d /mnt/myData/Backup ]; then
    DIR=/mnt/myData2/Backup
    cd $DIR
fi

# 备份
if [ `whoami` = "yangning" ]; then 
    rm -f *yangning.tar.bz2
    tar -jcv -f `date +%Y%m%d`backup_yangning.tar.bz2 /home/yangning/
elif [ `whoami` = "root" ]; then
    tar -jcv -f `date +%Y%m%d`backup_root.tar.bz2 /root/ARM_workspace/
fi

exit 0
