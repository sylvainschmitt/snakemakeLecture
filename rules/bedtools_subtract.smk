rule bedtools_subtract:
    input:
        expand("results/mutations/{tumor}_vs_{base}.raw.vcf", base=config["base"], allow_missing=True),
        expand("{refdir}/{hz}", refdir=config["refdir"], hz=config["hz"])
    output:
        temp(expand("results/mutations/{tumor}_vs_{base}.nonhz.vcf", base=config["base"], allow_missing=True))
    log:
        "results/logs/bedtools_subtract_{tumor}.log"
    benchmark:
        "results/benchmarks/bedtools_subtract_{tumor}.benchmark.txt"
    singularity: 
        "oras://registry.forgemia.inra.fr/gafl/singularity/bedtools/bedtools:latest"
    shell:
        "bedtools subtract -header -a {input[0]} -b {input[1]} > {output}"