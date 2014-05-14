package AlchemyAPI_ConstraintQueryParams;


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

	my $self = {
		_cQuery => undef,
		_outputMode => AlchemyAPI_BaseParams::OUTPUT_MODE_XML
		
	};
	
	bless $self, $class;
	
	

	return $self;
}

sub SetCQuery {
	my($self, $cQuery) = @_;
	
	$self->{_cQuery} = $cQuery;
}

sub GetCQuery {
	my($self) = @_;
	return $self->{_cQuery};
}


sub GetParameterString {
	my($self) = @_;
	my $retString = $self->SUPER::GetParameterString();
	if( defined $self->{_cQuery} ) {
		$retString .= "&cquery=".uri_escape($self->{_cQuery});
	}
	
	return $retString;
}

1;
__END__
