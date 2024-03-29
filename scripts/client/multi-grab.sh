#!/bin/bash
NUM=8

usage(){
	echo "usage: ./multi-grab.sh hack|kern"
}

if [ $# -lt 1 ]; then
	usage
	exit 1
fi

if [ $1 = hack ] || [ $1 = kern ]; then
	if [ -f "${1}bench.txt" ]; then
		now=`date +"%Y-%m-%d-%H-%M-%S"`
		old="${1}bench.txt-${now}"
		echo "backup old ${1}bench.txt to ${old}"
		mv ${1}bench.txt $old
	fi

	BENCHMARK=$1
	echo $NUM
	for i in `seq 1 $NUM`;
	do
		if [ "$i" -ge "10" ]; then
	                IP=10.10.1.1$i
	        else
	                IP=10.10.1.10$i
	        fi
	
		./grab-$BENCHMARK.sh $IP
	done
	for job in `jobs -p`
	do
		wait $job
	done
else
	usage
fi

