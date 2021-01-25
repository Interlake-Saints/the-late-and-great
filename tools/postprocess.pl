#!/usr/bin/env perl

use strict;
use warnings;

open(my $inputFile, '<', $ARGV[0]) or die("Could not read file ($!)");
my @lines = <$inputFile>;
my $isFrontMatter = 0;
my $record = '';
my $name = '';
my $date = '';
foreach my $line (@lines) {
	if ($line =~ /\-\-\-/) {
		if ($isFrontMatter) {
			$isFrontMatter = 0;
		} elsif ($record) {
			$isFrontMatter = 1;
			my $filename = "$date$name.markdown";
			open(FH, '>', $filename) or die $!;
			print FH $record;
			close(FH);
			$record = '';
			$name = '';
			$date = '';
		} else {
			$isFrontMatter = 1;
		}
	} elsif ($isFrontMatter) {
		if ($line =~ m/title\: (.*)/) {
			$name = $1;
			$name = lc($name);
			$name =~ s/\".*\"//g;
			$name =~ s/\W/\-/g;
			$name =~ s/\-\-/\-/g;
			$name =~ s/[^a-z0-9\-\.]//g;
		} elsif ($line =~ m/date\: (.*)/) {
			$date = $1;
		}
	}
	$record .= "$line";
}
