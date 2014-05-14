package AlchemyAPI;

use 5.008000;
use strict;
use warnings;

require Exporter;
use AutoLoader qw(AUTOLOAD);
use AlchemyAPI_BaseParams;
use AlchemyAPI_CategoryParams;
use AlchemyAPI_CombinedParams;
use AlchemyAPI_ConceptParams;
use AlchemyAPI_ConstraintQueryParams;
use AlchemyAPI_EntityParams;
use AlchemyAPI_ImageParams;
use AlchemyAPI_KeywordParams;
use AlchemyAPI_LanguageParams;
use AlchemyAPI_TaxonomyParams;
use AlchemyAPI_TextParams;
use AlchemyAPI_RelationParams;
use AlchemyAPI_TargetedSentimentParams;


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

our $VERSION = '0.9';


use URI::Escape;
require LWP::UserAgent;
require XML::XPath;
require XML::XPath::XMLParser;


sub new {
	my $class = shift;

	my $self = {
		_apiKey => '',
		_hostPrefix => 'access',
		_userAgent => LWP::UserAgent->new,
	};

	bless $self, $class;

	$self->{_userAgent}->timeout(10);
	$self->{_userAgent}->env_proxy;

	return $self;
}


my $AlchemyAPI_Success = 'success';
my $AlchemyAPI_Error = 'error';

sub LoadKey {
	my($self, $filename) = @_;

	unless (open(AlchemyAPI_Key_File,$filename)) {
		printf STDERR "Can't load API key: $filename: $!\n";
		return $AlchemyAPI_Error;
	}

	sysread(AlchemyAPI_Key_File, $self->{_apiKey}, -s(AlchemyAPI_Key_File));
	close(AlchemyAPI_Key_File); 

	$self->{_apiKey} =~ s/\r|\n//g;

	if (length $self->{_apiKey} < 5)
	{
		printf STDERR "Can't load API key: $filename: $!\n";
		return $AlchemyAPI_Error;
	}

	return $AlchemyAPI_Success;
}

sub SetKey {
	my($self, $apiKey) = @_;

	$self->{_apiKey} = $apiKey;

	if (length $self->{_apiKey} < 5)
	{
		printf STDERR "Can't set API key: $apiKey: $!\n";
		return $AlchemyAPI_Error;
	}

	return $AlchemyAPI_Success;
}

sub SetAPIHost {
	my($self, $apiHost) = @_;

	$self->{_hostPrefix} = $apiHost;

	if (length $self->{_hostPrefix} < 2)
	{
		printf STDERR "Can't set API host: $apiHost: $!\n";
		return $AlchemyAPI_Error;
	}

	return $AlchemyAPI_Success;
}

sub CheckURL {
	my($self, $url) = @_;

	if ($self->{_apiKey} eq 'blank')
	{
		printf STDERR "Load an AlchemyAPI key!\n";
		return $AlchemyAPI_Error;
	}

	if (length $url < 5)
	{
		printf STDERR "Provide a valid HTTP URL to analyze.\n";
		return $AlchemyAPI_Error;
	}

	return $AlchemyAPI_Success;
}

sub CheckText {
	my($self, $text) = @_;

	if ($self->{_apiKey} eq 'blank')
	{
		printf STDERR "Load an AlchemyAPI key!\n";
		return $AlchemyAPI_Error;
	}

	if (length $text < 10)
	{
		printf STDERR "Provide more text to analyze.\n";
		return $AlchemyAPI_Error;
	}

	return $AlchemyAPI_Success;
}

sub CheckHTML {
	my($self, $html, $url) = @_;

	if ($self->{_apiKey} eq 'blank')
	{
		printf STDERR "Load an AlchemyAPI key!\n";
		return $AlchemyAPI_Error;
	}

	if (length $html < 10)
	{
		printf STDERR "Provide more text to analyze.\n";
		return $AlchemyAPI_Error;
	}

	if (length $url < 5)
	{
		printf STDERR "Provide a valid HTTP URL to analyze.\n";
		return $AlchemyAPI_Error;
	}

	return $AlchemyAPI_Success;
}

sub POST {
	my($self, $APICall, $APICallPrefix, $APIParameter) = @_;
	my $AlchemyAPI_Endpoint = 'http://'.$self->{_hostPrefix}.'.alchemyapi.com/calls/'.$APICallPrefix.'/'.$APICall;
	my $AlchemyAPI_Arguments = 'apikey='.$self->{_apiKey}.$APIParameter->GetParameterString();
	
	$APIParameter->ResetBaseParams();

	my $req = HTTP::Request->new(POST => $AlchemyAPI_Endpoint);
	$req->content_type('application/x-www-form-urlencoded');
	$req->content($AlchemyAPI_Arguments);

	my $response = $self->{_userAgent}->request($req);

	if ($response->is_success)
	{
		my $xp = XML::XPath->new(xml => $response->content);

		my $result = $xp->getNodeText('/results/status');

		if($APIParameter->GetOutputMode() eq AlchemyAPI_BaseParams::OUTPUT_MODE_XML ) {
			my $result = $xp->getNodeText('/results/status');
			if ($result ne "OK")
			{
				my $resultCode = $xp->getNodeText('/results/statusInfo');

				printf STDERR "Error making AlchemyAPI call: $resultCode\n";
				return $AlchemyAPI_Error;
			}
		}
		elsif($APIParameter->GetOutputMode() eq AlchemyAPI_BaseParams::OUTPUT_MODE_RDF ) {
			my $result = $xp->getNodeText('/rdf:RDF/rdf:Description/aapi:ResultStatus');
			if ($result ne "OK")
			{
				printf STDERR "Error making AlchemyAPI call\n";
				return $AlchemyAPI_Error;
			}
		}

		return $response->content;
	}
	else
	{
		printf STDERR "Error making AlchemyAPI call: $APICall\n";
		return $AlchemyAPI_Error;
	}
}

