#!/usr/bin/perl -w 

use warnings;

#SRR1049823
#SRR1049824

@files = qw(
SRR1049825
);

@notyet = qw (
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
open(IF,"$f.fa");
open(OF,">10p$f.fa");
while($a=<IF>){
$b=<IF>;
$r = rand(1);
if($r<0.1){print OF $a; print OF $b;}
}
close(OF);
close(IF);
}








