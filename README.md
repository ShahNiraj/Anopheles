Please refer the paper: https://www.nature.com/articles/nature24995 for the data 

Population data
The genomic SNPs were downloaded from the https://www.malariagen.net/data
## Data download (likewise for all chromosomes): 
wget ftp://ngs.sanger.ac.uk/production/ag1000g/phase2/AR1/variation/main/vcf/all/ag1000g.phase2.ar1.2L.vcf.gz
wget ftp://ngs.sanger.ac.uk/production/ag1000g/phase2/AR1/variation/main/vcf/pass/ag1000g.phase2.ar1.pass.2L.vcf.gz
wget ftp://ngs.sanger.ac.uk/production/ag1000g/phase2/AR1/variation/main/vcf/all/ag1000g.phase2.ar1.2R.vcf.gz
wget ftp://ngs.sanger.ac.uk/production/ag1000g/phase2/AR1/variation/main/vcf/pass/ag1000g.phase2.ar1.pass.2R.vcf.gz
wget ftp://ngs.sanger.ac.uk/production/ag1000g/phase2/AR1/variation/main/vcf/all/ag1000g.phase2.ar1.3L.vcf.gz
wget ftp://ngs.sanger.ac.uk/production/ag1000g/phase2/AR1/variation/main/vcf/pass/ag1000g.phase2.ar1.pass.3L.vcf.gz
wget ftp://ngs.sanger.ac.uk/production/ag1000g/phase2/AR1/variation/main/vcf/all/ag1000g.phase2.ar1.3R.vcf.gz
wget ftp://ngs.sanger.ac.uk/production/ag1000g/phase2/AR1/variation/main/vcf/pass/ag1000g.phase2.ar1.pass.3R.vcf.gz
wget ftp://ngs.sanger.ac.uk/production/ag1000g/phase2/AR1/variation/main/vcf/all/ag1000g.phase2.ar1.X.vcf.gz
wget ftp://ngs.sanger.ac.uk/production/ag1000g/phase2/AR1/variation/main/vcf/pass/ag1000g.phase2.ar1.pass.X.vcf.gz

The list of sample names were obtained from 
ftp://ngs.sanger.ac.uk/production/ag1000g/phase2/AR1/samples/samples.meta.txt

In this list the number of :
coluzzi (mopti) samples = 283
gambiae (Kisumu) samples = 655

# the reference genome: 
/home/svans1/Anopheles/01032018_data/agamP4/ Anopheles-gambiae-PEST_CHROMOSOMES_AgamP4.fa

# the gtf file.
/home/svans1/Anopheles/01032018_data/ Anopheles_gambiae.AgamP4.38.sorted.gtf

# the chromosomes used.
/home/svans1/Anopheles/01032018_data
ag1000g.phase2.ar1.pass.2L.vcf
ag1000g.phase2.ar1.pass.2R.vcf
ag1000g.phase2.ar1.pass.3L.vcf
ag1000g.phase2.ar1.pass.3R.vcf
ag1000g.phase2.ar1.pass.UNKN.vcf 
ag1000g.phase2.ar1.pass.X.vcf

Based on the structure analysis of the population (figure 2 and extended figure 3A in the paper), only the pure samples (no admixture) were used for the analysis. 78 samples of mopti, collected from Angola and 112 samples of kisumu collected from Uganda, were used for the analysis.  

The vcf file downloaded from the website has SNP information for all the  accessions.  To extract the snps information of only selected acctions, vcftools was used.
command used : nohup vcftools --vcf ../ag1000g.phase2.ar1.pass.2L.vcf --keep sample.angola_mopti-uganda_kisumu.txt --recode --out ag1000g.phase2.ar1.pass.2L.angolaMop-ugKis.vcf &

So the resulting file now had SNPs between two subpopulation, kisumu and mopti.

The next was to find how much variation is there between these to populations. Such difference can be measure usign Fst analysis.  VCFtools was used to do Fst scan.
Command used: nohup vcftools --vcf ag1000g.phase2.ar1.pass.2L.vcf --weir-fst-pop samples.meta.gambiae.txt --weir-fst.pop samples.meta.coluzzi.txt --out 2L_col-gam-comp &

The resulting file has fst value for each snp.  This value is between 0 and 1.  0 meaning no variation between two population at that SNP position and 1 meaning completely different between two population at that SNP position.

Now only the SNPs with high Fst values were chosen for further analysis. (Fst 0.8 -1)
Perl script was used to extract those snps.

Now the genic location of the SNPs was determined. So for each gene and its 2kb flanking region, the snps located in this region was found and it was classified as coding and non-coding SNPs.
Perl script was written to do this analysis.

We have the differentially expressed genes data of Kisumu and mopti.  Now we want to find the correlation between the gene expression and SNPs between kisumu and mopti. 
