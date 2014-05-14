#!/usr/bin/perl -w
############################################################################
#
# AlchemyAPI Perl Example: Combined Data API call
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

my $combinedParams = new AlchemyAPI_CombinedParams();
$combinedParams->SetSentiment(1);
$combinedParams->SetShowSourceText(1);
$combinedParams->SetQuotations(1);


# Image, targeted sentiment, entity, keyword, title, author, taxonomy, 
# concept, quotations, clean text
$combinedParams->SetExtractMode("always-infer");
$combinedParams->SetExtract("page-image,entity,keyword,title,author,taxonomy,concept");
$result = $alchemyObj->URLGetCombinedData("http://cnnworldlive.cnn.com/Event/Crisis_in_Ukraine_2?hpt=hp_t1&iid=article_sidebar",
                                          $combinedParams);
printf $result;

# Clean text, title, image (more CPU intensive, more accurate)
$combinedParams->SetExtractMode("always-infer");
$combinedParams->SetExtract("page-image,title");
$result = $alchemyObj->URLGetCombinedData("http://www.zdnet.com/at-and-t-rebuffs-netflix-ceos-net-neutrality-defense-7000027584/",
                                          $combinedParams);
printf $result;

# Clean text, title, image (less CPU intensive, less accurate)
$combinedParams->SetExtractMode("trust-metadata");
$combinedParams->SetExtract("page-image,title");
$result = $alchemyObj->URLGetCombinedData("http://www.eonline.com/news/523881/kim-kardashian-stuns-on-vogue-check-out-her-6-hottest-magazine-covers",
                                          $combinedParams);
printf $result;

# Get data on some text
$combinedParams->SetExtractMode("trust-metadata");
$combinedParams->SetExtract("entity,keyword,title,taxonomy,concept");
$result = $alchemyObj->TextGetCombinedData("A second day of searching for sightings of possible debris from a missing Malaysian airliner in the southern Indian Ocean has proved fruitless.", $combinedParams);
printf $result;
