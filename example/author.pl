#!/usr/bin/perl -w
############################################################################
#
# AlchemyAPI Perl Example: Retrieve Author
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

# Load an example HTML input file to analyze.
 my $HTMLFile;
 my $HTMLContent;
 open($HTMLFile, "data/example.html");
 sysread($HTMLFile, $HTMLContent, -s($HTMLFile));
 close($HTMLFile);

my $result = '';


# Categorize a web URL by topic.
$result = $alchemyObj->URLGetAuthor("http://www.politico.com/blogs/media/2012/02/detroit-news-ed-upset-over-romney-edit-115247.html");
printf $result;

# Categorize a web URL by topic.
$result = $alchemyObj->HTMLGetAuthor($HTMLContent, "http://www.test.com");
printf $result;

