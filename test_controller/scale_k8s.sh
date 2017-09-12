#!/bin/bash

kubectl scale deployment slacker --replicas=3 -n sqldevops
watch kubectl get pods -n sqldevops
