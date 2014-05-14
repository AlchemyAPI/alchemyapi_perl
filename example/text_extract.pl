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


# Get the text for a web URL (removing ads, navigation links, etc.)
$result = $alchemyObj->URLGetText("http://www.gigaom.com/");
printf $result;


# Get the raw text for a web URL (including ads, navigation links, etc.)
$result = $alchemyObj->URLGetRawText("http://www.gigaom.com/");
printf $result;


# Get the title for a web URL.
$result = $alchemyObj->URLGetTitle("http://www.gigaom.com/");
printf $result;


# Load an example HTML input file to analyze.
my $HTMLFile;
my $HTMLContent;
open($HTMLFile, "data/example.html");
sysread($HTMLFile, $HTMLContent, -s($HTMLFile));
close($HTMLFile);


# Get the text for a HTML document (removing ads, navigation links, etc.)
$result = $alchemyObj->HTMLGetText($HTMLContent, "http://www.test.com/");
printf $result;


# Get the raw text for a HTML document (including ads, navigation links, etc.)
$result = $alchemyObj->HTMLGetRawText($HTMLContent, "http://www.test.com/");
printf $result;


# Get the title for a HTML document.
$result = $alchemyObj->HTMLGetTitle($HTMLContent, "http://www.test.com/");
printf $result;



