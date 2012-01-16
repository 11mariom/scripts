#!/bin/zsh

date=$( date +%s )
url="http://pl.wikiquote.org/wiki/Strona_główna?$date"
curl --silent ${url} | awk '/<table align=\"center\"/,/<\/table>/\
            {gsub(/<a href.*">/, "\033[1;38m"); \
             gsub(/<[^>]*>/, ""); { if (/./) print } }'

