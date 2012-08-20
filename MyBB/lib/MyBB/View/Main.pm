package MyBB::View::Main;
use Moose;
use namespace::autoclean;

extends 'Catalyst::View::TT';

__PACKAGE__->config(
     # any TT configuration items go here
        TEMPLATE_EXTENSION => '.tt',
        ENCODING     => 'utf-8',
        render_die => 1, # Default for new apps, see render method docs
);

=head1 NAME

MyBB::View::Main - TT View for MyBB

=head1 DESCRIPTION

TT View for MyBB.

=head1 SEE ALSO

L<MyBB>

=head1 AUTHOR

Trung Dong,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
