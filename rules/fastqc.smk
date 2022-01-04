rule fastqc:
    input:
        expand("{libdir}{library}_{strand}.fq.gz", libdir=config["libdir"], strand=["1", "2"], allow_missing=True)
    output:
        expand("results/{library}/{library}_{strand}_fastqc.{ext}", strand=["1", "2"], ext=["html", "zip"], allow_missing=True)
    log:
        "results/logs/fastqc_{library}.log"
    benchmark:
        "results/benchmarks/fastqc_{library}.benchmark.txt"
    threads: 4
    resources:
        mem_mb=16000
    shell:
        "module load bioinfo/FastQC_v0.11.7 ; "
        "fastqc -t {threads} -q {input} --outdir=results/{wildcards.library}/"