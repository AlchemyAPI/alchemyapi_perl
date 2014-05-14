#!/usr/bin/perl -w
############################################################################
#
# AlchemyAPI Perl Example: Keyword Extraction
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


# Get a list of topic keywords for a text string.
$result = $alchemyObj->TextGetRankedKeywords("Microsoft released a new product today.  Microsoft wants you to try it out.  Download it here.");
printf $result;


# Get a list of topic keywords for a web URL.
$result = $alchemyObj->URLGetRankedKeywords("http://www.gigaom.com/");
printf $result;


# Load an example HTML input file to analyze.
my $HTMLFile;
my $HTMLContent;
open($HTMLFile, "data/example.html");
sysread($HTMLFile, $HTMLContent, -s($HTMLFile));
close($HTMLFile);


# Get a list of topic keywords for a HTML document.
$result = $alchemyObj->HTMLGetRankedKeywords($HTMLContent, "http://www.test.com/");
printf $result;



