#!/usr/bin/perl -w 

use warnings;

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




foreach $f (@files){
system("blat ../wtf_s21/hg19circ_remprob.fa 10p$f.fa -out=maf 10pcircremprob$f.maf -fastMap -minScore=70 ");
}