sub GET {
	my($self, $APICall, $APICallPrefix, $APIParameter) = @_;
	my $AlchemyAPI_Endpoint = 'http://'.$self->{_hostPrefix}.'.alchemyapi.com/calls/'.$APICallPrefix.'/'.$APICall.'?'.'apikey='.$self->{_apiKey}.$APIParameter->GetParameterString();


	$APIParameter->ResetBaseParams();

	my $req = HTTP::Request->new(GET => $AlchemyAPI_Endpoint);
	$req->content_type('application/x-www-form-urlencoded');

	my $response = $self->{_userAgent}->request($req);

	if ($response->is_success)
	{
		my $xp = XML::XPath->new(xml => $response->content);

		if($APIParameter->GetOutputMode() eq AlchemyAPI_BaseParams::OUTPUT_MODE_XML ) {
			my $result = $xp->getNodeText('/results/status');
			if ($result ne "OK")
			{
				my $resultCode = $xp->getNodeText('/results/statusInfo');

				printf STDERR "Error making AlchemyAPI call: $resultCode\n";
				return $AlchemyAPI_Error;
			}
		}
		elsif($APIParameter->GetOutputMode() eq AlchemyAPI_BaseParams::OUTPUT_MODE_RDF ) {
			my $result = $xp->getNodeText('/rdf:RDF/rdf:Description/aapi:ResultStatus');
			if ($result ne "OK")
			{
				printf STDERR "Error making AlchemyAPI call\n";
				return $AlchemyAPI_Error;
			}
		}

		return $response->content;
	}
	else
	{
		printf STDERR "Error making AlchemyAPI call: $APICall\n";
		return $AlchemyAPI_Error;
	}
}

sub URLGetAuthor {
	my($self, $url, $baseParams) = @_;
	
	if( ! defined $baseParams) {
		$baseParams = new AlchemyAPI_BaseParams();
	}

	if(ref($baseParams) ne "AlchemyAPI_BaseParams") {
		throw Error::Simple("Error: Invalid Parameter class for GetAuthor: ".ref($baseParams));
	}

	if ($self->CheckURL($url) eq $AlchemyAPI_Error)
        {
                return $AlchemyAPI_Error;
        }

	$baseParams->SetUrl($url);

	return $self->GET('URLGetAuthor', 'url', $baseParams);
}

sub HTMLGetAuthor {
	my($self, $html, $url, $baseParams) = @_;
	
	if( ! defined $baseParams) {
		$baseParams = new AlchemyAPI_BaseParams();
	}

	if(ref($baseParams) ne "AlchemyAPI_BaseParams") {
		throw Error::Simple("Error: Invalid Parameter class for GetAuthor: ".ref($baseParams));
	}

	if ($self->CheckHTML($html, $url) eq $AlchemyAPI_Error)
        {
                return $AlchemyAPI_Error;
        }

	$baseParams->SetUrl($url);
	$baseParams->SetHtml($html);

	return $self->POST('HTMLGetAuthor', 'html', $baseParams);
}

sub URLGetLanguage {
	my($self, $url, $languageParams) = @_;

	if( ! defined $languageParams ) {
		$languageParams = new AlchemyAPI_LanguageParams();
	}
	if( ref($languageParams) ne "AlchemyAPI_LanguageParams" ) {
		throw Error::Simple( "Error:  Invalid Parameter class for GetLanguage: ".ref($languageParams));
	}
	if ($self->CheckURL($url) eq $AlchemyAPI_Error)
	{
		return $AlchemyAPI_Error;
	}

	$languageParams->SetUrl($url);

	return $self->GET('URLGetLanguage', 'url', $languageParams);
}

sub HTMLGetLanguage {
	my($self, $html, $url, $languageParams) = @_;

	if( ! defined $languageParams ) {
		$languageParams = new AlchemyAPI_LanguageParams();
	}
	if( ref($languageParams) ne "AlchemyAPI_LanguageParams" ) {
		throw Error::Simple( "Error:  Invalid Parameter class for GetLanguage: ".ref($languageParams));
	}
	if ($self->CheckHTML($html, $url) eq $AlchemyAPI_Error)
	{
		return $AlchemyAPI_Error;
	}

	$languageParams->SetHtml($html);
	$languageParams->SetUrl($url);

	return $self->POST('HTMLGetLanguage', 'html', $languageParams);
}

sub TextGetLanguage{
	my($self, $text, $languageParams) = @_;

	if( ! defined $languageParams ) {
		$languageParams = new AlchemyAPI_LanguageParams();
	}
	if( ref($languageParams) ne "AlchemyAPI_LanguageParams" ) {
		throw Error::Simple( "Error:  Invalid Parameter class for GetLanguage: ".ref($languageParams));
	}
	if ($self->CheckText($text) eq $AlchemyAPI_Error)
	{
		return $AlchemyAPI_Error;
	}

	$languageParams->SetText($text);

	return $self->POST('TextGetLanguage', 'text', $languageParams);
}

sub URLGetTitle {
	my($self, $url, $baseParams) = @_;

	if( ! defined $baseParams ) {
		$baseParams = new AlchemyAPI_BaseParams();
	}
	if( ref($baseParams) ne "AlchemyAPI_BaseParams" ) {
		throw Error::Simple( "Error:  Invalid Parameter class for GetTitle: ".ref($baseParams));
	}
	if ($self->CheckURL($url) eq $AlchemyAPI_Error)
	{
		return $AlchemyAPI_Error;
	}

	$baseParams->SetUrl($url);

	return $self->GET('URLGetTitle', 'url', $baseParams);
}

