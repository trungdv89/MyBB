package MyBB::Controller::register;
use Moose;
use namespace::autoclean;
use DateTime;
use HTML::Entities;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

MyBB::Controller::register - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub register : Path: Args(0) {
    my ( $self, $c ) = @_;
    $c->stash->{template} = 'register.tt';
   
    if(lc $c->req->method eq 'post') {
        my $params = $c->req->params;
        ## Retrieve the users_rs stashed by the base action:
        my $users_rs = $c->model('DB::User');
        ## Create the user:
        my $now = DateTime->now(time_zone=>'local');
        my $salt = join '', ('.', '/', 0..9, 'A'..'Z', 'a'..'z')[rand 64, rand 64];
        my $encryptedPass = crypt($params->{password}, $salt);
        my $user = $users_rs->find({name => encode_entities($params->{username})});
        if($user)
        {
            $c->stash->{err} = 'The name has been used! Type another name!';
            $c->stash->{template} = 'register.tt';
        }
        else
        {
            my $newuser = $users_rs->create({
                name => encode_entities($params->{username}),
                email    => $params->{email},
                password => $encryptedPass,
                createddate => $now->datetime()
                });
            $c->stash->{template} = 'redirect.tt'; 
        }
    }
}


=head1 AUTHOR

Trung Dong,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
