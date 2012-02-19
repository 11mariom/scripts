#!/bin/bash

city="PLX0025"
#tmpdir=/tmp/weather

#mkdir ${tmpdir}

curl -s "http://rss.accuweather.com/rss/liveweather_rss.asp?metric=1&locCode=EUR|PL|PL016|SZCZECIN" | awk '/<title>Currently/ {print $2, substr($3, 0, length($3)-9) "Â°C"}'
#| grep "<title>Currently" | tr -s '<-' \ | awk '{print $2,$3}' | sed 's/C/°C/' 

#cat /tmp/cond
