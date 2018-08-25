#!/bin/bash
cd /aom
git fetch origin
GITHASH=`curl -L $CONTROLLERURL`
echo GITHASH $GITHASH
git checkout $GITHASH
cd /aom_build
cmake /aom
make
{ time ./aomenc --limit=100 -o niklas.webm -w 640 -h 480 ../aom_test_data/niklas_640_480_30.yuv ; } 2>&1 | tee time.txt
grep user time.txt > result.txt
cat result.txt
curl -L -X POST --post301 --post302 --post303 --data "hash=$GITHASH" --data-urlencode "result@result.txt" $CONTROLLERURL