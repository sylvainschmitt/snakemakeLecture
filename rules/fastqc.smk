rule fastqc:
    input:
        expand("{libdir}{library}_{strand}.fq.gz", libdir=config["libdir"], strand=["1", "2"], allow_missing=True)
    output:
        expand("results/{library}/{library}_{strand}_fastqc.{ext}", strand=["1", "2"], ext=["html", "zip"], allow_missing=True)
    log:
        "results/logs/fastqc_{library}.log"
    benchmark:
        "results/benchmarks/fastqc_{library}.benchmark.txt"
    singularity: 
        "docker://biocontainers/fastqc:v0.11.9_cv8"
    threads: 4
    resources:
        mem_mb=16000
    shell:
        "fastqc -t {threads} -q {input} --outdir=results/{wildcards.library}/"