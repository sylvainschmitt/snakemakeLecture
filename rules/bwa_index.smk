rule bwa_index:
    input:
        expand("results/reference/{reference}.fa", reference=config["reference"])
    output:
        expand("results/reference/{reference}.fa{ext}", 
                reference=config["reference"], ext=[".amb", ".ann", ".bwt", ".pac", ".sa"])
    log:
        "results/logs/bwa_index.log"
    benchmark:
        "results/benchmarks/bwa_index.benchmark.txt"
    singularity: 
        "oras://registry.forgemia.inra.fr/gafl/singularity/bwa/bwa:latest"
    shell:
        "bwa index {input}"
