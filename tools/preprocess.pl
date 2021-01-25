#!/usr/bin/env perl

use strict;
use warnings;

#loop through each line of input
my $isNewRecord = 1;
open(my $inputFile, '<', $ARGV[0]) or die("Could not read file ($!)");
my @lines = <$inputFile>;
foreach my $line (@lines) {

	# if the line is a starting line
	if ($line =~ m/\* (.*) \- class of (\d*)/) {
		my $name = '';
		if ($isNewRecord) {
			$isNewRecord = 0;
		} else {
			$isNewRecord = 1;
		}

		#pull the name, class, and cause of death from the header
		$name = $1;
		my $class = "class-of-$2";
		my $causeOfDeath = '';
		if ($line =~ m/\(.*\)/) {
			$causeOfDeath = $1;
		}

		#write the front matter
		print "---\n";
		print "layout: post\n";
		print "title:  $name\n";
		print "date: \n";
		print "categories: $class\n";
		print "tags: $causeOfDeath\n";
		print "---\n";
	} else {
		#write what follows the front matter
		print $line;
	}
}
1;
