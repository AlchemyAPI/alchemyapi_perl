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


# Categorize a web URL by topic.
$result = $alchemyObj->URLGetCategory("http://www.gigaom.com/");
printf $result;


# Categorize a some text.
$result = $alchemyObj->TextGetCategory("Latest on the War in Iraq.");
printf $result;


# Load an example HTML input file to analyze.
my $HTMLFile;
my $HTMLContent;
open($HTMLFile, "data/example.html");
sysread($HTMLFile, $HTMLContent, -s($HTMLFile));
close($HTMLFile);


# Categorize a HTML document by topic.
$result = $alchemyObj->HTMLGetCategory($HTMLContent, "http://www.test.com/");
printf $result;



