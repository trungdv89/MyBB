package MyBB::Controller::CreateTopic;
use Moose;
use namespace::autoclean;
use HTML::Entities;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

MyBB::Controller::CreateTopic - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub CreateTopic :Path :Args(0) {
    my ( $self, $c ) = @_;
    if($c->session->{'role'} eq 'Admin')
    {
        if($c->session->{'user'})
        {
            $c->stash->{user} = $c->session->{'user'};
            $c->stash->{lastVisit} = $c->session->{'lastVisit'};   
        }
        $c->stash->{template} = 'createTopic.tt';
        $c->stash->{id} = $c->session->{'userId'};
    }
    else
    {
        $c->res->body('You do not have the permission');
    }
}

sub create :Local {
    my ($self, $c) = @_;
    if($c->session->{'role'} eq 'Admin')
    {
        my $title = encode_entities($c->req->params->{title});
        my $des = encode_entities($c->req->params->{description});
        my $topic_set = $c->model('DB::Topic');
        my $now = DateTime->now(time_zone=>'local');
        $topic_set->create({
            title => $title,
            description => $des,
            createdby => $c->session->{'userId'},
            createddate => $now->datetime()
            });
        $c->res->redirect('/');
    }
    else
    {
        $c->res->body('You do not have the permission');
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