sub HTMLGetTitle {
	my($self, $html, $url, $baseParams) = @_;

	if( ! defined $baseParams ) {
		$baseParams = new AlchemyAPI_BaseParams();
	}
	if( ref($baseParams) ne "AlchemyAPI_BaseParams" ) {
		throw Error::Simple( "Error:  Invalid Parameter class for GetTitle: ".ref($baseParams));
	}
	if ($self->CheckHTML($html, $url) eq $AlchemyAPI_Error)
	{
		return $AlchemyAPI_Error;
	}

	$baseParams->SetHtml($html);
	$baseParams->SetUrl($url);

	return $self->POST('HTMLGetTitle', 'html', $baseParams);
}


sub URLGetText {
	my($self, $url, $textParams) = @_;

	if( ! defined $textParams ) {
		$textParams = new AlchemyAPI_TextParams();
	}
	if( ref($textParams) ne "AlchemyAPI_TextParams" ) {
		throw Error::Simple( "Error:  Invalid Parameter class for GetText: ".ref($textParams));
	}
	if ($self->CheckURL($url) eq $AlchemyAPI_Error)
	{
		return $AlchemyAPI_Error;
	}

	$textParams->SetUrl($url);

	return $self->GET('URLGetText', 'url', $textParams);
}

sub HTMLGetText {
	my($self, $html, $url, $textParams) = @_;

	if( ! defined $textParams ) {
		$textParams = new AlchemyAPI_TextParams();
	}
	if( ref($textParams) ne "AlchemyAPI_TextParams" ) {
		throw Error::Simple( "Error:  Invalid Parameter class for GetText: ".ref($textParams));
	}
	if ($self->CheckHTML($html, $url) eq $AlchemyAPI_Error)
	{
		return $AlchemyAPI_Error;
	}

	$textParams->SetHtml($html);
	$textParams->SetUrl($url);

	return $self->POST('HTMLGetText', 'html', $textParams);
}


sub URLGetRawText {
	my($self, $url, $baseParams) = @_;

	if( ! defined $baseParams ) {
		$baseParams = new AlchemyAPI_BaseParams();
	}
	if( ref($baseParams) ne "AlchemyAPI_BaseParams" ) {
		throw Error::Simple( "Error:  Invalid Parameter class for GetRawText: ".ref($baseParams));
	}
	if ($self->CheckURL($url) eq $AlchemyAPI_Error)
	{
		return $AlchemyAPI_Error;
	}

	$baseParams->SetUrl($url);

	return $self->GET('URLGetRawText', 'url', $baseParams);
}

sub HTMLGetRawText {
	my($self, $html, $url, $baseParams) = @_;

	if( ! defined $baseParams ) {
		$baseParams = new AlchemyAPI_BaseParams();
	}
	if( ref($baseParams) ne "AlchemyAPI_BaseParams" ) {
		throw Error::Simple( "Error:  Invalid Parameter class for GetRawText: ".ref($baseParams));
	}
	if ($self->CheckHTML($html, $url) eq $AlchemyAPI_Error)
	{
		return $AlchemyAPI_Error;
	}

	$baseParams->SetHtml($html);
	$baseParams->SetUrl($url);

	return $self->POST('HTMLGetRawText', 'html', $baseParams);
}

sub URLGetFeedLinks {
	my($self, $url, $baseParams) = @_;

	if( ! defined $baseParams ) {
		$baseParams = new AlchemyAPI_BaseParams();
	}
	if( ref($baseParams) ne "AlchemyAPI_BaseParams" ) {
		throw Error::Simple( "Error:  Invalid Parameter class for GetFeedLinks: ".ref($baseParams));
	}
	if ($self->CheckURL($url) eq $AlchemyAPI_Error)
	{
		return $AlchemyAPI_Error;
	}

	$baseParams->SetUrl($url);

	return $self->GET('URLGetFeedLinks', 'url', $baseParams);
}

sub HTMLGetFeedLinks {
	my($self, $html, $url, $baseParams) = @_;

	if( ! defined $baseParams ) {
		$baseParams = new AlchemyAPI_BaseParams();
	}
	if( ref($baseParams) ne "AlchemyAPI_BaseParams" ) {
		throw Error::Simple( "Error:  Invalid Parameter class for GetFeedLinks: ".ref($baseParams));
	}
	if ($self->CheckHTML($html, $url) eq $AlchemyAPI_Error)
	{
		return $AlchemyAPI_Error;
	}

	$baseParams->SetHtml($html);
	$baseParams->SetUrl($url);

	return $self->POST('HTMLGetFeedLinks', 'html', $baseParams);
}


sub URLGetMicroformats {
	my($self, $url, $baseParams) = @_;

	if( ! defined $baseParams ) {
		$baseParams = new AlchemyAPI_BaseParams();
	}
	if( ref($baseParams) ne "AlchemyAPI_BaseParams" ) {
		throw Error::Simple( "Error:  Invalid Parameter class for GetMicroformats: ".ref($baseParams));
	}
	if ($self->CheckURL($url) eq $AlchemyAPI_Error)
	{
		return $AlchemyAPI_Error;
	}

	$baseParams->SetUrl($url);

	return $self->GET('URLGetMicroformatData', 'url', $baseParams);
}


