## Script to filter SNPs on the basis of Fst Values
## Cmd : perl FstFilter.pl <input file> > <output file>
 
open myfile,$ARGV[0];## fst file
open gtf,$ARGV[1]; ## gtf file
@gtf_file = <gtf>;
while (<myfile>) {
    chomp $_;
    @sline = split("\t",$_);
    if ($_ =~ /^CHROM/) {
        print "$_\n";
    }
    else {
        if($sline[2] >= 0.95) {
            #print "$_\n";
            for ($i=0;$i<=$#gtf_file;$i++) {
                chomp $gtf_file[$i];
                if ($gtf_file[$i] !~ /^#/) {
                    @s_gtf = split("\t",$gtf_file[$i]);
                    if ($sline[0] eq $s_gtf[0] && $s_gtf[2] eq 'gene' && ($sline[1]>=$s_gtf[3]-20000 && $sline[1] <= $s_gtf[4]+20000)) {
                        print "$_\t$gtf_file[$i]\n";
                    }
                }
            }
        }
    }
} 
