package MyBB::Controller::CreateThread;
use Moose;
use namespace::autoclean;
use HTML::Entities;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

MyBB::Controller::CreateThread - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub CreateThread :Path :Args(0) {
    my ( $self, $c ) = @_;
    if($c->session->{'role'})
    {
        if($c->session->{'user'})
        {
            $c->stash->{user} = $c->session->{'user'};
            $c->stash->{lastVisit} = $c->session->{'lastVisit'};   
        }
        $c->stash->{template} = 'createThread.tt';
        $c->stash->{id} = $c->session->{'userId'};
    }
    else
    {
        $c->res->body('You do not have the permission');
    }
}

sub add :Local {
    my ($self, $c) = @_;
    if($c->session->{'role'})
    {
        my $title = encode_entities($c->req->params->{title});
        my $content = encode_entities($c->req->params->{content});
        my $thread_set = $c->model('DB::Thread');
        my $now = DateTime->now(time_zone=>'local');
        my $topicId = $c->session->{topicId};
        my $newThread = $thread_set->create({
            title => $title,
            createdby => $c->session->{'userId'},
            createddate => $now->datetime(),
            topic => $topicId
            });
        my $newPost = $c->model('DB::Post')->create({
            content => $content,
            createdby => $c->session->{'userId'},
            createddate => $now->datetime(),
            thread => $newThread->id,
            ordernum => 1,
            lastupdate => undef
            });
        $newThread->lastestpost($newPost->id);
        $newThread->update();
        my $topic =  $c->model('DB::Topic')->find({id => $topicId});
        $topic->lastestthread($newThread->id);
        $topic->update();  
        $c->res->redirect('/showtopic?id='.$topicId);
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