sub HTMLGetMicroformats {
	my($self, $html, $url, $baseParams) = @_;

	if( ! defined $baseParams ) {
		$baseParams = new AlchemyAPI_BaseParams();
	}
	if( ref($baseParams) ne "AlchemyAPI_BaseParams" ) {
		throw Error::Simple( "Error:  Invalid Parameter class for GetMicroformats: ".ref($baseParams));
	}
	if ($self->CheckHTML($html, $url) eq $AlchemyAPI_Error)
	{
		return $AlchemyAPI_Error;
	}

	$baseParams->SetHtml($html);
	$baseParams->SetUrl($url);

	return $self->POST('HTMLGetMicroformatData', 'html', $baseParams);
}


sub URLGetCategory {
	my($self, $url, $categoryParams) = @_;

	if( ! defined $categoryParams ) {
		$categoryParams = new AlchemyAPI_CategoryParams();
	}
	if( ref($categoryParams) ne "AlchemyAPI_CategoryParams" ) {
		throw Error::Simple( "Error:  Invalid Parameter class for GetCategory: ".ref($categoryParams));
	}
	if ($self->CheckURL($url) eq $AlchemyAPI_Error)
	{
		return $AlchemyAPI_Error;
	}

	$categoryParams->SetUrl($url);

	return $self->GET('URLGetCategory', 'url', $categoryParams);
}

sub HTMLGetCategory {
	my($self, $html, $url, $categoryParams) = @_;

	if( ! defined $categoryParams ) {
		$categoryParams = new AlchemyAPI_CategoryParams();
	}
	if( ref($categoryParams) ne "AlchemyAPI_CategoryParams" ) {
		throw Error::Simple( "Error:  Invalid Parameter class for GetCategory: ".ref($categoryParams));
	}
	if ($self->CheckHTML($html, $url) eq $AlchemyAPI_Error)
	{
		return $AlchemyAPI_Error;
	}

	$categoryParams->SetUrl($url);
	$categoryParams->SetHtml($html);

	return $self->POST('HTMLGetCategory', 'html', $categoryParams);
}

sub TextGetCategory {
	my($self, $text, $categoryParams) = @_;

	if( ! defined $categoryParams ) {
		$categoryParams = new AlchemyAPI_CategoryParams();
	}
	if( ref($categoryParams) ne "AlchemyAPI_CategoryParams" ) {
		throw Error::Simple( "Error:  Invalid Parameter class for GetCategory: ".ref($categoryParams));
	}
	if ($self->CheckText($text) eq $AlchemyAPI_Error)
	{
		return $AlchemyAPI_Error;
	}

	$categoryParams->SetText($text);

	return $self->POST('TextGetCategory', 'text', $categoryParams);
}


sub URLGetRankedConcepts {
	my($self, $url, $conceptParams) = @_;
	
	if( ! defined $conceptParams ) {
		$conceptParams = new AlchemyAPI_ConceptParams();
	}
	if( ref($conceptParams) ne "AlchemyAPI_ConceptParams" ) {
		throw Error::Simple( "Error:  Invalid Parameter class for GetRankedConcepts: ".ref($conceptParams));
	}	
	if ($self->CheckURL($url) eq $AlchemyAPI_Error)
	{
		return $AlchemyAPI_Error;
	}
	
	$conceptParams->SetUrl($url);
	
	return $self->GET('URLGetRankedConcepts', 'url', $conceptParams);
}

sub HTMLGetRankedConcepts {
	my($self, $html, $url, $conceptParams) = @_;

	if( ! defined $conceptParams ) {
		$conceptParams = new AlchemyAPI_ConceptParams();
	}
	if( ref($conceptParams) ne "AlchemyAPI_ConceptParams" ) {
		throw Error::Simple( "Error:  Invalid Parameter class for GetRankedConcepts: ".ref($conceptParams));
	}
	if ($self->CheckHTML($html, $url) eq $AlchemyAPI_Error)
	{
		return $AlchemyAPI_Error;
	}

	$conceptParams->SetHtml($html);
	$conceptParams->SetUrl($url);

	return $self->POST('HTMLGetRankedConcepts', 'html', $conceptParams);
}

sub TextGetRankedConcepts {
	my($self, $text, $conceptParams) = @_;

	if( ! defined $conceptParams ) {
		$conceptParams = new AlchemyAPI_ConceptParams();
	}
	if( ref($conceptParams) ne "AlchemyAPI_ConceptParams" ) {
		throw Error::Simple( "Error:  Invalid Parameter class for GetRankedConcepts: ".ref($conceptParams));
	}
	if ($self->CheckText($text) eq $AlchemyAPI_Error)
	{
		return $AlchemyAPI_Error;
	}

	$conceptParams->SetText($text);

	return $self->POST('TextGetRankedConcepts', 'text', $conceptParams);
}


sub URLGetRankedKeywords {
	my($self, $url, $keywordParams) = @_;
	
	if( ! defined $keywordParams ) {
		$keywordParams = new AlchemyAPI_KeywordParams();
	}
	if( ref($keywordParams) ne "AlchemyAPI_KeywordParams" ) {
		throw Error::Simple( "Error:  Invalid Parameter class for GetRankedKeywords: ".ref($keywordParams));
	}	
	if ($self->CheckURL($url) eq $AlchemyAPI_Error)
	{
		return $AlchemyAPI_Error;
	}
	
	$keywordParams->SetUrl($url);
	
	return $self->GET('URLGetRankedKeywords', 'url', $keywordParams);
}


