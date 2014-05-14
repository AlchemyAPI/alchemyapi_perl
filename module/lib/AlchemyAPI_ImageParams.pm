package AlchemyAPI_ImageParams;

use 5.008000;
use strict;
use warnings;

require Exporter;
use AutoLoader qw(AUTOLOAD);
use base qw(AlchemyAPI_BaseParams);
use Error qw(:try);
use URI::Escape;


our %EXPORT_TAGS = ( 'all' => [ qw(

) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(

);

our $VERSION = '0.9';

sub new() {

    my $class = shift;

    my $self = {
        _extractMode => undef,
        _outputMode => AlchemyAPI_BaseParams::OUTPUT_MODE_XML,
    };

    bless $self, $class;

    return $self;
}

sub SetExtractMode {
    my($self, $extractMode) = @_;

    if ( "trust-metadata" eq $extractMode || 
         "always-infer"   eq $extractMode )
    {
        $self->{_extractMode} = $extractMode;
    }
    else
    {
        throw Error::Simple("Error: Cannot set extractMode to ".$extractMode);
    }
}

sub GetExtractMode
{
    my($self) = @_;
    return $self->{_extractMode};
}

sub GetParameterString {
	my($self) = @_;
	my $retString = $self->SUPER::GetParameterString();

    if( defined $self->{_extractMode} )
    {
        $retString .= "&extractMode=".$self->{_extractMode};
    }
	return $retString;
}
1;
__END__
