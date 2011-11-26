package Module::Install::Admin::RDF;

use 5.008;
use parent qw(Module::Install::Base);
use strict;

use Object::ID;
use RDF::Trine qw[];
use URI::file qw[];

our $VERSION = '0.003';

my $Model = {};

sub rdf_metadata
{
	my ($self) = @_;
	
	my $addr = object_id($self->_top);
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

sub rdf_project_uri
{
	my ($self) = @_;
	my $model = $self->rdf_metadata;
	
	my @candidates = $model->subjects(
		RDF::Trine::iri('http://www.w3.org/1999/02/22-rdf-syntax-ns#type'),
		RDF::Trine::iri('http://usefulinc.com/ns/doap#Project'),
		);
	return $candidates[0] if scalar @candidates == 1;
	
	my %counts = map {
		$_ => $model->count_statements($_, undef, undef);
		} @candidates;	
	my @best = sort { $counts{$b} <=> $counts{$a} } @candidates;
	return $best[0] if @best;
	
	return undef;
}

1;