sub HTMLGetRankedKeywords {
	my($self, $html, $url, $keywordParams) = @_;

	if( ! defined $keywordParams ) {
		$keywordParams = new AlchemyAPI_KeywordParams();
	}
	if( ref($keywordParams) ne "AlchemyAPI_KeywordParams" ) {
		throw Error::Simple( "Error:  Invalid Parameter class for GetRankedKeywords: ".ref($keywordParams));
	}
	if ($self->CheckHTML($html, $url) eq $AlchemyAPI_Error)
	{
		return $AlchemyAPI_Error;
	}

	$keywordParams->SetHtml($html);
	$keywordParams->SetUrl($url);

	return $self->POST('HTMLGetRankedKeywords', 'html', $keywordParams);
}

sub TextGetRankedKeywords {
	my($self, $text, $keywordParams) = @_;

	if( ! defined $keywordParams ) {
		$keywordParams = new AlchemyAPI_KeywordParams();
	}
	if( ref($keywordParams) ne "AlchemyAPI_KeywordParams" ) {
		throw Error::Simple( "Error:  Invalid Parameter class for GetRankedKeywords: ".ref($keywordParams));
	}
	if ($self->CheckText($text) eq $AlchemyAPI_Error)
	{
		return $AlchemyAPI_Error;
	}

	$keywordParams->SetText($text);

	return $self->POST('TextGetRankedKeywords', 'text', $keywordParams);
}


sub URLGetRankedNamedEntities {
	my($self, $url, $entityParams) = @_;

	if( ! defined $entityParams ) {
		$entityParams = new AlchemyAPI_EntityParams();
	}
	if( ref($entityParams) ne "AlchemyAPI_EntityParams" ) {
		throw Error::Simple( "Error:  Invalid Parameter class for GetEntity: ".ref($entityParams));
	}
	if ($self->CheckURL($url) eq $AlchemyAPI_Error)
	{
		return $AlchemyAPI_Error;
	}

	$entityParams->SetUrl($url);

	return $self->GET('URLGetRankedNamedEntities', 'url', $entityParams);
}

sub HTMLGetRankedNamedEntities {
	my($self, $html, $url, $entityParams) = @_;

	if( ! defined $entityParams ) {
		$entityParams = new AlchemyAPI_EntityParams();
	}
	if( ref($entityParams) ne "AlchemyAPI_EntityParams" ) {
		throw Error::Simple( "Error:  Invalid Parameter class for GetEntity: ".ref($entityParams));
	}
	if ($self->CheckHTML($html, $url) eq $AlchemyAPI_Error)
	{
		return $AlchemyAPI_Error;
	}

	$entityParams->SetHtml($html);
	$entityParams->SetUrl($url);

	return $self->POST('HTMLGetRankedNamedEntities', 'html', $entityParams);
}

sub TextGetRankedNamedEntities {
	my($self, $text, $entityParams) = @_;

	if( ! defined $entityParams ) {
		$entityParams = new AlchemyAPI_EntityParams();
	}
	if( ref($entityParams) ne "AlchemyAPI_EntityParams" ) {
		throw Error::Simple( "Error:  Invalid Parameter class for GetEntity: ".ref($entityParams));
	}
	if ($self->CheckText($text) eq $AlchemyAPI_Error)
	{
		return $AlchemyAPI_Error;
	}

	$entityParams->SetText($text);

	return $self->POST('TextGetRankedNamedEntities', 'text', $entityParams);
}


sub URLGetConstraintQuery {
	my($self, $url, $query, $cqParams) = @_;

	if( ! defined $cqParams ) {
		$cqParams = new AlchemyAPI_ConstraintQueryParams();
	}
	if( ref($cqParams) ne "AlchemyAPI_ConstraintQueryParams" ) 
	{
		throw Error::Simple( "Error:  Invalid Parameter class for GetConstraintQuery: ".ref($cqParams));
	}
	if ($self->CheckURL($url) eq $AlchemyAPI_Error)
	{
		return $AlchemyAPI_Error;
	}

	if (length $query < 2)
        {
                printf STDERR "Too short Constraint Query.\n";
                return $AlchemyAPI_Error;
        }

	$cqParams->SetUrl($url);
	$cqParams->SetCQuery($query);
	return $self->GET('URLGetConstraintQuery', 'url', $cqParams);
}


sub HTMLGetConstraintQuery {
	my($self, $html, $url, $query, $cqParams) = @_;

	if( ! defined $cqParams ) {
		$cqParams = new AlchemyAPI_ConstraintQueryParams();
	}
	if( ref($cqParams) ne "AlchemyAPI_ConstraintQueryParams" ) {
		throw Error::Simple( "Error:  Invalid Parameter class for GetConstraintQuery: ".ref($cqParams));
	}
	if (length $query < 2)
        {
                printf STDERR "Too short Constraint Query.\n";
                return $AlchemyAPI_Error;
        }

	$cqParams->SetHtml($html);
	$cqParams->SetUrl($url);
	$cqParams->SetCQuery($query);

	return $self->POST('HTMLGetConstraintQuery', 'html', $cqParams);
}

sub URLGetTextSentiment {
	my($self, $url, $baseParams) = @_;

	if( ! defined $baseParams ) {
		$baseParams = new AlchemyAPI_BaseParams();
	}
	if( ref($baseParams) ne "AlchemyAPI_BaseParams" ) {
		throw Error::Simple( "Error:  Invalid Parameter class for GetTextSentiment: ".ref($baseParams));
	}
	if ($self->CheckURL($url) eq $AlchemyAPI_Error)
	{
		return $AlchemyAPI_Error;
	}

	$baseParams->SetUrl($url);

	return $self->GET('URLGetTextSentiment', 'url', $baseParams);
}

