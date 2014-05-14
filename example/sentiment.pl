#!/usr/bin/perl -w
############################################################################
#
# AlchemyAPI Perl Example: Sentiment Analysis
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


# Get positive / negative sentiment for a text string.
$result = $alchemyObj->TextGetTextSentiment("I'm not impressed with Justin Bieber's new haircut.");
printf $result;


# Get positive / negative sentiment for a web URL.
$result = $alchemyObj->URLGetTextSentiment("http://www.gigaom.com/");
printf $result;


# Load an example HTML input file to analyze.
my $HTMLFile;
my $HTMLContent;
open($HTMLFile, "data/example.html");
sysread($HTMLFile, $HTMLContent, -s($HTMLFile));
close($HTMLFile);


# Get positive / negative sentiment for a HTML document.
$result = $alchemyObj->HTMLGetTextSentiment($HTMLContent, "http://www.test.com/");
printf $result;


my $keywordParams = new AlchemyAPI_KeywordParams();
$keywordParams->SetSentiment(1);

# Get keywords with keyword-targeted sentiment for a text string.
$result = $alchemyObj->TextGetRankedKeywords("I'm not impressed with Justin Bieber's new haircut.", $keywordParams);
printf $result;


my $entityParams = new AlchemyAPI_EntityParams();
$entityParams->SetSentiment(1);


# Get entities with entity-targeted sentiment for a text string.
$result = $alchemyObj->TextGetRankedNamedEntities("I'm not impressed with Justin Bieber's new haircut.", $entityParams);
printf $result;

my $targetedSentimentParams = new AlchemyAPI_TargetedSentimentParams();
$targetedSentimentParams->SetShowSourceText(1);

#Get Targeted Sentiment for a text string.
$result = $alchemyObj->TextGetTargetedSentiment("This car is terrible.", "car", $targetedSentimentParams);
printf $result;

#Get Targeted Sentiment for a text string.
$result = $alchemyObj->URLGetTargetedSentiment("http://techcrunch.com/2012/03/01/keen-on-anand-rajaraman-how-walmart-wants-to-leapfrog-over-amazon-tctv", "Walmart", $targetedSentimentParams);
printf $result;

#Get Targeted Sentiment for a text string.
$result = $alchemyObj->HTMLGetTargetedSentiment($HTMLContent, "http://www.test.com", "companies", $targetedSentimentParams);
printf $result;
