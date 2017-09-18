#!/bin/bash

kubectl describe pods -n sqldevops | grep -e 'slackeri-' -e 'PORT:' -e 'Name:' -e 'IP:' -e 'Status:'
