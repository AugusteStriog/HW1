#!/bin/bash
genome="mm9"
ref_dir="/home/bioinformatikai/HW1/refs"
input_dir="/home/bioinformatikai/HW1/inputs"
output_dir="/home/bioinformatikai/HW1/outputs"
gtf_file="${ref_dir}/${genome}.gtf.gz"
transcripts_file="${ref_dir}/${genome}_rna.fa.gz"
index_dir="${ref_dir}/${genome}_salmon_index"

#index files
if [ ! -d "${index_dir}" ]; then
    salmon index -t "${transcripts_file}" -i "${index_dir}" -p 6
fi

# Run FASTQC analysis on each of your FASTQ files
fastqc -t 6 "${input_dir}"/*.fastq.gz -o "${output_dir}/fastqc"

# Generate MULTIQC report for (1) results
multiqc "${output_dir}/fastqc" -o "${output_dir}/multiqc"

# Run standard FASTQ trimming: remove any adapters, trim low-quality bases, and remove reads that are shorter than 20 bp

for file in "${input_dir}"/*_1.fastq.gz; do
    sample=$(basename "${file}" _1.fastq.gz)
    trim_galore -j 6 --paired --length 20 -o "${output_dir}" "${input_dir}/${sample}_1.fastq.gz" "${input_dir}/${sample}_2.fastq.gz"
done

# Rerun FASTQC on newly created/cleaned FASTQ files
fastqc -t 6 "${output_dir}"/*.fq.gz -o "${output_dir}/fastqc_trimmed"

# Salmon quantification

mkdir -p "${output_dir}/quant"
for file in "${output_dir}"/*_1_val_1.fq.gz; do
    sample=$(basename "${file}" _1_val_1.fq.gz)
    salmon quant -i "${index_dir}" -l A -1 "${file}" -2 "${file/_1_val_1/_2_val_2}" -o "${output_dir}/quant/${sample}" --validateMappings
done


