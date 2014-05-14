#!/usr/bin/perl -w
############################################################################
#
# AlchemyAPI Perl Example: Image Extraction
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

my $imageParams = new AlchemyAPI_ImageParams();

# Get the image from a URL, using the more CPU intensive (and more accurate) approach
$imageParams->SetExtractMode("always-infer");
$result = $alchemyObj->URLGetImage("http://www.umich.edu/", $imageParams);
printf $result;

# Get the image from a URL, using the less CPU intensive (and less accurate) approach
$imageParams->SetExtractMode("trust-metadata");
$result = $alchemyObj->URLGetImage("http://www.umich.edu/", $imageParams);
printf $result;

# Load an example HTML file to analyze
my $HTMLFile;
my $HTMLContent;
open($HTMLFile, "data/example.html");
sysread($HTMLFile, $HTMLContent, -s($HTMLFile));
close($HTMLFile);

# Get that image
$result = $alchemyObj->HTMLGetImage($HTMLContent, "http://www.test.com/", $imageParams);
printf $result
