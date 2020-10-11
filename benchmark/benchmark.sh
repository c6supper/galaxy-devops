#!/bin/sh

#set -xe

AVERAGE_PARAMETER=10
THREAD="1 4"

echo "# $(hostname)"
echo
echo "## info"
echo
echo "- cpuinfo"
echo
echo '```'
echo "# cat /proc/cpuinfo"
cat /proc/cpuinfo
echo '```'
echo
echo "- memory"
echo
echo '```'
echo "# free"
free
echo '```'
echo
echo "- disk"
echo
echo '```'
echo "# df -h"
df -h
echo '```'
echo
echo "- 0: SSD, 1: HDD"
echo
echo '```'
echo "# cat /sys/block/sda/queue/rotational"
cat /sys/block/sda/queue/rotational
echo '```'
echo
echo "## bench"
echo
for n in $THREAD; do
  echo "- bench cpu (thread $n)"
  echo
  echo '```'
  echo "# sysbench --test=cpu --num-threads=$n run"
  sysbench --test=cpu --num-threads=1 run
  echo '```'
  echo
done
for n in $THREAD; do
  echo "- bench memory (thread $n)"
  echo
  echo '```'
  echo "# sysbench --test=memory --num-threads=$n run"
  sysbench --test=memory --num-threads=1 run
  echo '```'
  echo
done
sysbench --test=fileio --file-test-mode=rndwr --num-threads=1 prepare > /dev/null 2>&1
for n in $THREAD; do
  echo "- bench random Read/Write (thread $n)"
  echo
  echo '```'
  echo "# sysbench --test=fileio --file-test-mode=rndrw --num-threads=$n run"
  sysbench --test=fileio --file-test-mode=rndrw --num-threads=$n run
  echo '```'
  echo
done
echo "## bench * $AVERAGE_PARAMETER average"
echo
for n in $THREAD; do
  echo "- cpu: execution total time (thread $n)"
  COUNT=0
  for i in $(seq 1 $AVERAGE_PARAMETER); do
    COUNT=$(echo "$COUNT + $(sysbench --test=cpu --num-threads=$n run | grep "total time:" | awk '{print $3}' | sed "s/s//g")" | bc)
  done
  echo "    - $(echo "$COUNT / $AVERAGE_PARAMETER" | bc -l) sec"
  echo
done
for n in $THREAD; do
echo  "- memory: transferred mbps (thread $n)"
  COUNT=0
  for i in $(seq 1 $AVERAGE_PARAMETER); do
    COUNT=$(echo "$COUNT + $(sysbench --test=memory --num-threads=$n run | grep "transferred" | awk '{print $4}' | sed "s/(//g")" | bc)
  done
  echo "    - $(echo "$COUNT / $AVERAGE_PARAMETER" | bc -l) MB"
  echo
done
for n in $THREAD; do
  echo  "- diskI/O (random Read/Write): transferred mbps (thread $n)"
  COUNT=0
  for i in $(seq 1 $AVERAGE_PARAMETER); do
    COUNT=$(echo "$COUNT + $(sysbench --test=fileio --file-test-mode=rndrw --num-threads=$n run| grep "transferred" | awk '{print $8}' | sed "s/(\(.*\)M.*$/\1/g")" | bc)
  done
  echo "    - $(echo "$COUNT / $AVERAGE_PARAMETER" | bc -l) Mb"
  echo
done
sysbench --test=fileio cleanup > /dev/null 2>&1
