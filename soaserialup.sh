#!/bin/sh
#
# shell script to increment DNS zone SOA serial number
# will increment it with today and 2 digits zero leftpadded
# expects 1 arg: zone filename
#
# requirements: perl
#

PERL=$(which perl)
if [ -z $PERL ]; then
  echo "Error: perl required, not found"
  exit 1
fi

if [ -z $1 ] || [ ! -f $1 ]; then
  echo "Error: can not read specified zone file $1" && exit 1
fi
# get the line with SOA serial, 10 digits
SL=$(grep -E '^[[:blank:]]+[[:digit:]]{10}' $1)
if [ $? -ne 0 ]; then
  echo "Error: could not find SOA serial in $1" && exit 2
fi
# remove blanks, get clean serial, cut it to date and num
ZS=$(echo $SL | awk '{ print $1; }')
DATE1=$(echo $ZS | cut -b1-8)
NUME1=$(echo $ZS | cut -b9-10)
# get date today, compare
DATE2=$(date '+%Y%m%d')
if [ "$DATE1" -eq "$DATE2" ]; then
  # same date, increment num
  NUME1=$(expr $NUME1 + 1);
  NUME1=$(printf '%02d' $NUME1)
  ZS="${DATE1}${NUME1}"
else
  # assign today + 01
  ZS="${DATE2}01"
fi

$PERL -pi -e 's/^(\s+)\d{10}(.*$)/${1}'$ZS'${2}/' $1
