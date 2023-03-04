#!/bin/sh
if test $(whoami) = "root"
then
	echo "输入1启用BBR,2检查状态"
	read -p "请输入:" select
	if test $[select] -eq 1
	then
		echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf
		echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf
		echo "已开启，请确认"
	fi
	if test $[select] -eq 2
	then
		sysctl -p
		sysctl net.ipv4.tcp_available_congestion_control
		lsmod | grep bbr
	fi
else
	echo "请切换到root账户下使用"
fi
