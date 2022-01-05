rule samtools_sort:
    input:
        "results/alns/{library}_raw.cram"
    output:
        "results/alns/{library}.cram"
    log:
        "results/logs/samtools_sort_{library}.log"
    benchmark:
        "results/benchmarks/samtools_sort_{library}.benchmark.txt"
    singularity: 
        "oras://registry.forgemia.inra.fr/gafl/singularity/samtools/samtools:latest"
    shell:
        "samtools sort --threads {threads} -O cram {input} > {output}"
