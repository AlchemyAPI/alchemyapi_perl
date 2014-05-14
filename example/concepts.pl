#!/usr/bin/perl -w
############################################################################
#
# AlchemyAPI Perl Example: Concept Tagging
# Author: Orchestr8, LLC
# Copyright (C) 2009-2010, Orchestr8, LLC.
#
############################################################################
 
use strict;
use AlchemyAPI;

# Create the AlchemyAPI object.
my $alchemyObj = new AlchemyAPI();

# Load the API key from disk.
if ($alchemyObj->LoadKey("api_key.txt") eq "error")
{
	die "Error loading API key.  Edit api_key.txt and insert your API key.";
}


my $result = '';


# Get a list of concept tags for a text string.
$result = $alchemyObj->TextGetRankedConcepts("This thing has a steering wheel, tires, and an engine.  Do you know what it is?");
printf $result;


# Get a list of concept tags for a web URL.
$result = $alchemyObj->URLGetRankedConcepts("http://www.gigaom.com/");
printf $result;


# Load an example HTML input file to analyze.
my $HTMLFile;
my $HTMLContent;
open($HTMLFile, "data/example.html");
sysread($HTMLFile, $HTMLContent, -s($HTMLFile));
close($HTMLFile);


# Get a list of concept tags for a HTML document.
$result = $alchemyObj->HTMLGetRankedConcepts($HTMLContent, "http://www.test.com/");
printf $result;



