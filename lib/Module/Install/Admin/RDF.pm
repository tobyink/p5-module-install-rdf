package Module::Install::Admin::RDF;

use 5.008;
use base qw(Module::Install::Base);
use strict;

use RDF::Trine qw[];
use Scalar::Util qw[];
use URI::file qw[];

our $VERSION = '0.002';

my $Model = {};

sub rdf_metadata
{
	my ($self) = @_;
	
	my $addr = Scalar::Util::refaddr($self->_top);
	return $Model->{$addr} if defined $Model->{$addr};
	my $model = $Model->{$addr} = RDF::Trine::Model->new;
	
	my $turtle = RDF::Trine::Parser->new('Turtle');
	while (<meta/*.{ttl,turtle,nt}>)
	{
		my $iri = URI::file->new_abs($_);
		$turtle->parse_file_into_model("$iri", $_, $model);
	}

	my $rdfxml = RDF::Trine::Parser->new('RDFXML');
	while (<meta/*.{rdf,rdfxml,rdfx}>)
	{
		my $iri = URI::file->new_abs($_);
		$rdfxml->parse_file_into_model("$iri", $_, $model);
	}
	
	return $model;
}

1;
