#!/usr/bin/perl -w
############################################################################
#
# AlchemyAPI Perl Example: Language Detection
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


# Detect the language for a text string (requires at least 100 bytes of text).
$result = $alchemyObj->TextGetLanguage("Microsoft released a new product today.  Microsoft wants you to try it out.  Download it here.");
printf $result;


# Detect the language used within a web URL.
$result = $alchemyObj->URLGetLanguage("http://news.google.fr");
printf $result;


# Load an example HTML input file to analyze.
my $HTMLFile;
my $HTMLContent;
open($HTMLFile, "data/example.html");
sysread($HTMLFile, $HTMLContent, -s($HTMLFile));
close($HTMLFile);


# Detect the language used within a HTML document.
$result = $alchemyObj->HTMLGetLanguage($HTMLContent, "http://www.test.com/");
printf $result;



