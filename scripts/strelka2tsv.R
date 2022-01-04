# input
vcf <- snakemake@input[[1]]
tsv <-  snakemake@output[[1]] 

# # manual
# vcf <- "results/mutations_unique/lower_vs_upper_on_Qrob_Chr01_strelka2.vcf"
# tsv <- "results/mutations_tsv/lower_vs_upper_on_Qrob_Chr01_strelka2.tsv"

# loibraries
library(tidyverse)
library(vcfR)

# raw data
raw <- read.vcfR(vcf, verbose = F) %>% 
  vcfR2tidy()

# preparing gt
gt <- raw$gt %>% 
  select(-gt_GT_alleles) %>% 
  reshape2::melt(c("ChromKey", "POS", "Indiv", "gt_DP", "gt_FDP", "gt_SDP", "gt_SUBDP"),
                 variable.name = "base", value.name = "count") %>% 
  mutate(base = gsub("gt_", "", base)) %>% 
  mutate(base = gsub("U", "", base)) %>% 
  left_join(select(raw$fix, ChromKey, POS, REF, ALT)) %>% 
  rowwise() %>% 
  filter(base %in% c(REF, ALT)) %>% 
  mutate(base = ifelse(base == REF, "gt_refCounts", "gt_altCounts")) %>% 
  select(-REF, -ALT) %>% 
  reshape2::dcast(ChromKey+POS+Indiv+gt_DP+gt_FDP+gt_SDP+gt_SUBDP ~ base, value.var = "count") %>% 
  separate(gt_refCounts, c("gt_refCountT1", "gt_refCountT2"), convert = T) %>% 
  separate(gt_altCounts, c("gt_altCountT1", "gt_altCountT2"), convert = T) %>% 
  mutate(gt_AF = gt_altCountT1 / (gt_altCountT1 + gt_refCountT1))

# joining mutations infor
mut <- filter(gt, Indiv == "TUMOR") %>% select(-Indiv)
names(mut) <- gsub("gt", "mutation", names(mut))
norm <- filter(gt, Indiv == "NORMAL") %>% select(-Indiv)
names(norm) <- gsub("gt", "normal", names(norm))
mutations <- raw$fix %>% 
  left_join(mut) %>% 
  left_join(norm) %>% 
  mutate(tumor = snakemake@wildcards$tumor) %>% 
  mutate(normal = snakemake@wildcards$normal) %>% 
  mutate(caller = "strelka2")
rm(mut, norm, gt)

write_tsv(mutations, tsv)
