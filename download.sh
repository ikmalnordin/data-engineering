#!/bin/bash

# STEP 1a: Insert password and username

# STEP 1b: SOURCE has to be defined in Cloud Shell or added in line below. 
# e.g. SOURCE=https://transtats.bts.gov/PREZIP

if test "$#" -ne 2; then
   echo "Usage: ./download.sh year month"
   echo "   eg: ./download.sh 2015 1"
   exit
fi

YEAR=$1
MONTH=$2
#STEP 2: Change BASEURL to client website
BASEURL="${SOURCE}/On_Time_Reporting_Carrier_On_Time_Performance_1987_present"
echo "Downloading YEAR=$YEAR ...  MONTH=$MONTH ... from $BASEURL"


MONTH2=$(printf "%02d" $MONTH)

TMPDIR=$(mktemp -d)

ZIPFILE=${TMPDIR}/${YEAR}_${MONTH2}.zip
echo $ZIPFILE

#STEP 3: make sure that this url follows pattern of client website
curl -o $ZIPFILE ${BASEURL}_${YEAR}_${MONTH}.zip
unzip -d $TMPDIR $ZIPFILE

mv $TMPDIR/*.csv ./${YEAR}${MONTH2}.csv
rm -rf $TMPDIR
