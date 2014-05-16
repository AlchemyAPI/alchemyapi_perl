package AlchemyAPI_TaxonomyParams;

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

our $VERSION = '0.10';

sub new() {

    my $class = shift;

    my $self = {
        _outputMode => AlchemyAPI_BaseParams::OUTPUT_MODE_XML,
        _maxRetrieve => -1,
        _showSourceText => undef,
        _sourceText => undef,
        _cquery => undef,
        _xpath => undef,
        _baseUrl => undef
    };

    bless $self, $class;

    return $self;
}

sub SetXPath
{
    my($self, $xpath) = @_;
    $self->{_xpath} = $xpath;
}

sub GetXPath
{
    my($self) = @_;
    return $self->{_xpath};
}

sub SetCQuery
{
    my($self, $cquery) = @_;
    $self->{_cquery} = $cquery;
}

sub GetCQuery
{
    my($self) = @_;
    return $self->{_cquery};
}

sub SetSourceText
{
    my($self, $sourceText) = @_;

    if ("cleaned_or_raw" eq $sourceText ||
        "cleaned"        eq $sourceText ||
        "raw"            eq $sourceText ||
        "cquery"         eq $sourceText ||
        "xpath"          eq $sourceText)
    {
        $self->{_sourceText} = $sourceText;
    }
    else
    {
        throw Error::Simple("Error: Cannot set sourceText to ".$sourceText);
    }

}

sub GetSourceText
{
    my($self) = @_;
    return $self->{_sourceText};
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

    if( defined $self->{_xpath} )
    {
        $retString .= "&xpath=".$self->{_xpath};
    }
    if( defined $self->{_cquery} )
    {
        $retString .= "&cquery=".$self->{_cquery};
    }
    if( defined $self->{_sourceText} )
    {
        $retString .= "&sourceText=".$self->{_sourceText};
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
