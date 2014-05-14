package AlchemyAPI_KeywordParams;


use 5.008000;
use strict;
use warnings;

require Exporter;
use AutoLoader qw(AUTOLOAD);
use base qw( AlchemyAPI_BaseParams );
use Error qw(:try);
use URI::Escape;


#our @ISA = "AlchemyAPI_BaseParams";

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use AlchemyAPI ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
our %EXPORT_TAGS = ( 'all' => [ qw(
	
) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
	
);

our $VERSION = '0.5.1';


use constant {
	KEYWORD_EXTRACT_MODE_NORMAL => 'normal',
	KEYWORD_EXTRACT_MODE_STRICT => 'strict'
};

use constant {
	SOURCE_TEXT_CLEANED_OR_RAW => 'cleaned_or_raw',
	SOURCE_TEXT_CLEANED => 'cleaned',
	SOURCE_TEXT_RAW => 'raw',
	SOURCE_TEXT_CQUERY => 'cquery',
	SOURCE_TEXT_XPATH => 'xpath'
	
};


sub new() {
	my $class = shift;
	
	my $self = {
		_maxRetrieve => -1,
		_keywordExtractMode => undef,
		_showSourceText => undef,
		_sentiment => undef,
		_sourceText => undef,
		_cQuery => undef,
		_xPath => undef,
		_baseUrl => undef, 
		_outputMode => AlchemyAPI_BaseParams::OUTPUT_MODE_XML
		
	};

	bless $self, $class;

	return $self;
}

sub SetMaxRetrieve {
	my($self, $maxRetrieve) = @_;
	
	$self->{_maxRetrieve} = $maxRetrieve;
}

sub GetMaxRetrieve {
	my($self) = @_;
	return $self->{_maxRetrieve};
}

sub SetKeywordExtractMode {
	my($self, $keywordExtractMode) = @_;
	
	if( KEYWORD_EXTRACT_MODE_NORMAL eq $keywordExtractMode || KEYWORD_EXTRACT_MODE_STRICT eq $keywordExtractMode ) {
		$self->{_keywordExtractMode} = $keywordExtractMode;
	}
	else {
		throw Error::Simple( "Error:  Cannot set KeywordExtractMode to ".$keywordExtractMode);
	}
}

sub GetKeywordExtractMode {
	my($self) = @_;
	return $self->{_keywordExtractMode};
}

sub SetShowSourceText {
	my($self, $showSourceText) = @_;
	
	if( 0 == $showSourceText || 1 == $showSourceText ) {
		$self->{_showSourceText} = $showSourceText;
	}
	else {
		throw Error::Simple( "Error:  Cannot set ShowSourceText to ".$showSourceText);
	}
}

sub GetShowSourceText {
	my($self) = @_;
	return $self->{_showSourceText};
}

sub SetSentiment {
	my($self, $sentiment) = @_;
	
	if( 0 == $sentiment || 1 == $sentiment ) {
		$self->{_sentiment} = $sentiment;
	}
	else {
		throw Error::Simple( "Error:  Cannot set Sentiment to ".$sentiment);
	}
}

sub GetSentiment {
	my($self) = @_;
	return $self->{_sentiment};
}

sub SetSourceText {
	my($self, $sourceText) = @_;
	
	if( SOURCE_TEXT_CLEANED_OR_RAW eq $sourceText || SOURCE_TEXT_CLEANED eq $sourceText || SOURCE_TEXT_RAW eq $sourceText ||
		SOURCE_TEXT_CQUERY eq $sourceText || SOURCE_TEXT_XPATH eq $sourceText ) {
		$self->{_sourceText} = $sourceText;
	}
	else {
		throw Error::Simple( "Error:  Cannot set SourceText to ".$sourceText);
	}
}

sub GetSourceText {
	my($self) = @_;
	return $self->{_sourceText};
}

sub SetCQuery {
	my($self, $cQuery) = @_;
	
	$self->{_cQuery} = $cQuery;
}

sub GetCQuery {
	my($self) = @_;
	return $self->{_cQuery};
}

sub SetXPath {
	my($self, $xPath) = @_;
	
	$self->{_xPath} = $xPath;
}

sub GetXPath {
	my($self) = @_;
	return $self->{_xPath};
}

sub SetBaseUrl {
	my($self, $baseUrl) = @_;
	
	$self->{_baseUrl} = $baseUrl;
}

sub GetBaseUrl {
	my($self) = @_;
	return $self->{_baseUrl};
}

sub GetParameterString {
	my($self) = @_;
	my $retString = $self->SUPER::GetParameterString();
	if( $self->{_maxRetrieve} != -1 ) {
		$retString .= "&maxRetrieve=".$self->{_maxRetrieve};
	}
	if( defined $self->{_keywordExtractMode} ) {
		$retString .= "&keywordExtractMode=".(($self->{_keywordExtractMode} eq 'strict') ? "strict" : "normal");
	}
	if( defined $self->{_showSourceText} ) {
		$retString .= "&showSourceText=".$self->{_showSourceText};
	}
	if( defined $self->{_sentiment} ) {
		$retString .= "&sentiment=".$self->{_sentiment};
	}
	if( defined $self->{_sourceText} ) {
		$retString .= "&sourceText=".$self->{_sourceText};
	}
	if( defined $self->{_cQuery} ) {
		$retString .= "&cquery=".uri_escape($self->{_cQuery});
	}
	if( defined $self->{_xPath} ) {
		$retString .= "&xpath=".uri_escape($self->{_xPath});
	}
	if( defined $self->{_baseUrl} ) {
		$retString .= "&baseUrl=".uri_escape($self->{_baseUrl});
	}
	
	return $retString;
}

1;
__END__
