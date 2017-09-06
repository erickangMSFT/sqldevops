#!/bin/bash

# Usage: ./run.sh -f {document, json, html} default = document view.

format='document' #default format
while [[ $# -gt 1 ]]
do
key="$1"
case $key in
    -f|--format)
    format="$2"
    shift 
    ;;
    *)
    ;;
esac
shift 
done

printf "\n" && printf '\e[1;34m%-6s\e[m' "* starting tests for:" && printf "\n"
starttime=$(gdate +"%Y-%m-%d %H:%M:%S %3N")

curl -s http://localhost/api/getspecs | jq -r '.[] | .specFile'

start=$SECONDS

for spec in $(curl -s http://localhost/api/getspecs | jq -r '.[] | .specFile'); do
    url='http://localhost/api/runspec/'${format}'/'$spec
    curl -s $url & 
done

printf "\n" && printf '\e[1;34m%-6s\e[m' "* waiting for the results..." && printf "\n" 

wait
printf "\n" 
duration=$(( SECONDS - start )) && endtime=$(gdate +"%Y-%m-%d %H:%M:%S %3N")
printf '\e[1;36m%-6s\e[m' "--- summary ---" && printf "\n" 
printf '\e[1;36m%-6s\e[m' "start time:  " && printf "%s %s %s\n" $starttime
printf '\e[1;36m%-6s\e[m' "end time:    " && printf "%s %s %s\n" $endtime
printf '\e[1;36m%-6s\e[m' "elapse time: "  && printf "%s seconds\n\n" $duration













# Black        0;30     Dark Gray     1;30
# Red          0;31     Light Red     1;31
# Green        0;32     Light Green   1;32
# Brown/Orange 0;33     Yellow        1;33
# Blue         0;34     Light Blue    1;34
# Purple       0;35     Light Purple  1;35
# Cyan         0;36     Light Cyan    1;36
# Light Gray   0;37     White         1;37