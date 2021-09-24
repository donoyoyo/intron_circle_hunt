#!/usr/bin/perl -w 


#wc = with coords
#wn = with "normal" event (cis)
#onlyn = if sequence has a "normal" only use that one



use DBI; 

$db_user = ""; 
$db_passwd = ""; 
$database = "DBI:mysql:"; 
$mdb = DBI->connect($database, $db_user, $db_passwd) || die ("couldn't connect to database"); 


#$q1uery = "select chrom,start,end,strand,annName,start_pos,end_pos from clean_span where type=2  and chrom not like 'chrM' and annName like 'RPS10%' ;";
$q1uery = "select chrom,start,end,strand,annName,start_pos,end_pos,alt_region from clean_span where type=2  and chrom not like 'chrM' ;";
$h1andle = $mdb->prepare($q1uery); 
$h1andle->execute; 
while( ($chrom,$start,$end,$strand,$ann,$sp,$ep,$ar) = $h1andle->fetchrow) {
$name = "$ann.$sp.$ep.$ar";


$l1 = $start-50 ; $l2 = $start+50;
$r1 = $end-50; $r2 = $end+50;
@seq = ();
system("twoBitToFa /gbdb/hg19/hg19.2bit:$chrom:$l1-$start tmp1.fa");
system("twoBitToFa /gbdb/hg19/hg19.2bit:$chrom:$start-$l2 tmp2.fa");
system("twoBitToFa /gbdb/hg19/hg19.2bit:$chrom:$r1-$end tmp3.fa");
system("twoBitToFa /gbdb/hg19/hg19.2bit:$chrom:$end-$r2 tmp4.fa");
open(FA1 , "tmp1.fa");$fl=<FA1>;$seq[1] = "";while($fl=<FA1>){	chomp($fl);$seq[1] .= "$fl" ;} close(FA1);
open(FA1 , "tmp2.fa");$fl=<FA1>;$seq[2] = "";while($fl=<FA1>){	chomp($fl);$seq[2] .= "$fl" ;} close(FA1);
open(FA1 , "tmp3.fa");$fl=<FA1>;$seq[3] = "";while($fl=<FA1>){	chomp($fl);$seq[3] .= "$fl" ;} close(FA1);
open(FA1 , "tmp4.fa");$fl=<FA1>;$seq[4] = "";while($fl=<FA1>){	chomp($fl);$seq[4] .= "$fl" ;} close(FA1);

$pos[1] = "$chrom:$l1-$start";
$pos[2] = "$chrom:$start-$l2";
$pos[3] = "$chrom:$r1-$end";
$pos[4] = "$chrom:$end-$r2";

if($strand eq '-'){

$seq[1] =~ tr/a-z/A-Z/;$tmp=reverse($seq[1]);$tmp=~ tr/ACTG/TGAC/;$seq[1]=$tmp;
$seq[2] =~ tr/a-z/A-Z/;$tmp=reverse($seq[2]);$tmp=~ tr/ACTG/TGAC/;$seq[2]=$tmp;
$seq[3] =~ tr/a-z/A-Z/;$tmp=reverse($seq[3]);$tmp=~ tr/ACTG/TGAC/;$seq[3]=$tmp;
$seq[4] =~ tr/a-z/A-Z/;$tmp=reverse($seq[4]);$tmp=~ tr/ACTG/TGAC/;$seq[4]=$tmp;

$tmp=$seq[1]; $seq[1] = $seq[4];$seq[4]=$tmp;
$tmp=$seq[2]; $seq[2] = $seq[3]; $seq[3]=$tmp;
#print "1$seq1\n2$seq2\n3$seq3\n4$seq4\n";exit;

#1 2 3 4
#4 3 2 1
$tmp = $pos[1] ; $pos[1] = $pos[4] ; $pos[4] = $tmp;
$tmp = $pos[2] ; $pos[2] = $pos[3] ; $pos[3] = $tmp;

}

for($i=1;$i<=4;$i++){
for($j=1;$j<=4;$j++){
if($i != $j){
$info = "non";
if(   $i == 1 && $j == 4){$info="norm";}
elsif($i == 1 && $j == 2){$info = "unspliced";}
elsif($i == 3 && $j == 4){$info = "unspliced";}
elsif($i == 3 && $j == 2){$info = "circle";}
print ">$name\_$i$j$info\t$pos[$i]\t$pos[$j]\n";
print "$seq[$i]$seq[$j]\n";

}
}
}
}




