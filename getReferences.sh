#!/bin/bash


# download the reference genome 
wget ftp://ftp.ensembl.org/pub/release-67/fasta/mus_musculus/dna/Mus_musculus.NCBIM37.67.dna_sm.toplevel.fna.gz -O /home/bioinformatikai/HW1/refs/mm10.fa.gz

# download the reference transcriptome
wget ftp://ftp.ensembl.org/pub/release-67/fasta/mus_musculus/cdna/Mus_musculus.NCBIM37.67.cdna.all.fna.gz -O /home/bioinformatikai/HW1/refs/mm10_rna.fa.gz

# download the GTF/GFF3 file 
wget ftp://ftp.ensembl.org/pub/release-67/gtf/mus_musculus/Mus_musculus.NCBIM37.67.gtf.gz -O /home/bioinformatikai/HW1/refs/mm10.gtf.gz

prefetch -O /home/bioinformatikai/HW1/inputs SRR8985047 SRR8985048 SRR8985049 SRR8985050

fastq-dump --outdir /home/bioinformatikai/HW1/inputs/ --gzip /home/bioinformatikai/HW1/inputs/SRR8985047 /home/bioinformatikai/HW1/inputs/SRR8985048 /home/bioinformatikai/HW1/inputs/SRR8985049 /home/bioinformatikai/HW1/inputs/SRR8985050
