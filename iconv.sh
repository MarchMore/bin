#!/bin/bash
# Program:
#       转换文件编码gb2312->utf-8,单个文件及批处理文件均可
# History:
# 2013/1/1          yangning       First Release
# 2013/03/01	    yangning	   Second Release
#	增加对较大文件的转码支持
export PATH

STRING="ISO"

for FILE in $@
do
    file $FILE | grep -q "$STRING" #检测文件是否有转换的必要
    if [ $? -eq 0 ]; then 
	dos2unix $FILE
	iconv -f gbk -t utf-8 $FILE -o test.txt
	mv test.txt $FILE
    fi
done

exit 0
