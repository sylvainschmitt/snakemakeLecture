rule bedtools_subtract:
    input:
        "results/mutations/B{branch}_T{tip}_L{repetition}.raw.vcf",
        expand("{refdir}/{hz}", refdir=config["refdir"], hz=config["hz"])
    output:
        temp("results/mutations/B{branch}_T{tip}_L{repetition}.nonhz.vcf")
    log:
        "results/logs/bedtools_subtract_B{branch}_T{tip}_L{repetition}.log"
    benchmark:
        "results/benchmarks/bedtools_subtract_B{branch}_T{tip}_L{repetition}.benchmark.txt"
    singularity: 
        "oras://registry.forgemia.inra.fr/gafl/singularity/bedtools/bedtools:latest"
    shell:
        "bedtools subtract -header -a {input[0]} -b {input[1]} > {output}"