#!/bin/bash
process=`ps -ef |grep shUnicom:run|grep -v grep| awk '{print $10}'`
#判断是否存在进程，不存在直接唤起
#echo $process
percent=4
if [[ $process = "shUnicom:run" ]]
then
	echo "checked！it's exist."
	#判断：如果此时进程内存占用超过6%，kill并重启
	current=`ps aux|grep shUnicom:run |grep -v sudo|grep -v grep| awk '{print $4}'`
	id=`ps aux|grep shUnicom:run |grep -v sudo|grep -v grep|awk '{print $2}'`
	#echo $current
	if [[ `echo "$current > $percent"|bc` -eq 1 ]]
	then
		sudo kill -9 $id
		/usr/local/php/bin/php /home/wwwroot/pay/bestv/artisan shUnicom:run &
		echo "restart it!"
	else
		echo 'still safe!'
	fi
else
	/usr/local/php/bin/php /home/wwwroot/pay/bestv/artisan shUnicom:run &
	echo "wake up!"
fi
