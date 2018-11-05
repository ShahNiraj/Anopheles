## Anopheles
## Anopheles Work  (Anopheles gambiae sensu stricto = kisumu       Anopheles coluzzi  = mopti)

## Anopheles complex = An. arabiensis, An. quadriannulatus, An. melas, An.merus, An. gambiae / An. coluzzi

## Anopheles gambiae genome:  
chr            size    
2L             49,364,325
2R             61,545,105
3L             41,963,435
3R             53,200,684
UNKN           42,389,979    
X              24,393,108
Y_unplaced        237,045
Total         273,093,681

## Started with the paper : https://www.nature.com/articles/nature24995

## Used figures from this paper: Figure 2 and Extended Figure 3A, to determine which populations to use for finding candidate genes.
## Idea was to use pure populations (not admixed populations) for the analysis to have a better chance of finding candidate genes.

## Downloaded Genomics SNPs.
## Data download (likewise for all chromosomes): 
wget ftp://ngs.sanger.ac.uk/production/ag1000g/phase2/AR1/variation/main/vcf/all/ag1000g.phase2.ar1.2L.vcf.gz
wget ftp://ngs.sanger.ac.uk/production/ag1000g/phase2/AR1/variation/main/vcf/pass/ag1000g.phase2.ar1.pass.2L.vcf.gz


## Decompress the files
cmd : [svans1@svlapada02 01032018_data]$ time gunzip -d ag1000g.phase2.ar1.pass.3L.vcf.gz

## File containing the kisumu and mopti sample names : samples.meta.coluzzi.txt (mopti):  283     
                                                       samples.meta.gambiae.txt (kisumu): 655
## These number are based on the information in the file 
ftp://ngs.sanger.ac.uk/production/ag1000g/phase2/AR1/samples/samples.meta.txt
## 283+655 = 938   What about 1142 - 938 = 204 accessions ?  .  unknown which species they belong.

# the reference genome: 
/home/svans1/Anopheles/01032018_data/agamP4/ Anopheles-gambiae-PEST_CHROMOSOMES_AgamP4.fa

# the gtf file.
/home/svans1/Anopheles/01032018_data/ Anopheles_gambiae.AgamP4.38.sorted.gtf

## the chromosomes used.
/home/svans1/Anopheles/01032018_data
ag1000g.phase2.ar1.pass.2L.vcf
ag1000g.phase2.ar1.pass.2R.vcf
ag1000g.phase2.ar1.pass.3L.vcf
ag1000g.phase2.ar1.pass.3R.vcf
ag1000g.phase2.ar1.pass.UNKN.vcf 
ag1000g.phase2.ar1.pass.X.vcf

## Generate vcf file with selected accessions of kisumu and mopti (population used: Angola- mopti  and Uganda-kisumu)
nohup vcftools --vcf ../ag1000g.phase2.ar1.pass.2L.vcf --keep sample.angola_mopti-uganda_kisumu.txt --recode --out ag1000g.phase2.ar1.pass.2L.angolaMop-ugKis.vcf &

## command to calculate fst using vcftools
nohup vcftools --vcf ag1000g.phase2.ar1.pass.2L.vcf --weir-fst-pop samples.meta.gambiae.txt --weir-fst.pop samples.meta.coluzzi.txt --out 2L_col-gam-comp &
