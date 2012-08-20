package MyBB::Controller::admin;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

MyBB::Controller::admin - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
    if($c->session->{'role'} eq 'Admin')
    {
        $c->stash->{template} = 'admin.tt';
    }
    else
    {
        $c->stash->{template} = 'notHasPer.tt';
    }
}


=head1 AUTHOR

root

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
