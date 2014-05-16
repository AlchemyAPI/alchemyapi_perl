package AlchemyAPI_EntityParams;


use 5.008000;
use strict;
use warnings;

require Exporter;
use AutoLoader qw(AUTOLOAD);
use base qw( AlchemyAPI_BaseParams );
use Error qw(:try);
use URI::Escape;


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

our $VERSION = '0.10';


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
		_disambiguate => undef,
		_linkedData => undef,
		_coreference => undef,
		_quotations => undef,
		_showSourceText => undef,
		_sourceText => undef,
		_cQuery => undef,
		_xPath => undef,
		_baseUrl => undef, 
		_sentiment => undef,
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

sub SetDisambiguate {
	my($self, $disambiguate) = @_;
	
	if( 0 == $disambiguate || 1 == $disambiguate ) {
		$self->{_disambiguate} = $disambiguate;
	}
	else {
		throw Error::Simple( "Error:  Cannot set Disambiguate to ".$disambiguate);
	}
}

sub GetDisambiguate {
	my($self) = @_;
	return $self->{_disambiguate};
}

sub SetLinkedData {
	my($self, $linkedData) = @_;
	
	if( 0 == $linkedData || 1 == $linkedData ) {
		$self->{_linkedData} = $linkedData;
	}
	else {
		throw Error::Simple( "Error:  Cannot set LinkedData to ".$linkedData);
	}
}

sub GetLinkedData {
	my($self) = @_;
	return $self->{_linkedData};
}

sub SetCoreference {
	my($self, $coreference) = @_;
	
	if( 0 == $coreference || 1 == $coreference ) {
		$self->{_coreference} = $coreference;
	}
	else {
		throw Error::Simple( "Error:  Cannot set Coreference to ".$coreference);
	}
}

sub GetCoreference {
	my($self) = @_;
	return $self->{_coreference};
}

sub SetQuotations {
	my($self, $quotations) = @_;
	
	if( 0 == $quotations || 1 == $quotations ) {
		$self->{_quotations} = $quotations;
	}
	else {
		throw Error::Simple( "Error:  Cannot set Quotations to ".$quotations);
	}
}

sub GetQuotations {
	my($self) = @_;
	return $self->{_quotations};
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


sub SetSentiment {
        my($self, $sentiment) = @_;

        if( 0 == $sentiment || 1 == $sentiment ) {
                $self->{_sentiment} = $sentiment;
        }
        else {
                throw Error::Simple( "Error:  Cannot set sentiment to ".$sentiment);
        }
}

sub GetSentiment {
        my($self) = @_;
        return $self->{_sentiment};
}


sub GetParameterString {
	my($self) = @_;
	my $retString = $self->SUPER::GetParameterString();
	if( $self->{_maxRetrieve} != -1 ) {
		$retString .= "&maxRetrieve=".$self->{_maxRetrieve};
	}
	if( defined $self->{_disambiguate} ) {
		$retString .= "&disambiguate=".$self->{_disambiguate};
	}
	if( defined $self->{_linkedData} ) {
		$retString .= "&linkedData=".$self->{_linkedData};
	}
	if( defined $self->{_coreference} ) {
		$retString .= "&coreference=".$self->{_coreference};
	}
	if( defined $self->{_quotations} ) {
		$retString .= "&quotations=".$self->{_quotations};
	}
	if( defined $self->{_showSourceText} ) {
		$retString .= "&showSourceText=".$self->{_showSourceText};
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
	if( defined $self->{_sentiment} ) {
		$retString .= "&sentiment=".$self->{_sentiment};
	}
	
	return $retString;
}

1;
__END__
