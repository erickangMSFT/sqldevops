# &#8756; Slacker Node Runner Service
&#8712; devops

### APIs

|express routes|parameters|description|output format|
|:-------------|:---|:---------------------|:---|
|/api/getspecs||return all test specs in a slacker project 'spec' folder and sub folders.|json|
|/api/runall|/:format|run test examples in all specs in a slacker project 'spec' folder and sub folders. |json, html, document|
|/api/runspec|/:format/:forlder/:filename /:format/:filename|run test examples in a *.rb rspec file|json, html, document|

### Sample Usage

* get all spec list
    * [json output](/api/getspecs)
* run all specs
    * [html output](/api/runall/html)
    * [json output](/api/runall/json)
    * [document output](/api/runall/document)
* run a rspec file
    * [html output](/api/runspec/html/sample_1.rb)
    * [json output](/api/runspec/json/sample_1.rb)
    * [document output](/api/runspec/document/sample_1.rb)

> This sample below assumes the slacker node runner service is running at port 80.

```bash
# get the list of all *.rb files in spec folder and its sub folders.
curl -s http://localhost:8000/api/getspecs

# executs all rspec examples in spec folder and sub folders and return the result..
curl -s http://localhost:8000/api/runall/html # result output in html foramt
curl -s http://localhost:8000/api/runall/json # result output in json format
curl -s curl -s http://localhost:8000/api/runall/html # result output in plain text document foramt.

# execute a rspec example file and return the result,
# rspec in the spec root folder.
http://localhost:8000/api/runspec/document/sample_1.rb # plain text document format.
http://localhost:8000/api/runspec/json/sample_1.rb # json format.
http://localhost:8000/api/runspec/html/sample_1.rb # html format.

# rspec in a sub folder or spec root foler.
http://localhost:8000/api/runspec/document/website/activateWebsiteLogon.rb # pain text document format
http://localhost:8000/api/runspec/json/website/activateWebsiteLogon.rb # json format
http://localhost:8000/api/runspec/html/website/activateWebsiteLogon.rb # html format

```

### Runner Controller

Find and list all rspec example files and asynchronously run each rspec. Use this script for parallel testing with Azure Container Service.
Output format

* run.sh -f document
* run.sh -f json
* run.sh -f html

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

curl -s http://localhost:8000/api/getspecs | jq -r '.[] | .specFile'

start=$SECONDS

for spec in $(curl -s http://localhost:8000/api/getspecs | jq -r '.[] | .specFile'); do
    url='http://localhost:8000/api/runspec/'${format}'/'$spec
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

&#169; eric kang (MIT License)