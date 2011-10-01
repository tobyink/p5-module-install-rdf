package Module::Install::RDF;

use 5.008;
use base qw(Module::Install::Base);
use strict;

our $VERSION = '0.001';
our $AUTHOR_ONLY = 1;

sub rdf_metadata
{
	my $self = shift;
	$self->admin->rdf_metadata(@_) if $self->is_admin;
}

1;

__END__
=head1 NAME

Module::Install::RDF - advanced metadata for your distribution

=head1 SYNOPSIS

In Makefile.PL:

  rdf_metadata;

=head1 DESCRIPTION

This module doesn't really do much on its own, but is a pre-requisite for 
L<Module::Install::DOAP>.

Specifically, it reads all the RDF it can find in the distribution's 'meta'
directory and exposes it for other modules to make use of.

=head1 BUGS

Please report any bugs to L<http://rt.cpan.org/>.

=head1 SEE ALSO

L<Module::Install>,
L<Module::Install::DOAP>,
L<Module::Install::DOAPChangeSets> .

L<http://www.perlrdf.org/>.

=head1 AUTHOR

Toby Inkster E<lt>tobyink@cpan.orgE<gt>.

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2011 by Toby Inkster

This library is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut
