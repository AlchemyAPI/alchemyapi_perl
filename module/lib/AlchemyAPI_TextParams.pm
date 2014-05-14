package AlchemyAPI_TextParams;


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

our $VERSION = '0.5.1';




sub new() {
	my $class = shift;
	my($self) = AlchemyAPI_BaseParams->new(@_);
	$self = {
		_useMetadata => undef,
		_extractLinks => undef,
		_outputMode => AlchemyAPI_BaseParams::OUTPUT_MODE_XML
	};
	
	bless $self, $class;


	return $self;
}


sub SetUseMetadata {
	my($self, $useMetadata) = @_;
	
	if( 0 == $useMetadata || 1 == $useMetadata ) {
		$self->{_useMetadata} = $useMetadata;
	}
	else {
		throw Error::Simple( "Error:  Cannot set UseMetadata to ".$useMetadata);
	}
}

sub GetUseMetadata {
	my($self) = @_;
	return $self->{_useMetadata};
}

sub SetExtractLinks {
	my($self, $extractLinks) = @_;
	
	if( 0 == $extractLinks || 1 == $extractLinks ) {
		$self->{_extractLinks} = $extractLinks;
	}
	else {
		throw Error::Simple( "Error:  Cannot set ExtractLinks to ".$extractLinks);
	}
}

sub GetExtractLinks {
	my($self) = @_;
	return $self->{_extractLinks};
}



sub GetParameterString {
	my($self) = @_;
	my $retString = $self->SUPER::GetParameterString();
	if( defined $self->{_useMetadata} ) {
		$retString .= "&useMetadata=".$self->{_useMetadata};
	}
	if( defined $self->{_extractLinks} ) {
		$retString .= "&extractLinks=".$self->{_extractLinks};
	}
	
	return $retString;
}

1;
__END__
