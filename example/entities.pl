#!/usr/bin/perl -w
############################################################################
#
# AlchemyAPI Perl Example: Entity Extraction
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


# Get a ranked list of named entities for a text string.
$result = $alchemyObj->TextGetRankedNamedEntities("Hello there, my name is Bob Jones. I am married to Lisa Jones.  Bob Jones is indeed my name!");
if ($result ne "error")
{
	printf $result;
}


# Get a ranked list of named entities for a web URL.
$result = $alchemyObj->URLGetRankedNamedEntities("http://www.gigaom.com/");
if ($result ne "error")
{
	printf $result;
}


# Load an example HTML input file to analyze.
my $HTMLFile;
my $HTMLContent;
open($HTMLFile, "data/example.html");
sysread($HTMLFile, $HTMLContent, -s($HTMLFile));
close($HTMLFile);


# Get a ranked list of named entities for a HTML document.
$result = $alchemyObj->HTMLGetRankedNamedEntities($HTMLContent, "http://www.test.com/");
if ($result ne "error")
{
	printf $result;
}
