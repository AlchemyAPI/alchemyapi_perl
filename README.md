==================================
 AlchemyAPI Perl SDK: version 0.9
==================================

This is a Perl implementation of the AlchemyAPI SDK.

DEPENDENCIES

This module requires these other modules and libraries:

   Error;
   URI::Escape;
   LWP::UserAgent;
   XML::XPath;
   XML::XPath::XMLParser;

Dependencies can be installed by doing the following:

   perl -MCPAN -e shell
   cpan> install MODULE

** NB: Additionally, libyaml-appconfig-perl and libxml-parser-perl packages should
       be installed prior to compiling the AlchemyAPI Perl SDK module.

INSTALLATION

To install this module type the following:

   cd module	
   perl Makefile.PL /path/to/Perl/SDK
   make
   make install

RUNNING EXAMPLES

** NB: You will need to point your perl command to your local files, e.g.
export PERL5LIB=</path/to/SDK>/module/blib/lib

Several code examples are included to illustrate using the AlchemyAPI
for named entity extraction, text classification, language identification,
and other tasks.

All code samples are within the "example" directory.

To run these code samples you must first edit the (api_key.txt) file, 
adding your assigned AlchemyAPI key.

Code Samples:

   1. Entity Extraction: perl entities.pl

   2. Concept Tagging: perl concepts.pl

   3. Keyword Extraction: perl keywords.pl

   4. Text Categorization: perl categories.pl

   5. Language Identification: perl language.pl

   6. HTML Text Extraction: perl text_extract.pl

   7. HTML Structured Content Scraping: perl constraint_queries.pl

   8. Microformats Extraction: perl microformats.pl

   9. RSS / ATOM Feed Links Extraction: perl feed_links.pl

  10. Sentiment Analysis: perl sentiment.pl
  
  11. Relations Extraction: perl relations.pl

  12. Parameter usage examples: perl parameters.pl

  13. Author Extraction: perl author.pl

  14. Taxonomy Classification: perl taxonomy.pl

  15. Image Extraction: perl image_extract.pl

  16. Combined Data API Call: perl combined.pl

  17. Image Keyword Extraction: perl image_keywords.pl


COPYRIGHT AND LICENCE

Copyright (C) 2009-2014 Orchestr8, LLC.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.5 or,
at your option, any later version of Perl 5 you may have available.


