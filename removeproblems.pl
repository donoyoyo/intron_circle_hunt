#!/usr/bin/perl -w 

open(IF,"hg19onlycirc_backtohg19.bed");
while($a=<IF>){
@b = split(/\t/,$a);
$name = $b[3];
$bhash{$name}++;
}
close(IF);

open(IF,"hg19onlycirc.fa");
while($a=<IF>){
if($a =~ /^>/){
@b = split(/\t/,$a);
$head = $a;
$name = $b[0];
$name =~ s/>//;
}
else{
$bhash{$name}++;
if($bhash{$name}<12){ print $head; print $a;}
}
}
close(IF);



