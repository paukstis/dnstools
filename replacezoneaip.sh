#!/bin/sh
#
# script to replace A record IP address
# expects 3 input args:
#   zonefile - DNS zone text file, BIND/NSD format
#   name - hostname which A record will be replaced
#   ip - ipv4 IP address to replace, no validation
#
# requirements: perl
#

PERL=$(which perl)
if [ -z $PERL ]; then
  echo "Error: perl required, not found"
  exit 1
fi

usage() {
  echo "Usage: $0 zonefile name ip"
  exit 1
}

if [ -z $1 ] || [ -z $2 ] || [ -z $3 ]; then
  usage
fi

ZONEFILE=$1
NAME=$2
AIP=$3

if [ ! -f $ZONEFILE ]; then
  echo "Error: can not open specified zone file $ZONEFILE"
  exit 2
fi

$PERL -pi -e 's/^('$NAME'\s+A\s+)\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}(.*$)/${1}'$AIP'${2}/' $ZONEFILE
