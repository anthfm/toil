#!/bin/bash

working_dir=`pwd`
sample=$1


export DSLOCKFILE="$working_dir"/.SLURM_datalad_lock

tmpDir="$working_dir"/tmp/${SLURM_JOB_ID}
mkdir -p "$tmpDir"
cd "$tmpDir"


flock --verbose $DSLOCKFILE datalad clone /home/guq/datalad/prodtest ds
cd ds

git annex dead here
#git submodule foreach --recursive git annex dead here
git checkout -b "job-$SLURM_JOB_ID"
datalad get .

#run job

datalad run -m "run script on sample" "python3 remove_column.py -i ${sample} -l demo_$(basename ${sample} .csv).log -o $(basename ${sample} .csv)_processed.csv"


flock --verbose $DSLOCKFILE datalad push --to=origin
