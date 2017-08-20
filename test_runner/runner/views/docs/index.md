# Slacker Node Runner
Welcome to Slacker node runner. This is a demonstration purpose only.

* item 1
* item 2
* item 3

**test**

> this is a note


### APIs

|routes        |description|output format|
|:-------------|:---------------------|:---|
|/api/getspecs|get all test specs|json|
|/api/runall|run all test specs|json, html, document|
|/api/runspec|run test spec in a rspec file|json, html, document|

### Sample Usage

```bash
# get the list of all *.rb files in spec folder and its sub folders.
curl -s http://localhost/api/getspecs


curl -s http://localhost/api/runall/html

http://localhost/api/runall/html

http://localhost/api/runall/html

http://localhost/api/runspec/document/website/activateWebsiteLogon.rb

```

### Runner Controller

```bash
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

```