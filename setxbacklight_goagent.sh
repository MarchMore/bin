#!/bin/bash
# program:
#	设置背光亮度及使用goagent代理
# History:
# 2013/02/25	yangning 	First Release
export PATH

# 设置背光亮度

# gnome3
#xbacklight -set 70 (待考究)

# nemo/unity
pkexec /usr/lib/gnome-settings-daemon/gsd-backlight-helper --set-brightness 8

# 使用goagent代理

DIR=/mnt/myData2/GoAgent/local
python $DIR/proxy.py

exit 0
# end
