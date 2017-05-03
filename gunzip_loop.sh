#!/usr/bin/env bash

#SBATCH -J gunzip
#SBATCH -e gunzip-%j.err.output
#SBATCH -o gunzip-%j.output
#SBATCH -p animal_sciences
#SBATCH --mem-per-cpu=10G/CPU
#SBATCH -t 07-18:00

for f in ../../RP1_demultiplexed/*001.fastq.gz
#put the path to your files above 
do
    fname=$(basename $f _R1_001.fastq.gz) 
    #I had multiple samples that ended in _R1_001.fastq.gz
    echo $fname
    echo '#!/bin/bash' >> $fname.sh
    echo "##" >> $fname.sh
    echo "#SBATCH -n 2 " >> $fname.sh
	  echo "#SBATCH -p animal_sciences" >> $fname.sh
    echo "#SBATCH --mem-per-cpu=10G/CPU" >> $fname.sh
	  echo "#SBATCH -t 07-18:00 " >> $fname.sh
    #you can change this depending on how many PCs you want to use
    echo "#SBATCH -o path/Sbatch/gunzip/${fname}.gunzip.out" >> $fname.sh
    echo "#SBATCH -e path/Sbatch/gunzip/${fname}.gunzip.err" >> $fname.sh
    #these create and output and error file for each sample
    echo "gunzip -c path/RP1_demultiplexed/${fname}_R1_001.fastq.gz > path/Unziped_files/RP10_demultiplexed/${fname}_R1_001.fastq" >> $fname.sh
	  sbatch $fname.sh
	  #above line will submit all the scripts it creates
	
done
