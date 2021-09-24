#!/usr/bin/perl -w 

use warnings;

#mafs
#10pcircnonSRR1049823.maf
#10pcircnonSRR1049829.maf
#10pcircremprobSRR1049823.maf
###maf version=1 scoring=blastz
#a score=6995.000000
#s MYB.37.41.5_32circle   0 74 + 100 ctcatattatccaacctcatttaaatttcaaattattctcttccctttaggtaagtacgtgtgcaccagccccc
#s SRR1049823.301603    128 74 - 202 ctcatattatccaacctcatttaaatttcaaattattctcttccctttaggtaagtacgtgtgcaccagccccc

#@files = qw(
#10pcircremprobSRR1049823.maf
#10pcircremprobSRR1049824.maf
#10pcircremprobSRR1049825.maf
#10pcircremprobSRR1049826.maf
#10pcircremprobSRR1049827.maf
#10pcircremprobSRR1049828.maf
#10pcircremprobSRR1049829.maf
#10pcircremprobSRR1049830.maf
#10pcircremprobSRR1049831.maf
#10pcircremprobSRR1049832.maf
#10pcircremprobSRR1049833.maf
#);

@files = qw(
SRR1049823
SRR1049824
SRR1049825
SRR1049826
SRR1049827
SRR1049828
SRR1049829
SRR1049830
SRR1049831
SRR1049832
SRR1049833
);


$longdir = "/jul19_au24_2021_fasta_andblat/";
#system("blat ../wtf_s21/hg19circ_remprob.fa $f.fa -out=maf $out -fastMap -minScore=70 ");

foreach $f (@files){
#simplify maf
%best = ();
%rlength=();
#open(IF,"lt8$f");
$in = $longdir . "hg19circrp" . $f . ".maf";
open(IF,"$in");
while($a=<IF>){
if($a =~ /a score/){
$tline =<IF>;
$circ = substr($tline,0,22);
$cseq = substr($tline,36);
$tlen = length($cseq);
$r=<IF>;
$read = substr($r,0,22);
$raln = substr($r,22);
$rseq = substr($r,36);
$rlen = length($rseq);


if(! exists $rlength{$read}){$rlength{$read} = $rlen; $best{$read} = $a . $tline . $r;}
elsif( $tlen>$rlength{$read}){$rlength{$read} = $rlen; $best{$read} = $a . $tline . $r; }

}
}

open(OF,">tmp.maf");
print OF "#maf\n";
foreach $key (keys %best){print OF $best{$key};}
close(OF);
#exit;


#open(IF,$f);
open(IF,"tmp.maf");
%hlength=();
%best=();
%cntaln = ();
%aln =();

#$head =<IF>;
while($a=<IF>){
##maf version=1 scoring=blastz
#a score=7614.000000
#s UBC.7.15.2_32circle 18 82 + 100 gtccaccctgcacctggtgctccgtctcagaggtgggatgcaaatcttcgtgaagacactcactggcaagaccatcaccctt
#s SRR1049831.2124      0 82 + 202 gtccaccttgcacctggtactccgtctcagaggtgggatgcaaatcttcgtgaagacactcactggcaagaccatcaccctt
if($a =~ /a score/){
$tline =<IF>;
$circ = substr($tline,0,22);
#$caln = substr($tline,22);
$cseq = substr($tline,36);
$tlen = length($cseq);
if($tlen>70){

if(! exists $hlength{$circ}){$hlength{$circ} = $tlen; $best{$circ} = $tline;}
elsif( $tlen>$hlength{$circ}){$hlength{$circ} = $tlen; $best{$circ} = $tline;}

$a=<IF>;

$read = substr($a,0,22);
#print "$read\n";exit;
$raln = substr($a,22);
$rseq = substr($a,36);
$rlen = length($cseq);

$cntaln{$circ}++;
$aln{$circ} .= $a;

#print $read;
#print $aln;
#print "seq:$seq\n";
#print "$aln\n";exit;

}


}
}

open(OF,">$in.cnt");
foreach $circ (sort {$cntaln{$b} <=> $cntaln{$a} } keys %cntaln) {
print OF "$circ\t$cntaln{$circ}\n$best{$circ}$aln{$circ}\n";
}

#exit;
}





