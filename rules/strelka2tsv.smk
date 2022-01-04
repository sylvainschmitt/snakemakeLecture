rule strelka2tsv:
    input:
        expand("results/mutations/{tumor}_vs_{base}.nonhz.vcf", base=config["base"], allow_missing=True)
    output:
        expand("results/mutations/{tumor}_vs_{base}.tsv", base=config["base"], allow_missing=True)
    log:
        "results/logs/strelka2tsv_{tumor}.log"
    benchmark:
        "results/benchmarks/strelka2tsv_{tumor}.benchmark.txt"
    singularity: 
        "https://github.com/sylvainschmitt/singularity-r-bioinfo/releases/download/0.0.3/sylvainschmitt-singularity-r-bioinfo.latest.sif"
    script:
        "../scripts/strelka2tsv.R"
