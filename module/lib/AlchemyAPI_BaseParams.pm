package AlchemyAPI_BaseParams;

use 5.008000;
use strict;
use warnings;

require Exporter;
use AutoLoader qw(AUTOLOAD);
use URI::Escape;

our @ISA = qw(Exporter);

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
	OUTPUT_MODE_XML => 'xml',
	OUTPUT_MODE_RDF => 'rdf'
};


sub new() {
	my $class = shift;
	
	my $self = {
		_url => undef,
		_html => undef,
		_text => undef,
		_outputMode => OUTPUT_MODE_XML, 
		_customParameters => undef
	};
	
	bless $self, $class;

	return $self;
}

sub SetUrl {
	my($self, $url) = @_;
	
	$self->{_url} = $url;
}

sub SetHtml {
	my($self, $html) = @_;
	
	$self->{_html} = $html;
}

sub SetText {
	my($self, $text) = @_;
	
	$self->{_text} = $text;
}

sub SetOutputMode {
	my($self, $outputMode) = @_;
	
	if( OUTPUT_MODE_XML eq $outputMode || OUTPUT_MODE_RDF eq $outputMode ) {
		$self->{_outputMode} = $outputMode;
	}
	else {
		throw Error::Simple( "Error:  Cannot set OutputMode to ".$outputMode);
	}
}

sub GetOutputMode {
	my($self) = @_;
	return $self->{_outputMode};
}

sub SetCustomParameters {
	my $i;
	my($self) = @_;
	for( $i=1; $i< scalar(@_); $i++ ) {
		$self->{_customParameters} .= '&'.$_[$i].'=';
		if(++$i < scalar(@_) ) {
			$self->{_customParameters} .= uri_escape($_[$i]);
		}
	}
}

sub GetCustomParameters {
	my($self) = @_;
	return $self->{_customParameters};
}

sub ResetBaseParams {
	my($self) = @_;
	
	$self->{_url} = undef;
	$self->{_html} = undef;
	$self->{_text} = undef;
}

sub GetParameterString {
	my($self) = @_;
	my $retString = "";
	if( defined $self->{_url} ) {
		$retString .= "&url=".uri_escape($self->{_url});
	}
	if( defined $self->{_html} ) {
		$retString .= "&html=".uri_escape($self->{_html});
	}
	if( defined $self->{_text} ) {
		$retString .= "&text=".uri_escape($self->{_text});
	}
	if( defined $self->{_outputMode} ) {
		$retString .= "&outputMode=".uri_escape($self->{_outputMode});
	}
	if( defined $self->{_customParameters} ){
		$retString .= $self->{_customParameters};
	}
	
	return $retString;
}

1;
__END__