sub HTMLGetTextSentiment {
	my($self, $html, $url, $baseParams) = @_;

	if( ! defined $baseParams ) {
		$baseParams = new AlchemyAPI_BaseParams();
	}
	if( ref($baseParams) ne "AlchemyAPI_BaseParams" ) {
		throw Error::Simple( "Error:  Invalid Parameter class for GetTextSentiment: ".ref($baseParams));
	}
	if ($self->CheckHTML($html, $url) eq $AlchemyAPI_Error)
	{
		return $AlchemyAPI_Error;
	}

	$baseParams->SetUrl($url);
	$baseParams->SetHtml($html);

	return $self->POST('HTMLGetTextSentiment', 'html', $baseParams);
}

sub TextGetTextSentiment {
	my($self, $text, $baseParams) = @_;

	if( ! defined $baseParams ) {
		$baseParams = new AlchemyAPI_BaseParams();
	}
	if( ref($baseParams) ne "AlchemyAPI_BaseParams" ) {
		throw Error::Simple( "Error:  Invalid Parameter class for GetTextSentiment: ".ref($baseParams));
	}
	if ($self->CheckText($text) eq $AlchemyAPI_Error)
	{
		return $AlchemyAPI_Error;
	}

	$baseParams->SetText($text);

	return $self->POST('TextGetTextSentiment', 'text', $baseParams);
}

sub TextGetTargetedSentiment {
	my($self, $text, $target, $targetedSentimentParams) = @_;

	if( ! defined $targetedSentimentParams) {
		$targetedSentimentParams = new AlchemyAPI_TargetedSentimentParams();
	}
	
	if( ref($targetedSentimentParams) ne "AlchemyAPI_TargetedSentimentParams" ) {
	   throw Error::Simple( "Error:  Invalid Parameter class for GetTargetedSentiment: ".ref($targetedSentimentParams));
        }
        if ($self->CheckText($text) eq $AlchemyAPI_Error)
        {
                return $AlchemyAPI_Error;
        }

        $targetedSentimentParams->SetText($text); 
        $targetedSentimentParams->SetTarget($target);

	return $self->POST('TextGetTargetedSentiment', 'text', $targetedSentimentParams);
}
		
sub URLGetTargetedSentiment {
	my($self, $url, $target, $targetedSentimentParams) = @_;

	if( ! defined $targetedSentimentParams) {
		$targetedSentimentParams = new AlchemyAPI_TargetedSentimentParams();
	}
	
	if( ref($targetedSentimentParams) ne "AlchemyAPI_TargetedSentimentParams" ) {
	   throw Error::Simple( "Error:  Invalid Parameter class for GetTargetedSentiment: ".ref($targetedSentimentParams));
        }
        if ($self->CheckURL($url) eq $AlchemyAPI_Error)
        {
                return $AlchemyAPI_Error;
        }

        $targetedSentimentParams->SetUrl($url); 
        $targetedSentimentParams->SetTarget($target);

	return $self->GET('URLGetTargetedSentiment', 'url', $targetedSentimentParams);
}

sub HTMLGetTargetedSentiment {
	my($self, $html, $url, $target, $targetedSentimentParams) = @_;

	if( ! defined $targetedSentimentParams) {
		$targetedSentimentParams = new AlchemyAPI_TargetedSentimentParams();
	}
	
	if( ref($targetedSentimentParams) ne "AlchemyAPI_TargetedSentimentParams" ) {
	   throw Error::Simple( "Error:  Invalid Parameter class for GetTargetedSentiment: ".ref($targetedSentimentParams));
        }
        if ($self->CheckHTML($html, $url) eq $AlchemyAPI_Error)
        {
                return $AlchemyAPI_Error;
        }

        $targetedSentimentParams->SetHtml($html); 
        $targetedSentimentParams->SetUrl($url); 
        $targetedSentimentParams->SetTarget($target);

	return $self->POST('HTMLGetTargetedSentiment', 'html', $targetedSentimentParams);
}

sub URLGetRelations {
	my($self, $url, $relationParams) = @_;

	if( ! defined $relationParams ) {
		$relationParams = new AlchemyAPI_RelationParams();
	}
	if( ref($relationParams) ne "AlchemyAPI_RelationParams" ) {
		throw Error::Simple( "Error:  Invalid Parameter class for GetRelations: ".ref($relationParams));
	}
	if ($self->CheckURL($url) eq $AlchemyAPI_Error)
	{
		return $AlchemyAPI_Error;
	}

	$relationParams->SetUrl($url);

	return $self->GET('URLGetRelations', 'url', $relationParams);
}

sub HTMLGetRelations {
	my($self, $html, $url, $relationParams) = @_;

	if( ! defined $relationParams ) {
		$relationParams = new AlchemyAPI_RelationParams();
	}
	if( ref($relationParams) ne "AlchemyAPI_RelationParams" ) {
		throw Error::Simple( "Error:  Invalid Parameter class for GetRelations: ".ref($relationParams));
	}
	if ($self->CheckHTML($html, $url) eq $AlchemyAPI_Error)
	{
		return $AlchemyAPI_Error;
	}

	$relationParams->SetUrl($url);
	$relationParams->SetHtml($html);

	return $self->POST('HTMLGetRelations', 'html', $relationParams);
}

sub TextGetRelations {
	my($self, $text, $relationParams) = @_;

	if( ! defined $relationParams ) {
		$relationParams = new AlchemyAPI_RelationParams();
	}
	if( ref($relationParams) ne "AlchemyAPI_RelationParams" ) {
		throw Error::Simple( "Error:  Invalid Parameter class for GetRelations: ".ref($relationParams));
	}
	if ($self->CheckText($text) eq $AlchemyAPI_Error)
	{
		return $AlchemyAPI_Error;
	}

	$relationParams->SetText($text);

	return $self->POST('TextGetRelations', 'text', $relationParams);
}

