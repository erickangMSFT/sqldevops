#!/usr/bin/python


import sys
import argparse
import urllib2
import json

def main(argv):
    output_format=''
    hosturl=''
    spec_list=''

    parser = argparse.ArgumentParser()
    parser.add_argument('-s', '--server', dest='server_url', default='http://localhost:8000')
    parser.add_argument('-f', '--format', dest='output_format', default='document')
    parser.add_argument('-v', dest='verbose', action='store_true')
    args = parser.parse_args()

    response = urllib2.urlopen(args.server_url+'/api/getspecs/')
    spec_list = response.read()
    print 'test:'+spec_list


    json.load(spec_list)

if __name__ == "__main__":
    main(sys.argv[1:])
