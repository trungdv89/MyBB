package MyBB::Controller::EditTopic;
use Moose;
use namespace::autoclean;
use HTML::Entities;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

MyBB::Controller::EditTopic - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

sub EditTopic :Path :Args(0) {
    my ( $self, $c ) = @_;
    if($c->session->{'role'} eq 'Admin')
    {
        if($c->session->{'user'})
        {
            $c->stash->{user} = $c->session->{'user'};
            $c->stash->{lastVisit} = $c->session->{'lastVisit'};   
        }
        my $id = $c->req->params->{id};
        if(!$id) {$c->stash->{err} = 'Incorrect Id!'; return}   
        my $topic = $c->model('DB::Topic')->find({id => $id});
        if(!$topic) {$c->stash->{err} = 'Can not find required topic!'; return}
        $c->stash->{template} = 'createTopic.tt';
        $c->stash->{edit} = 1;
        $c->stash->{id} = $c->req->params->{id};
        $c->stash->{title} = $topic->title;
        $c->stash->{des} = $topic->description;
        $c->stash->{position} = $c->req->params->{position};
    }
    else
    {
        $c->res->body('You do not have the permission');
    }
}

sub save :Local {
    my ($self, $c) = @_;
    if($c->session->{'role'} eq 'Admin')
    {
        my $title = encode_entities($c->req->params->{title});
        my $des = encode_entities($c->req->params->{description});
        my $id = $c->req->params->{id};
        my $position = $c->req->params->{position};
        if(!$id) {$c->stash->{err} = 'Incorrect id!'; return}
        my $topic = $c->model('DB::Topic')->find({id => $id});
        if(!$topic) {$c->stash->{err} = 'Can not find required topic!'; return}
        $topic->title($title);
        $topic->description($des);
        $topic->update();
        $c->res->redirect('/#'.$position);
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
