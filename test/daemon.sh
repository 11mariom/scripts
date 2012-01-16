#!/bin/bash
echo $_
echo $$

loop() {
    while (true)
    do
	echo "teeest"
	sleep 1s
    done
}

case $1 in
    start)
	echo $$
	echo $$ > daemon.pid
	loop >> daemon.log &
	;;
    stop)
	kill $( cat daemon.pid )
	;;
    *)
	;;
esac

