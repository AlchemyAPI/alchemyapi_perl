package AlchemyAPI_CategoryParams;


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
		_sourceText => undef,
		_cQuery => undef,
		_xPath => undef,
		_baseUrl => undef, 
		_outputMode => AlchemyAPI_BaseParams::OUTPUT_MODE_XML
		
	};
	
	bless $self, $class;

	return $self;
}



sub SetSourceText {
	my($self, $sourceText) = @_;
	
	if( SOURCE_TEXT_CLEANED_OR_RAW eq $sourceText || SOURCE_TEXT_CLEANED eq $sourceText || SOURCE_TEXT_RAW eq $sourceText ) {
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
