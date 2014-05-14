#!/usr/bin/perl -w
############################################################################
#
# AlchemyAPI Perl Example: SDK Parameters
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

my $keywordParams = new AlchemyAPI_KeywordParams();
$keywordParams->SetMaxRetrieve(1);
$keywordParams->SetKeywordExtractMode(AlchemyAPI_KeywordParams::KEYWORD_EXTRACT_MODE_STRICT);



# Get a list of topic keywords for a text string.
$result = $alchemyObj->TextGetRankedKeywords("Microsoft released a new product today.  Microsoft wants you to try it out.  Download it here.", $keywordParams);
printf $result;



my $entityParams = new AlchemyAPI_EntityParams();
$entityParams->SetMaxRetrieve(2);
$entityParams->SetDisambiguate(1);
$entityParams->SetSentiment(1);
$entityParams->SetOutputMode(AlchemyAPI_BaseParams::OUTPUT_MODE_RDF);

# Get a ranked list of named entities for a web URL.
$result = $alchemyObj->URLGetRankedNamedEntities("http://www.gigaom.com/", $entityParams);
if ($result ne "error")
{
	printf $result;
}





# Get a list of topic keywords for a HTML document.
#$result = $alchemyObj->HTMLGetRankedKeywords($HTMLContent, "http://www.test.com/");
#printf $result;


printf "Done";
