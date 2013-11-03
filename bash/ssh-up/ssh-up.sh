#!/usr/bin/env bash

get_chmod() {
    mode=$( stat -c %a "$file" )
    echo $mode
}

help() {
    cat <<EOF
ssh-up <options> FILE1 [FILE2 …]
Options:
-h		help
-c conf		config file
-s serv		server adress
-w wwwdir	www directory
-p port		ssh port
EOF
}

ARGC=$#
ARGV=("$@")
SERVER=""
WWWPATH=""
SSHPORT=""

shift_n=0

while getopts "h:s:w:p:c" opt; do
    case $opt in
	h)
	    help
	    exit 0
	    ;;
	s)
	    SERVER=$OPTARG
	    shift_n=$(( shift_n + 2 ))
	    ;;
	w)
	    WWWPATH=$OPTARG
	    shift_n=$(( shift_n + 2 ))
	    ;;
	p)
	    SSHPORT=$OPTARG
	    shift_n=$(( shift_n + 2 ))
	    ;;
	c)
	    source $OPTARG
	    shift_n=$(( shift_n + 2 ))
	    ;;
	\?)
	    help
	    exit 1
	    ;;
    esac
done

shift $shift_n

while [[ $# > 0 ]]; do
    file=$1
    echo $file
    #get filename from path
    basefile="$( basename $file )"
    #change spaces to _
    basefile=${basefile// /_}
    mode=$( get_chmod "$file" )

    #check if file with the same name already exists on www server
    if [[ $( curl -Is http://$SERVER/$basefile | head -n1 | grep "200" ) ]]
    then
	echo "File exists!"
	exit 1
    fi

    echo "uploading $file"
    chmod 644 "$file"

    scp -P$SSHPORT "$file" "$USER@$SERVER:$WWWPATH/$basefile" > /dev/null 2>&1
    exitcode=$?
    chmod $mode "$file"

    if [[ exitcode -ne 0 ]]
    then
	echo "Error!"
	exit 1
    else
	echo "http://$SERVER/$basefile"
    fi

    shift
done