sub URLGetRankedTaxonomy 
{
    my($self, $url, $taxonomyParams) = @_;

    if (! defined $taxonomyParams)
    {
        $taxonomyParams = new AlchemyAPI_TaxonomyParams();
    }

    if ( ref($taxonomyParams) ne "AlchemyAPI_TaxonomyParams" )
    {
        throw Error::Simple( "Error: Invalid parameter class for GetRankedTaxonomy: ".ref($taxonomyParams));
    }

    if ($self->CheckURL($url) eq $AlchemyAPI_Error)
    {
        return $AlchemyAPI_Error;
    }

    $taxonomyParams->SetUrl($url);

    return $self->GET('URLGetRankedTaxonomy', 'url', $taxonomyParams);
}

sub TextGetRankedTaxonomy 
{
    my($self, $text, $taxonomyParams) = @_;
    
    if (! defined $taxonomyParams)
    {
        $taxonomyParams = new AlchemyAPI_TaxonomyParams();
    }

    if (ref($taxonomyParams) ne "AlchemyAPI_TaxonomyParams")
    {
        throw Error::Simple("Error: Invalid parameter class for GetRankedTaxonomy: ".ref($taxonomyParams));
    }

    if ($self->CheckText($text) eq $AlchemyAPI_Error)
    {
        return $AlchemyAPI_Error;
    }

    $taxonomyParams->SetText($text);

    return $self->POST('TextGetRankedTaxonomy', 'text', $taxonomyParams);
}

sub HTMLGetRankedTaxonomy 
{
	my($self, $html, $url, $taxonomyParams) = @_;

	if( ! defined $taxonomyParams ) {
		$taxonomyParams = new AlchemyAPI_TaxonomyParams();
	}
	if( ref($taxonomyParams) ne "AlchemyAPI_TaxonomyParams" ) {
		throw Error::Simple( "Error:  Invalid Parameter class for GetRankedTaxonomy: ".ref($taxonomyParams));
	}
	if ($self->CheckHTML($html, $url) eq $AlchemyAPI_Error)
	{
		return $AlchemyAPI_Error;
	}

	$taxonomyParams->SetUrl($url);
	$taxonomyParams->SetHtml($html);

	return $self->POST('HTMLGetRankedTaxonomy', 'html', $taxonomyParams);
}

sub HTMLGetImage
{
	my($self, $html, $url, $imageParams) = @_;

	if( ! defined $imageParams ) {
		$imageParams = new AlchemyAPI_ImageParams();
	}
	if( ref($imageParams) ne "AlchemyAPI_ImageParams" ) {
		throw Error::Simple( "Error:  Invalid Parameter class for GetImage: ".ref($imageParams));
	}
	if ($self->CheckHTML($html, $url) eq $AlchemyAPI_Error)
	{
		return $AlchemyAPI_Error;
	}

	$imageParams->SetUrl($url);
	$imageParams->SetHtml($html);

	return $self->POST('HTMLGetImage', 'html', $imageParams);
}

sub URLGetImage
{
    my($self, $url, $imageParams) = @_;

    if (! defined $imageParams)
    {
        $imageParams = new AlchemyAPI_ImageParams();
    }

    if ( ref($imageParams) ne "AlchemyAPI_ImageParams" )
    {
        throw Error::Simple( "Error: Invalid parameter class for GetImage: ".ref($imageParams));
    }

    if ($self->CheckURL($url) eq $AlchemyAPI_Error)
    {
        return $AlchemyAPI_Error;
    }

    $imageParams->SetUrl($url);

    return $self->GET('URLGetImage', 'url', $imageParams);

}

sub URLGetCombinedData {
    my($self, $url, $combinedParams) = @_;
    
    if (! defined $combinedParams) 
    {
        $combinedParams = new AlchemyAPI_CombinedParams();
    }

    if ( ref($combinedParams) ne "AlchemyAPI_CombinedParams") 
    {
        throw Error::Simple( "Error: Invalid parameter class for GetCombinedData: ".ref($combinedParams));
    }

    if ($self->CheckURL($url) eq $AlchemyAPI_Error)
    {
        return $AlchemyAPI_Error;
    }

    $combinedParams->SetUrl($url);

    return $self->GET('URLGetCombinedData', 'url', $combinedParams);

}
sub TextGetCombinedData 
{
    my($self, $text, $combinedParams) = @_;
    
    if (! defined $combinedParams)
    {
        $combinedParams = new AlchemyAPI_CombinedParams();
    }

    if (ref($combinedParams) ne "AlchemyAPI_CombinedParams")
    {
        throw Error::Simple("Error: Invalid parameter class for GetCombinedData: ".ref($combinedParams));
    }

    if ($self->CheckText($text) eq $AlchemyAPI_Error)
    {
        return $AlchemyAPI_Error;
    }

    $combinedParams->SetText($text);

    return $self->POST('TextGetCombinedData', 'text', $combinedParams);
}

# Autoload methods go after =cut, and are processed by the autosplit program.

1;
__END__

# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

AlchemyAPI - Perl extension for the AlchemyAPI Contextual Analysis API.

=head1 SYNOPSIS

use AlchemyAPI;

# Create the AlchemyAPI object.
my $alchemyObj = new AlchemyAPI();

# Load the API key from disk.
if ($alchemyObj->LoadKey("api_key.txt") eq "error")
{
	die "Error loading API key.  Edit api_key.txt and insert your API key.";
}


