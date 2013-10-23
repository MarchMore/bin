#!/bin/bash
# Program:
#        autotools自动化脚本,适应大部分情况
# History:
# 2013/08/15       yangning       First Release

export PATH
EDITOR=emacsclient		# 默认编辑器

## autoscan and edit
function autoscan_fun() {
AM_INIT_AUTOMAKE="AM_INIT_AUTOMAKE([-Wall -Werror])"
#AC_CONFIG_FILES="AC_CONFIG_FILES([Makefile])" 

# 进入源代码目录执行autoscan
autoscan && mv configure.scan configure.ac
# 添加必要的信息
sed -i "5a ${AM_INIT_AUTOMAKE}" configure.ac
codeno=`ls -l | grep Makefile`
if [ $? == 0 ]; then
	echo "do nothing" &> /dev/null
else
	sed -i '$i AC_CONFIG_FILES([Makefile])' configure.ac
fi
sleep 1s
$EDITOR configure.ac	# 手动编辑configure.ac文件
}


## 使用aclocal命令，扫描configure.ac文件生成aclocal.m4文件
function aclocal_fun() {
    aclocal
}


## 使用autoconf命令生成configure文件
function autoconf_fun() {
    autoconf
}


## 使用autoheader命令生成config.h.in文件
function autoheader_fun() {
    autoheader
}


## 使用automake工具
function automake_fun() {
    # 手工创建Makefile.am文件
    printf "%s\n" "SUBDIRS = "    >> Makefile.am
    sleep 1s
    $EDITOR Makefile.am

    # 两次使用automake自动添加一些必需的脚本文件
    automake --add-missing &> /dev/null  
    automake --add-missing &> /dev/null

    # 创建未发现的文件
    touch NEWS README AUTHORS ChangeLog
    
    automake --add-missing
}



echo "------------automake自动化脚本工具---------------"
sleep 1s
autoscan_fun     && 
aclocal_fun      &&
autoconf_fun     &&
autoheader_fun   &&
automake_fun
echo "Done!"

exit 0
