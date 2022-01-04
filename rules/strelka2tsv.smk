rule strelka2tsv:
    input:
        "results/mutations/B{branch}_T{tip}.tip.vcf"
    output:
        "results/mutations/B{branch}_T{tip}.tip.tsv"
    log:
        "results/logs/strelka2tsv_B{branch}_T{tip}.log"
    benchmark:
        "results/benchmarks/strelka2tsv_B{branch}_T{tip}.benchmark.txt"
    script:
        "../scripts/strelka2tsv.R"
