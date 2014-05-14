#!/usr/bin/perl -w
############################################################################
#
# AlchemyAPI Perl Example: Relations Extraction
# Author: Orchestr8, LLC
# Copyright (C) 2009-2011, Orchestr8, LLC.
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



# Get a list of relations for a text string.
$result = $alchemyObj->TextGetRelations("Hello there, my name is Bob Jones. I am married to Lisa Jones.  Bob Jones is indeed my name!");
if ($result ne "error")
{
	printf $result;
}


# Get a list of relations for a web URL.
$result = $alchemyObj->URLGetRelations("http://www.gigaom.com/");
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


# Get a list of relations for a HTML document.
$result = $alchemyObj->HTMLGetRelations($HTMLContent, "http://www.test.com/");
if ($result ne "error")
{
	printf $result;
}


my $relationParams = new AlchemyAPI_RelationParams();
$relationParams->SetSentiment(1);
$relationParams->SetEntities(1);
$relationParams->SetDisambiguate(1);
$relationParams->SetSentimentExcludeEntities(1);

$result = $alchemyObj->TextGetRelations("Madonna enjoys tasty Pepsi.  I love her style.", $relationParams);
if ($result ne "error")
{
	printf $result;
}

$relationParams->SetRequireEntities(1);
$result = $alchemyObj->TextGetRelations("Madonna enjoys tasty Pepsi.  I love her style.", $relationParams);
if ($result ne "error")
{
	printf $result;
}


