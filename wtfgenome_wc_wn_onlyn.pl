#!/usr/bin/perl -w 


#wc = with coords
#wn = with "normal" event (cis)
#onlyn = if sequence has a "normal" only use that one



use DBI; 

$db_user = ""; 
$db_passwd = ""; 
$database = "DBI:mysql:hg19"; 
$mdb = DBI->connect($database, $db_user, $db_passwd) || die ("couldn't connect to database"); 


#$q1uery = "select chrom,start,end,strand,annName,start_pos,end_pos from clean_span where type=2  and chrom not like 'chrM' and annName like 'RPS10%' ;";
$q1uery = "select chrom,start,end,strand,annName,start_pos,end_pos,alt_region from clean_span where type=2  and chrom not like 'chrM' ;";
$h1andle = $mdb->prepare($q1uery); 
$h1andle->execute; 
while( ($chrom,$start,$end,$strand,$ann,$sp,$ep,$ar) = $h1andle->fetchrow) {
$name = "$ann.$sp.$ep.$ar";


$l1 = $start-50 ; $l2 = $start+50;
$r1 = $end-50; $r2 = $end+50;

system("twoBitToFa /gbdb/hg19/hg19.2bit:$chrom:$l1-$start tmp1.fa");
system("twoBitToFa /gbdb/hg19/hg19.2bit:$chrom:$start-$l2 tmp2.fa");
system("twoBitToFa /gbdb/hg19/hg19.2bit:$chrom:$r1-$end tmp3.fa");
system("twoBitToFa /gbdb/hg19/hg19.2bit:$chrom:$end-$r2 tmp4.fa");
open(FA1 , "tmp1.fa");$fl=<FA1>;$seq1 = "";while($fl=<FA1>){	chomp($fl);	$seq1 .= "$fl" ;} close(FA1);
open(FA1 , "tmp2.fa");$fl=<FA1>;$seq2 = "";while($fl=<FA1>){	chomp($fl);	$seq2 .= "$fl" ;} close(FA1);
open(FA1 , "tmp3.fa");$fl=<FA1>;$seq3 = "";while($fl=<FA1>){	chomp($fl);	$seq3 .= "$fl" ;} close(FA1);
open(FA1 , "tmp4.fa");$fl=<FA1>;$seq4 = "";while($fl=<FA1>){	chomp($fl);	$seq4 .= "$fl" ;} close(FA1);

$pos1{$name} = "$chrom:$l1-$start";
$pos2{$name} = "$chrom:$start-$l2";
$pos3{$name} = "$chrom:$r1-$end";
$pos4{$name} = "$chrom:$end-$r2";

if($strand eq '-'){

$seq1 =~ tr/a-z/A-Z/;$tmp=reverse($seq1);$tmp=~ tr/ACTG/TGAC/;$seq1=$tmp;
$seq2 =~ tr/a-z/A-Z/;$tmp=reverse($seq2);$tmp=~ tr/ACTG/TGAC/;$seq2=$tmp;
$seq3 =~ tr/a-z/A-Z/;$tmp=reverse($seq3);$tmp=~ tr/ACTG/TGAC/;$seq3=$tmp;
$seq4 =~ tr/a-z/A-Z/;$tmp=reverse($seq4);$tmp=~ tr/ACTG/TGAC/;$seq4=$tmp;

$tmp=$seq1; $seq1 = $seq4;$seq4=$tmp;
$tmp=$seq2; $seq2 = $seq3; $seq3=$tmp;
#print "1$seq1\n2$seq2\n3$seq3\n4$seq4\n";exit;
}

$hash1{$name} = $seq1;
$hash2{$name} = $seq2;
$hash3{$name} = $seq3;
$hash4{$name} = $seq4;

#print ">$event $dval\n";
#print "$seqa\n";

}

foreach $key1 (keys %hash1){


foreach $key2 (keys %hash1){

@c = split(/\./,$key1);
@d = split(/\./,$key2);
$base1 = $c[0] ; chop($base1);
$base2 = $d[0] ; chop($base2);

if($key1 eq $key2) {
$info = "norm";
}
elsif($c[0] ne $d[0]){
$info = "tran";
}
elsif($c[0] eq $d[0]){
$info = "unann";
}
else{
print "$key1 $key2 wtf \n";
exit;
}

#print "$info $base1 $base2\n";

if(($base1 ne $base2) or (($base1 eq $base2) and ($info =~ /norm/))){

print ">$key1\_$key2\_14$info\t$pos1{$key1}\t$pos4{$key2}\n";
print "$hash1{$key1}\n$hash4{$key2}\n";

print ">$key1\_$key2\_32circ$info\t$pos3{$key1}\t$pos2{$key2}\n";
print "$hash3{$key1}\n$hash2{$key2}\n";

print ">$key1\_$key2\_31wierd$info\t$pos3{$key1}\t$pos1{$key2}\n";
print "$hash3{$key1}\n$hash1{$key2}\n";

}



}
}








