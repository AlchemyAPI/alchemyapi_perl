package AlchemyAPI_CombinedParams;

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
        _extract => undef,
        _outputMode => AlchemyAPI_BaseParams::OUTPUT_MODE_XML,
        #_jsonp => undef,
        _disambiguate => undef,
        _linkedData => undef,
        _coreference => undef,
        _quotations => undef,
        _sentiment => undef,
        _showSourceText => undef,
        _maxRetrieve => -1,
        _baseUrl => undef
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

sub SetExtract
{
    my($self, $extract) = @_;

    $self->{_extract} = $extract;
}

sub GetExtract
{
    my($self) = @_;
    return $self->{_extract};
}

sub SetDisambiguate
{
    my($self, $disambiguate) = @_;

    if ( 1 == $disambiguate || 
         0 == $disambiguate )
    {
        $self->{_disambiguate} = $disambiguate;
    }
    else
    {
        throw Error::Simple("Error: Cannot set disambiguate to ".$disambiguate);
    }
}

sub GetDisambiguate
{
    my($self) = @_;
    return $self->{_disambiguate};
}

sub SetLinkedData
{
    my($self, $linkedData) = @_;

    if ( 1 == $linkedData || 
         0 == $linkedData )
    {
        $self->{_linkedData} = $linkedData;
    }
    else
    {
        throw Error::Simple("Error: Cannot set linkedData to ".$linkedData);
    }
}

sub GetLinkedData
{
    my($self) = @_;
    return $self->{_linkedData};
}

sub SetCoreference
{
    my($self, $coreference) = @_;

    if ( 1 == $coreference || 
         0 == $coreference )
    {
        $self->{_coreference} = $coreference;
    }
    else
    {
        throw Error::Simple("Error: Cannot set coreference to ".$coreference);
    }
}

sub GetCoreference
{
    my($self) = @_;
    return $self->{_coreference};
}

sub SetQuotations
{
    my($self, $quotations) = @_;

    if ( 1 == $quotations || 
         0 == $quotations )
    {
        $self->{_quotations} = $quotations;
    }
    else
    {
        throw Error::Simple("Error: Cannot set quotations to ".$quotations);
    }
}

sub GetQuotations
{
    my($self) = @_;
    return $self->{_quotations};
}

sub SetSentiment
{
    my($self, $sentiment) = @_;

    if ( 1 == $sentiment || 
         0 == $sentiment )
    {
        $self->{_sentiment} = $sentiment;
    }
    else
    {
        throw Error::Simple("Error: Cannot set sentiment to ".$sentiment);
    }
}

sub GetSentiment
{
    my($self) = @_;
    return $self->{_sentiment};
}

sub SetShowSourceText
{
    my($self, $showSourceText) = @_;

    if ( 1 == $showSourceText || 
         0 == $showSourceText )
    {
        $self->{_showSourceText} = $showSourceText;
    }
    else
    {
        throw Error::Simple("Error: Cannot set showSourceText to ".$showSourceText);
    }
}

sub GetShowSourceText
{
    my($self) = @_;
    return $self->{_showSourceText};
}

sub SetMaxRetrieve
{
    my($self, $maxRetrieve) = @_;
    $self->{_maxRetrieve} = $maxRetrieve;
}

sub GetMaxRetrieve
{
    my($self) = @_;
    return $self->{_maxRetrieve};
}

sub SetBaseURL
{
    my($self, $baseUrl) = @_;
    $self->{_baseUrl} = $baseUrl;
}

sub GetBaseURL
{
    my($self) = @_;
    return $self->{_baseUrl};
}

sub GetParameterString {
	my($self) = @_;
	my $retString = $self->SUPER::GetParameterString();

    if( defined $self->{_extractMode} )
    {
        $retString .= "&extractMode=".$self->{_extractMode};
    }
    if( defined $self->{_extract} )
    {
        $retString .= "&extract=".$self->{_extract};
    }
    #if( defined $self->{_jsonp} )
    #{
    #    $retString .= "&jsonp=".$self->{_jsonp};
    #}
    if( defined $self->{_disambiguate} )
    {
        $retString .= "&disambiguate=".$self->{_disambiguate};
    }
    if( defined $self->{_linkedData} )
    {
        $retString .= "&linkedData=".$self->{_linkedData};
    }
    if( defined $self->{_coreference} )
    {
        $retString .= "&coreference=".$self->{_coreference};
    }
    if( defined $self->{_quotations} )
    {
        $retString .= "&quotations=".$self->{_quotations};
    }
    if( defined $self->{_sentiment} )
    {
        $retString .= "&sentiment=".$self->{_sentiment};
    }
    if( defined $self->{_showSourceText} )
    {
        $retString .= "&showSourceText=".$self->{_showSourceText};
    }
    if( defined $self->{_baseUrl} )
    {
        $retString .= "&baseUrl=".uri_escape($self->{_baseUrl});
    }
	if( $self->{_maxRetrieve} != -1 ) 
    {
		$retString .= "&maxRetrieve=".$self->{_maxRetrieve};
	}
	return $retString;
}
1;
__END__
