#!/usr/bin/python


import sys
import argparse
import urllib2
import json
import threading
from datetime import datetime  

api_getspecs = '/api/getspecs'
api_runspec = '/api/runspec/'
api_runall = '/api/runall/'
host_url = 'http://localhost:8000'


def main(argv):
    parser = argparse.ArgumentParser()
    parser.add_argument('-s', '--server', dest='server_url', default=host_url)
    parser.add_argument('-f', '--format', dest='output_format', default='document')
    args = parser.parse_args()

    response = urllib2.urlopen(args.server_url + api_getspecs)
    spec_list = json.loads(response.read())    
    
    print('{0}\n{1}\n{2}'.format(bcolors.OKGREEN, '* starting tests for: ', bcolors.ENDC))
    for spec in spec_list:
        print('{0}{1}'.format('- ', spec['specFile']))

    print('{0}\n{1}\n{2}'.format(bcolors.OKGREEN, '* waiting for the result...', bcolors.ENDC))

    start_time=datetime.now()

    threads =[]
    for spec in spec_list:
        url = args.server_url + api_runspec + args.output_format + '/' + spec['specFile']
        o = urllib2.build_opener(TestHandler())
        t = threading.Thread(target=o.open, args=(url,))
        threads.append(t)
        t.start()

    for t in threads:
        t.join()
    
    end_time=datetime.now()

    elapse_time=end_time - start_time
    
    print('{0}{1}{2}'.format(bcolors.HEADER, '-'*32, bcolors.ENDC))
    print('{0}{1}\t{2}{3}'.format(bcolors.HEADER, 'start time:', start_time.strftime("%H:%M:%S.%f"), bcolors.ENDC))
    print('{0}{1}\t{2}{3}'.format(bcolors.HEADER, 'end time:', end_time.strftime("%H:%M:%S.%f"), bcolors.ENDC))
    print('{0}{1}\t{2} {3}{4}\n'.format(bcolors.HEADER, 'elapse time:', str(divmod(elapse_time.total_seconds(), 60)[1]), 'seconds', bcolors.ENDC))

class TestHandler(urllib2.HTTPHandler):
    def http_response(self, req, response):
        #print "spec: %s" % (response.geturl(),)
        print(response.read())
        return response

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
