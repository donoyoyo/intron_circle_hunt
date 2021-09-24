#!/usr/bin/perl -w 

use warnings;

#SRR1049823
#SRR1049824
#SRR1049825
#SRR1049826
#SRR1049827

@files = qw(
SRR1049828
SRR1049829
SRR1049830
SRR1049831
SRR1049832
SRR1049833
);




foreach $f (@files){

open(IF,"../$f.fastq");
open(OF10,">10p$f.fa");
open(FULL,">$f.fa");


while($a=<IF>){
$b=<IF>;
$c=<IF>;
$d=<IF>;
$a =~ s/\@//;
print FULL ">$a"; print FULL "$b";
$r = rand(1);
if($r<0.1){print OF10 ">$a"; print OF10 "$b";}
}

close(OF10);
close(IF);
close(FULL);


}








