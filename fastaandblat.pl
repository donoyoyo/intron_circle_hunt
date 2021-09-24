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
if($f =~ /823/ || $f =~ /824/ || $f =~ /825/){
#already done skip
}
else{
system("fastqToFa ../$f.fastq $f.fa");
}
}



foreach $f (@files){

if($f =~ /823/ || $f =~ /824/ ){
#already done skip
}
else{
system("blat ../wtf_s21/hg19circnon.fa $f.fa -out=maf $f.maf -fastMap -minScore=70 ");
}
}







