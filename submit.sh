#!/bin/bash
for s in /home/guq/datalad/prodtest/*.csv
do 
	sbatch --time=00:02:00 --partition=compute -n 1 --wrap="bash run.sh $s"
done
