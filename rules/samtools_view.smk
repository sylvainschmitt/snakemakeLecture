rule samtools_view:
    input:
        "results/alns/{library}.sam",
        expand("results/reference/{reference}.fa", reference=config["reference"])
    output:
        temp("results/alns/{library}.raw.cram")
    log:
        "results/logs/samtools_view_{library}.log"
    benchmark:
        "results/benchmarks/samtools_view_{library}.benchmark.txt"
    singularity: 
        "oras://registry.forgemia.inra.fr/gafl/singularity/samtools/samtools:latest"
    shell:
        "samtools view -C -T {input[1]} -f 1 -F 12 {input[0]} > {output}"
