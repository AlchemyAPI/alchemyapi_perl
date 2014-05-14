#!/usr/bin/perl -w
############################################################################
#
# AlchemyAPI Perl Example: Taxonomy Classification
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

my $taxonomyParams = new AlchemyAPI_TaxonomyParams();
$taxonomyParams->SetSourceText("cleaned_or_raw");
$taxonomyParams->SetShowSourceText(0);

# Get the taxonomy classification from the text in a URL
$result = $alchemyObj->URLGetRankedTaxonomy("http://www.umich.edu/", $taxonomyParams);
print $result;

# Load an example HTML file to analyze
my $HTMLFile;
my $HTMLContent;
open($HTMLFile, "data/example.html");
sysread($HTMLFile, $HTMLContent, -s($HTMLFile));
close($HTMLFile);

# Get that taxonomy
$result = $alchemyObj->HTMLGetRankedTaxonomy($HTMLContent, "http://www.test.com/", $taxonomyParams);
printf $result;

# Now, try with some of our own text
$result = $alchemyObj->TextGetRankedTaxonomy("Help! I've fallen and I can't get up.", $taxonomyParams);
printf $result;
