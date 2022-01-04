rule strelka2:
    input:
        expand("results/reference/{reference}.fa", reference=config["reference"]),
        "results/alns/{tumor}.md.cram",
        expand("results/alns/{base}.md.cram", base=config["base"]),
        "results/alns/{tumor}.md.cram.crai",
        expand("results/alns/{base}.md.cram.crai", base=config["base"])
    output:
        expand("results/mutations/{tumor}_vs_{base}.raw.vcf", base=config["base"], allow_missing=True)
    log:
        "results/logs/strelka2_{tumor}.log"
    benchmark:
        "results/benchmarks/strelka2_{tumor}.benchmark.txt"
    singularity: 
        "docker://quay.io/wtsicgp/strelka2-manta"
    threads: 20
    resources:
        mem_mb=200000
    shell:
        "configureStrelkaSomaticWorkflow.py "
        "--normalBam {input[2]} "
        "--tumorBam {input[1]} "
        "--referenceFasta {input[0]} "
        "--runDir tmp/strelka2_{wildcards.tumor}_vs_{config[base]} ; "
        "tmp/strelka2_{wildcards.tumor}_vs_{config[base]}/runWorkflow.py -m local -j {threads} ; "
        "zcat tmp/strelka2_{wildcards.tumor}_vs_{config[base]}/results/variants/somatic.snvs.vcf.gz > {output} ; "
        "rm -r tmp/strelka2_{wildcards.tumor}_vs_{config[base]}"
