#!/usr/bin/perl -w

############################################################################
#
# AlchemyAPI Perl Example: Image Keyword Extraction
# Author: AlchemyAPI, LLC
# Copyright (C) 2009-2014, AlchemyAPI, LLC.
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
my $imageParams = new AlchemyAPI_ImageKeywordParams();

# Get a list of keywords for an image
my $imageURL = "http://betting-strategy.org/wp-content/uploads/2013/08/Horse-racing-1.jpg";
$result = $alchemyObj->URLGetRankedImageKeywords($imageURL, $imageParams);
printf $result;

# Let's try giving the URL call an HTML page, as it should
# extract the most relevant image before providing relevant keywords
$imageParams->SetExtractMode("trust-metadata");
$result = $alchemyObj->URLGetRankedImageKeywords("http://www.cnn.com/", $imageParams);
printf $result;

# Change the extractMode parameter
$imageParams->SetExtractMode("always-infer");
$result = $alchemyObj->URLGetRankedImageKeywords("http://www.cnn.com/", $imageParams);
printf $result;

# Change the extractMode parameter
$imageParams->SetExtractMode("only-metadata");
$result = $alchemyObj->URLGetRankedImageKeywords("http://www.cnn.com/", $imageParams);
printf $result;

# Now, let's try using the POST-based approach
# use a sample image
my $localImage = "data/beach_wedding_at_dusk.jpg";

open IMG, $localImage or die $!;
binmode IMG;
my ($buffer, $data, $length);
while (($length = read IMG, $data, 4) != 0) {
    $buffer .= $data;
}
close(IMG);

$imageParams->SetImagePostMode("raw");
$result = $alchemyObj->ImageGetRankedImageKeywords($buffer, $imageParams);
printf $result

