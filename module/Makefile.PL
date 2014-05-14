use 5.008000;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'AlchemyAPI',
    VERSION_FROM      => 'lib/AlchemyAPI.pm', # finds $VERSION
    PREREQ_PM         => {URI::Escape => 0,
			  LWP::UserAgent => 0,
			  XML::XPath => 0,
			  XML::XPath::XMLParser => 0},
    ($] >= 5.005 ?     ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM  => 'lib/AlchemyAPI.pm', # retrieve abstract from module
       AUTHOR         => 'root <root@localdomain>') : ()),
);
