rule mosdepth:
    input:
        expand("results/reference/{reference}.fa", reference=config["reference"]),
        "results/alns/{library}.md.cram",
        expand("results/reference/{reference}.{ext}", 
                reference=config["reference"], ext=["fa.amb", "fa.ann", "fa.bwt", "fa.pac", "fa.sa"]),
        "results/alns/{library}.md.cram.crai"
    output:
        "results/alns/{library}.mosdepth.global.dist.txt"
    log:
        "results/logs/mosdepth_{library}.log"
    benchmark:
        "results/benchmarks/mosdepth_{library}.benchmark.txt"
    singularity: 
        "docker://quay.io/biocontainers/mosdepth:0.2.4--he527e40_0"
    shell:
        "mosdepth -n --fast-mode -t {threads} -f {input[0]} results/alns/{wildcards.library} {input[1]}"
