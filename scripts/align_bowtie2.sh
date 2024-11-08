#!/bin/bash

for file in *1.fastq.gz
do
  base_name=$(basename "$file" | sed 's/_1.fastq.gz//')
  bowtie2 --maxins 800 -t -x ../Index/L_vannamei -p 15 --fr -1 "$base_name"_1.fastq.gz -2 "$base_name"_2.fastq.gz | samtools view -Sb -@ 15 | samtools sort -@ 15 -o "$base_name.fastq.gz.sorted.bam"
done