my $result = '';


# Get a ranked list of named entities for a text string.
$result = $alchemyObj->TextGetRankedNamedEntities("Hello there, my name is Bob Jones. I am married to Lisa Jones.  Bob Jones is indeed my name!");
if ($result ne "error")
{
	printf $result;
}


# Get a list of topic keywords for a text string.
$result = $alchemyObj->TextGetRankedKeywords("Microsoft released a new product today.  Microsoft wants you to try it out.  Download it here.");
if ($result ne "error")
{
	printf $result;
}


# Detect the language for a text string (requires at least 100 bytes of text).
$result = $alchemyObj->TextGetLanguage("Microsoft released a new product today.  Microsoft wants you to try it out.  Download it here.");
if ($result ne "error")
{
	printf $result;
}


# Categorize a text string.
$result = $alchemyObj->TextGetCategory("Latest on the War in Iraq.");
if ($result ne "error")
{
	printf $result;
}


# Get a ranked list of named entities for a web URL.
$result = $alchemyObj->URLGetRankedNamedEntities("http://www.gigaom.com/");
if ($result ne "error")
{
	printf $result;
}


# Get a list of topic keywords for a web URL.
$result = $alchemyObj->URLGetRankedKeywords("http://www.gigaom.com/");
if ($result ne "error")
{
	printf $result;
}


# Detect the language used within a web URL.
$result = $alchemyObj->URLGetLanguage("http://news.google.fr");
if ($result ne "error")
{
	printf $result;
}


# Categorize a web URL by topic.
$result = $alchemyObj->URLGetCategory("http://www.gigaom.com/");
if ($result ne "error")
{
	printf $result;
}


# Get the text for a web URL (removing ads, navigation links, etc.)
$result = $alchemyObj->URLGetText("http://www.gigaom.com/");
if ($result ne "error")
{
	printf $result;
}


# Get the raw text for a web URL (including ads, navigation links, etc.)
$result = $alchemyObj->URLGetRawText("http://www.gigaom.com/");
if ($result ne "error")
{
	printf $result;
}


# Get the title for a web URL.
$result = $alchemyObj->URLGetTitle("http://www.gigaom.com/");
if ($result ne "error")
{
	printf $result;
}


# Extract RSS / ATOM feed links from a web URL.
$result = $alchemyObj->URLGetFeedLinks("http://www.gigaom.com/");
if ($result ne "error")
{
	printf $result;
}


# Extract Microformats data from a web URL.
$result = $alchemyObj->URLGetMicroformats("http://microformats.org/wiki/hcard");
if ($result ne "error")
{
	printf $result;
}


# Extract first link from an URL.
$result = $alchemyObj->URLGetConstraintQuery("http://microformats.org/wiki/hcar", "1st link");
if ($result ne "error")
{
        printf $result;
}


# Load an example HTML input file to analyze.
my $HTMLFile;
my $HTMLContent;
open($HTMLFile, "data/example.html");
sysread($HTMLFile, $HTMLContent, -s($HTMLFile));
close($HTMLFile);


# Get a ranked list of named entities for a HTML document.
$result = $alchemyObj->HTMLGetRankedNamedEntities($HTMLContent, "http://www.test.com/");
if ($result ne "error")
{
	printf $result;
}


# Get a list of topic keywords for a HTML document.
$result = $alchemyObj->HTMLGetRankedKeywords($HTMLContent, "http://www.test.com/");
if ($result ne "error")
{
	printf $result;
}


# Detect the language used within a HTML document.
$result = $alchemyObj->HTMLGetLanguage($HTMLContent, "http://www.test.com/");
if ($result ne "error")
{
	printf $result;
}


# Categorize a HTML document by topic.
$result = $alchemyObj->HTMLGetCategory($HTMLContent, "http://www.test.com/");
if ($result ne "error")
{
	printf $result;
}


# Get the text for a HTML document (removing ads, navigation links, etc.)
$result = $alchemyObj->HTMLGetText($HTMLContent, "http://www.test.com/");
if ($result ne "error")
{
	printf $result;
}


# Get the raw text for a HTML document (including ads, navigation links, etc.)
$result = $alchemyObj->HTMLGetRawText($HTMLContent, "http://www.test.com/");
if ($result ne "error")
{
	printf $result;
}


# Get the title for a HTML document.
$result = $alchemyObj->HTMLGetTitle($HTMLContent, "http://www.test.com/");
if ($result ne "error")
{
	printf $result;
}


# Extract RSS / ATOM feed links from a HTML document.
$result = $alchemyObj->HTMLGetFeedLinks($HTMLContent, "http://www.test.com/");
if ($result ne "error")
{
	printf $result;
}


# Extract Microformats data from a HTML document.
$result = $alchemyObj->HTMLGetMicroformats($HTMLContent, "http://www.test.com/");
if ($result ne "error")
{
	printf $result;
}


# Extract first link from a HTML.
$result = $alchemyObj->HTMLGetConstraintQuery($HTMLContent, "http://www.test.com/", "1st link");
if ($result ne "error")
{
        printf $result;
}


# See the code samples in the 'example' directory for usage information on keyword extraction, language ID, and more.

=head1 DESCRIPTION

This is the Perl implementation of the AlchemyAPI SDK.

=head2 EXPORT

None by default.

=head1 SEE ALSO

For more information on the AlchemyAPI, please visit http://www.alchemyapi.com/api/

=head1 AUTHOR

Orchestr8, <questions@alchemyapi.com>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2009-2010 Orchestr8, LLC.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.0 or,
at your option, any later version of Perl 5 you may have available.


=cut
