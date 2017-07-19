#!/usr/bin/perl

use strict;
use warnings;

#4 juin 2012: removed the FPKM, as it is not present anymore in new version of trinity
#3 spet 2014: new trinity contig names
#13 fev 2014: new trinity format
# TR1|c0_g1_i1 len=1746 path=[3506:0-437 3507:438-461 3516:462-766 3510:767-784 3511:785-1745] [-1, 3506, 3507, 3516, 3510, 3511, -2]
#8 fev 2016: nex trinity format

my $help = <<HELP;
Usage: $0 <trinity assembly> <table output>
HELP

if($#ARGV < 1) {
    print $help;
    exit;
}

open IN, $ARGV[0];
open OUT, ">$ARGV[1]";
print OUT "comp\tsubcomp\tseq\tlength\n";


while(<IN>) {
    next unless /^>/;
    if (/>(comp|c)(\d+)_(c|g)(\d+)_(seq|i)(\d+) len=(\d+) .*/) {
		my $comp = $2;
		my $sub = $4;
		my $seq = $6;
		my $len = $7;
	# 	my $fpkm = $5;
	# 	$fpkm =~ tr/,/\./;
		print OUT "$comp\t$sub\t$seq\t$len\n";
	}
    elsif(/TRINITY_(DN\d+_c\d+)_g(\d+)_i(\d+) len=(\d+) /) {
	        my $comp = $1;
		my $sub = $2;
		my $seq = $3;
		my $len = $4;
		print OUT "$comp\t$sub\t$seq\t$len\n";
    }
    elsif(/>(TR\d+\|c\d+)_g(\d+)_i(\d+) len=(\d+) .*/) {
		my $comp = $1;
		my $sub = $2;
		my $seq = $3;
		my $len = $4;
	# 	my $fpkm = $5;
	# 	$fpkm =~ tr/,/\./;
		print OUT "$comp\t$sub\t$seq\t$len\n";
    }

    else { print "I can't parse this: $_\n" }
}

