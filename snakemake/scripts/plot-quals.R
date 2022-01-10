library(tidyverse)
library(vcfR)

vcf <- read.vcfR(snakemake@input[[1]], verbose = F) %>% 
  vcfR2tidy()

g <- ggplot(vcf$fix, aes(QUAL)) +
  geom_histogram() +
  theme_minimal()

ggsave(filename = snakemake@output[[1]], plot = g,
       device = "png", dpi = 300, bg = "white")
