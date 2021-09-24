
A target fasta database was constructed using all introns in the genome.
Introns were derived from UCSC known genes and refSeq both obtained from UCSC.
50 bases on the 3' side of the intron are joined with 50 bases on the 5' side , representing an intron circle.
This target database was blatted back to the genome. Circles were removed if they blatted more than 3 times.
Sequencing data was converted to fasta and blatted to the refined target database.
The resulting alignments were further filtered leaving only the longest target alignment and longest read alignment.
Hits to the same target are grouped together in the output file

======================================

All files will need to be edited to match your genome and gene model.

circgenome.pl will create circles, exon-exon regions as well as unspliced exon-intron regions and negative control nonsense sequences

wtfgenome_wc_wn_onlyn.pl creates the above as well as transsplcing events

If there are too many not real hits because of sequence repeats, the targets are blatted back to the genome.

removeproblems.pl will remove tagets that have too many hits. This limit should be adjusted depending on your situation.

10percentblat.pl  10percentblat_rempro.pl  blat_rempro.pl  fastaandblat.pl  justblat.pl

These are all scripts that blat the read files to the target file.

10percent of the reads were used in several cases while developing the scripts.

cntwalign.pl is a script to parse , collect and count the maf files using only the longest hit for a read and the longest hit
for a target.

