#!/usr/bin/perl -w
############################################################################
#
# AlchemyAPI Perl Example: Structured Content Scraping
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


# Get the first link from an URL
$result = $alchemyObj->URLGetConstraintQuery("http://microformats.org/wiki/hcard", "1st link");
printf $result;


# Load an example HTML input file to analyze.
my $HTMLFile;
my $HTMLContent;
open($HTMLFile, "data/example.html");
sysread($HTMLFile, $HTMLContent, -s($HTMLFile));
close($HTMLFile);


# Get the first link from a HTML
$result = $alchemyObj->HTMLGetConstraintQuery($HTMLContent, "http://www.test.com/", "1st link");
printf $result;
