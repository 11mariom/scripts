#!/bin/sh
##
# bash mpd notify 0.1
# mariom 2011

##
# config section
host="127.0.0.1"
port="6000"
format="%artist%\n%title%\n%album%"
covers="$HOME/.config/ario/covers"

##
# get track info
status () {
    command=$( mpc -h ${host} -p ${port} -f ${format} )
    IFS=$'\n'

    # [0] artist, [1] - title, [2] - album, [3] - status, [4] - useless info
    info=( ${command} )
    state=$( expr "${info[3]}" : '\(.*\]\)' )

    if [ $( expr "${info[0]}" : ".*\]" ) == 9 ] || 
	[ $( expr "${info[1]}" : ".*\]" ) == 9 ]
    then
	info[0]="pusty"
	info[1]="tag"
    else
	cover="${covers}/${info[0]}-${info[2]}.jpg"
    fi
}

##
# send notify
send () {
    notify-send "${info[0]}" "${info[1]}\n\n${state}" -i "${cover}" -t 10000
}

##
# check song change
old="dupa"
send
while(true)
do
    status

    new="${info[0]}-${info[1]}"

    if [ ${new} != ${old} ]
    then
	send
    fi

    old=${new}
    sleep 1s
done
