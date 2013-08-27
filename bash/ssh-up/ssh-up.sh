#!/usr/bin/env bash

get_chmod() {
    mode=$( stat -c %a "$file" )
    echo $mode
}

ARGC=$#
ARGV=("$@")
SERVER=""
WWWPATH=""
SSHPORT=""

for ((i = 0; i < $ARGC; i++)); do
    file=${ARGV[i]}
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

    echo "$i. $file"
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
done

