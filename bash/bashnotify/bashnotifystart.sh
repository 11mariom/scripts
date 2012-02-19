#!/bin/sh
##
# bash notify start script
# mariom 2011

W=${0%/*}
start() {
    if [ -f ${W}/bashnotify.pid ]; then
	echo "Already started!"
    else
	bash ${W}/bashnotify.sh >> ${W}bashnotify.log &
	ps -C 'bash ${W}/bashnotify.sh' -o pid= > ${W}/bashnotify.pid
    fi
}

stop() {
    if [ -f ${W}/bashnotify.pid ]; then
	kill $( cat ${W}/bashnotify.pid )
	rm ${W}/bashnotify.pid
    else
	echo "Not running"
    fi
}

case $1 in
    start)
	start
	;;
    stop)
	stop
	;;
    restart)
	stop && start
	;;
    *)
	echo -e "./bashnotifystart.sh start|stop"
esac
