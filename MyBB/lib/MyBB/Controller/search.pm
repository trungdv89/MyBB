package MyBB::Controller::search;
use Moose;
use namespace::autoclean;
use HTML::Entities;
use utf8;
use Encode qw(encode_utf8 decode_utf8 PERLQQ XMLCREF);

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

MyBB::Controller::search - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
    my $keyword = encode_utf8($c->req->params->{'keyword'});
    if(!$c->req->params->{'id'}) {$c->res->redirect("/search?id=$keyword&page=1")};
    $keyword = $c->req->params->{'id'};
    #my $encoding_name = Encode::Detect::Detector::detect($keyword);
    $keyword = decode_utf8($keyword);#decode($encoding_name, $keyword);
    my $encodeKey = encode_entities($keyword);
    my $page = $c->req->params->{'page'}||1;
    $c->stash->{template} = 'search.tt';
    my $numPerPage = 5;
    my $numPage = 1;
    my $allResults = $c->model('DB::Post')->search_like({content => '%'.$encodeKey.'%'}, {page => 1});
    if($allResults->count() > 0)
    {
        if($allResults->count() > $numPerPage)
        {
            $allResults->pager->entries_per_page($numPerPage);
            $numPage = $allResults->pager->last_page;
        }
        if($page < 0) {$page = 1}
        if($page > $numPage) {$page = $numPage}
        my $results = $c->model('DB::Post')->search_like({content => '%'.$encodeKey.'%'}, {rows => $numPerPage, page => $page, order_by => {-desc => [qw/thread createddate/]}});
        $c->stash->{results} = [$results->all()];
        $c->stash->{page} = $page;
        $c->stash->{numPage} = $numPage;
        $c->stash->{pageLink} = './search';
    }
    $c->stash->{pageId} = $keyword;
    $c->stash->{getPreview} = sub{getPreview(@_)};
}

sub getPreview {
    my ($str, $key) = @_;
    my $encodeKey = encode_entities($key);
    my $i = index (lc $str, lc $encodeKey);
    if($i == -1) {return $str}
    else
    {
        my $diff = 40;
        $str = decode_entities($str);
        $i = index (lc $str, lc $key);
        my $offset = 0;
        my $len = $i + length $key;
        my $maxLen = length $str;
        if($i > $diff){$offset = $i - $diff;$len = $diff + length $key}
        if(($offset + $len) < ($maxLen - $diff)){$len += $diff}
        else{$len += $maxLen - $offset - $len}
        my $returnStr = substr($str, $offset, $len);
        $returnStr = encode_entities($returnStr);
        my $validEncodeKey = quotemeta $encodeKey;
        $returnStr =~ s|($validEncodeKey)|<span style="color:red"><strong>$1</strong></span>|gi;
        return $returnStr;
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
