rule samtools_stats:
    input:
        "results/alns/{library}.md.cram"
    output:
        "results/alns/{library}.md.cram.stats"
    log:
        "results/logs/samtools_stats_{library}.log"
    benchmark:
        "results/benchmarks/samtools_stats_{library}.benchmark.txt"
    singularity: 
        "oras://registry.forgemia.inra.fr/gafl/singularity/samtools/samtools:latest"
    shell:
        "samtools stats --threads {threads} {input} > {output} ; "
