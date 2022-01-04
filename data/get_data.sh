#!/bin/bash

git clone git@github.com:sylvainschmitt/generateMutations.git
cd generateMutations/data
sh get_data.sh
cd ..
snakemake --use-singularity --cores 4
mv results/reference/ ../
mv results/reads/ ../
mv results/mutations/ ../
cd ..
rm -rf generateMutations
