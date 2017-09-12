#!/usr/bin/python

import sys
import argparse
import urllib2
import json
import threading
import multiprocessing as mp
from datetime import datetime  

api_getspecs = '/api/getspecs'
api_runspec = '/api/runspec/'
api_runall = '/api/runall/'
host_url = 'http://localhost:8000'
http_prefix = 'http://'

def main(argv):
    parser = argparse.ArgumentParser()
    parser.add_argument('-s', '--server', dest='server_url', default=host_url)
    parser.add_argument('-p', '--port', dest='port', default=8000)
    parser.add_argument('-f', '--format', dest='output_format', default='document')
    args = parser.parse_args()

    response = urllib2.urlopen(http_prefix + args.server_url + ':' + str(args.port) + api_getspecs)
    spec_list = json.loads(response.read())    
    spec_urls = [] 
    
    print('{0}\n{1}\n{2}'.format(bcolors.OKGREEN, '* starting tests for: ', bcolors.ENDC))
    for spec in spec_list:
        print('{0}{1}'.format('- ', spec['specFile']))
        url = http_prefix + args.server_url + ':' + str(args.port) + api_runspec + args.output_format + '/' + spec['specFile'] 
        spec_urls.append(url)

    print('{0}\n{1}\n{2}'.format(bcolors.OKGREEN, '* waiting for the result...', bcolors.ENDC))

    start_time=datetime.now()
    
    pool = mp.Pool(processes=mp.cpu_count())
    results = [pool.apply_async(run_spec, args=(url,)) for url in spec_urls]
    output = [p.get() for p in results]
    
    end_time=datetime.now()

    elapse_time=end_time - start_time
    
    print('{0}{1}{2}'.format(bcolors.HEADER, '-'*32, bcolors.ENDC))
    print('{0}{1}\t{2}{3}'.format(bcolors.HEADER, 'start time:', start_time.strftime("%H:%M:%S.%f"), bcolors.ENDC))
    print('{0}{1}\t{2}{3}'.format(bcolors.HEADER, 'end time:', end_time.strftime("%H:%M:%S.%f"), bcolors.ENDC))
    print('{0}{1}\t{2} {3}{4}\n'.format(bcolors.HEADER, 'elapse time:', str(divmod(elapse_time.total_seconds(), 60)[1]), 'seconds', bcolors.ENDC))
    print('{0}processed by {1} cores{2}\n'.format(bcolors.UNDERLINE, mp.cpu_count(), bcolors.ENDC))

def run_spec(req):
    response= urllib2.urlopen(req)
    print (response.read())

class bcolors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'

if __name__ == "__main__":
    main(sys.argv[1:])


# Black        0;30     Dark Gray     1;30
# Red          0;31     Light Red     1;31
# Green        0;32     Light Green   1;32
# Brown/Orange 0;33     Yellow        1;33
# Blue         0;34     Light Blue    1;34
# Purple       0;35     Light Purple  1;35
# Cyan         0;36     Light Cyan    1;36
# Light Gray   0;37     White         1;37
