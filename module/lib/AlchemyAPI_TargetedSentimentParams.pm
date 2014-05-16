package AlchemyAPI_TargetedSentimentParams;


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




sub new() {
	my $class = shift;
	my($self) = AlchemyAPI_BaseParams->new(@_);
	$self = {
		_showSourceText => undef,
		_target => undef,
		_outputMode => AlchemyAPI_BaseParams::OUTPUT_MODE_XML
	};
	
	bless $self, $class;


	return $self;
}


sub SetTarget {
	my($self, $target) = @_;
	$self->{_target} = $target;
}

sub GetTarget {
	my($self) = @_;
	return $self->{_target};
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

sub GetShowSourceText{
	my($self) = @_;
	return $self->{_showSourceText};
}



sub GetParameterString {
	my($self) = @_;
	my $retString = $self->SUPER::GetParameterString();
	if( defined $self->{_showSourceText} ) {
		$retString .= "&showSourceText=".$self->{_showSourceText};
	}
	if( defined $self->{_target} ) {
		$retString .= "&target=".$self->{_target};
	}
	
	return $retString;
}

1;
__END__
