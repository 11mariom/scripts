#!/bin/sh

url="http://www.urbandictionary.com/"

curl --silent $url | awk "/<div class='word'>/||/<div class='definition'>/,\
     /<\/div>/ {gsub(/<[^>]*>/, \"\"); { if (/./) print };}" | head -n2

