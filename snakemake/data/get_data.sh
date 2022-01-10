#!/bin/bash

wget https://raw.githubusercontent.com/snakemake/snakemake-tutorial-data/master/data/genome.fa
wget https://raw.githubusercontent.com/snakemake/snakemake-tutorial-data/master/data/genome.fa.amb
wget https://raw.githubusercontent.com/snakemake/snakemake-tutorial-data/master/data/genome.fa.ann
wget https://raw.githubusercontent.com/snakemake/snakemake-tutorial-data/master/data/genome.fa.bwt
wget https://raw.githubusercontent.com/snakemake/snakemake-tutorial-data/master/data/genome.fa.fai
wget https://raw.githubusercontent.com/snakemake/snakemake-tutorial-data/master/data/genome.fa.pac
wget https://raw.githubusercontent.com/snakemake/snakemake-tutorial-data/master/data/genome.fa.sa
mkdir samples
cd samples
wget https://raw.githubusercontent.com/snakemake/snakemake-tutorial-data/master/data/samples/A.fastq
wget https://raw.githubusercontent.com/snakemake/snakemake-tutorial-data/master/data/samples/B.fastq
wget https://raw.githubusercontent.com/snakemake/snakemake-tutorial-data/master/data/samples/C.fastq
