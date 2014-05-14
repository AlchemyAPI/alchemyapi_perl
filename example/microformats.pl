#!/usr/bin/perl -w
############################################################################
#
# AlchemyAPI Perl Example: Text Categorization
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


# Extract Microformats data from a web URL.
$result = $alchemyObj->URLGetMicroformats("http://microformats.org/wiki/hcard");
printf $result;


# Load an example HTML input file to analyze.
my $HTMLFile;
my $HTMLContent;
open($HTMLFile, "data/microformats.html");
sysread($HTMLFile, $HTMLContent, -s($HTMLFile));
close($HTMLFile);


# Extract Microformats data from a HTML document.
$result = $alchemyObj->HTMLGetMicroformats($HTMLContent, "http://www.test.com/");
printf $result;



