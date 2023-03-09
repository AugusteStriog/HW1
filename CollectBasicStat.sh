#!/bin/bash
NUM=$(grep -c '>' "/home/bioinformatikai/HW1/refs/mm9.fa.gz")
echo "Number of sequences in the reference genome: ${NUM}"

# Calculate the number of reads in each sample
cd /home/bioinformatikai/HW1/inputs/
for FASTQ in /home/bioinformatikai/HW1/inputs/*.fastq.gz; do
    NUM_READS=$(zcat "${FASTQ}" | awk '{s++}END{print s/4}')
    echo "Number of reads in $(basename ${FASTQ}): ${NUM_READS}"
done 

# Calculate the number of protein-coding genes in the genome
cd /home/bioinformatikai/HW1/refs/
gunzip -c mm9.gtf.gz | grep -w "gene" | grep -w "protein_coding" | wc -l