package MyBB::Controller::Root;
use Moose;
use namespace::autoclean;
use HTML::Entities;

BEGIN { extends 'Catalyst::Controller' }

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config(namespace => '');

=head1 NAME

MyBB::Controller::Root - Root Controller for MyBB

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

=head2 index

The root page (/)

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
    if($c->session->{'user'})
    {
        $c->stash->{user} = $c->session->{'user'};
        $c->stash->{lastVisit} = $c->session->{'lastVisit'};    
    }
    $c->stash->{topics} = [$c->model('DB::Topic')->all];  
    $c->stash->{template} = 'index.tt';  
    my $now = DateTime->now(time_zone=>'local');
    $c->stash->{now} = $now->date();
}

sub showtopic :Local {
    my ( $self, $c ) = @_;
    $c->stash->{template} = 'threads.tt';
    if($c->session->{'user'})   #display user name if signin
    {
        $c->stash->{user} = $c->session->{'user'};
        $c->stash->{lastVisit} = $c->session->{'lastVisit'};    
    }
    #Calculating for pager
    $c->session->{topicId} = $c->req->params->{id}; #session used for creating new thread
    my $topicId = $c->req->params->{id}; 
    my @threads = $c->model('DB::Thread')->search({topic => $topicId});
    @threads = reverse sort {DateTime->compare($a->lastestpost->createddate, $b->lastestpost->createddate)} @threads;
    my $page = $c->req->params->{page}||1;  #current page
    my $numPerPage = 10;        #number of threads per page
    my $numThread = scalar @threads;
    my $numPage = ($numThread - ($numThread % $numPerPage))/$numPerPage;
    if($numThread > $numPage*$numPerPage) {$numPage++}  #calculate number of pages
    my @returnThreads;
    if($page > $numPage) {$page = $numPage};
    if($page < 1) {$page = 1}
    for(my $i = 0; $i < $numPerPage; $i++)  #display threads in current page
    {
        my $index = ($page-1)*$numPerPage + $i;
        if($index >= scalar @threads) {last}
        else {push(@returnThreads, $threads[$index])}
    }
    #Params interface need
    my $topic = $c->model('DB::Topic')->find({id => $topicId});
    if($topic)
    {
        $c->stash->{topicId} = $topicId;
        $c->stash->{topicTitle} = $topic->title;
    }
    $c->stash->{numPage} = $numPage;
    $c->stash->{page} = $page;
    $c->stash->{threads} = [@returnThreads];
    $c->stash->{action} = '/createthread';
    $c->stash->{pageLink} = '/showtopic';
    $c->stash->{pageId} = $c->req->params->{id};
    my $now = DateTime->now(time_zone=>'local');
    $c->stash->{now} = $now->date();
    my $epoch = $now->epoch;
    $epoch -= 24*60*60;
    my $yesterday = DateTime->from_epoch(epoch => $epoch, time_zone=>'local');
    $c->stash->{yesterday} = $yesterday;
    $c->stash->{count} = 0;
    $c->stash->{parent} = $c->session->{topicId};
    $c->stash->{legend} = 'Create new thread in this topic';
}

sub delete :Local {
    my ( $self, $c ) = @_;
    my $id = $c->req->params->{id};
    my $position = $c->req->params->{position};
    my $page = $c->req->params->{page};
    my $type = $c->req->params->{type};
    my $parent = $c->req->params->{parent};
    my $linkRedirect;
    if(!checkPerDelete($type, $id, $c)) 
    {
        $c->stash->{err} = 'You do not have the permission to delete the object, or request link is wrong!';
        $c->res->redirect('/#'.($position - 1));
        return
    }
    my $deleteTarget;
    if($type eq 'topic')
    {
        $deleteTarget = $c->model('DB::Topic')->find({id => $id});
        if(!$deleteTarget) {$c->stash->{err} = 'Can not find required topic in database'; return}
        $deleteTarget->lastestthread(undef);
        $deleteTarget->update();
        deleteAllChildThread($deleteTarget->id, $c);
        $linkRedirect = '/#'.($position - 1);
        $deleteTarget->delete();   
    }
    elsif($type eq 'thread')
    {
        deleteThread($id, $c);
        $linkRedirect = '/showtopic?id='.$parent.'&page='.$page.'#'.($position - 1);
    }
    elsif($type eq 'post')
    {
        deletePost($id, $c);
        $linkRedirect = '/showthread?id='.$parent.'&page='.$page.'#'.($position - 1);
    }
    else {return}
    $c->res->redirect($linkRedirect);
}

sub checkPerDelete(){        #parameter: type of object needed to delete (post, thread or topic) = $type, id of object = $id, context = $c
    my ($type, $id, $c) = @_;
    my $userId = $c->session->{'userId'};
    if(!($userId&&$id&&$type)) {return 0}
    my $user = $c->model('DB::User')->find({id => $userId});
    if(!$user) {return 0}
    if($user->isadmin) {return 1}
    if($type == 'post')
    {
        my $post = $c->model('DB::Post')->find({id => $id});
        if(($post)&&($post->createdby->id == $userId)) {return 1}
    }
    return 0;
}

sub deleteAllChildPost{     #parameter: thread id = $id, context = $c
    my ($id, $c) = @_;
    my @posts = $c->model('DB::Post')->search({thread => $id});
    foreach my $post (@posts)
    {
        $post->delete();
    }
}

sub deleteAllChildThread{   #parameter: topic id = $id, context = $c
    my ($id, $c) = @_;
    my @threads = $c->model('DB::Thread')->search({topic => $id});
    foreach my $thread (@threads)
    {
        $thread->lastestpost(undef);
        $thread->update();
        deleteAllChildPost($thread->id, $c);
        $thread->delete();
    }
}

sub deletePost{      #parameter: post id = $id, context = $c
    my($id, $c) = @_;
    #check if the post exists
    my $post = $c->model('DB::Post')->find({id => $id});
    if(!$post)
    {
        $c->stash->{err} = 'Can not find required post!';
        return;
    }
    my $pthread = $c->model('DB::Thread')->find({id => $post->thread->id});
    #if post is the first in the thread
    if ($post->ordernum == 1)
    {
        #delete parent thread of the post
        deleteThread($pthread->id, $c);
    }
    elsif($post->id == $pthread->lastestpost->id)  #post is the last in the thread
    {
        #find a new last post
        my @posts = $c->model('DB::Post')->search({thread => $pthread->id});
        if((scalar @posts) > 1)
        {
            @posts = sort {DateTime->compare($a->createddate, $b->createddate)} @posts;
            my $last = pop @posts;
            if($post->id == $last->id)      #in case of some mistake in database, the lastest post is not the lastest created post
            {
                $last = pop @posts;    #pop again to pick another 'last' post
            }
            $pthread->lastestpost($last->id);
            $pthread->update();
            $post->delete();
        }
    }
    else    #post is not the first nor the last
    {
        $post->delete();
    }
}

sub deleteThread{           #parameter: thread id = $id, context = $c
    my ($id, $c) = @_;
    #Check if thread exists
    my $target = $c->model('DB::Thread')->find({id => $id});
    if(!$target) {$c->stash->{err} = 'Can not find required thread in database'; return}
    my $topic = $target->topic;
    if($target->id == $topic->lastestthread->id)        #If thread is the last updated in topic
    {
        #find a new last thread
        my @threads = $c->model('DB::Thread')->search({topic => $c->session->{topicId}});
        if((scalar @threads) < 2)
        {
            $topic->lastestthread(undef);
            $topic->update();
        }
        else
        {
            @threads = sort {DateTime->compare($a->lastestpost->createddate, $b->lastestpost->createddate)} @threads;
            my $last = pop @threads;
            if($target->id == $last->id)
            {
                $last = pop @threads;
            }
            $topic->lastestthread($last->id);
            $topic->update();
        }
    }
    #delete all child post of the thread
    $target->lastestpost(undef);
    $target->update();
    deleteAllChildPost($target->id, $c);
    #delete thread
    $target->delete();
}

sub default :Path {
    my ( $self, $c ) = @_;
    $c->response->body( 'Page not found' );
    $c->response->status(404);
}

sub showthread :Local {
    my ( $self, $c ) = @_;
    $c->stash->{template} = "posts.tt";
    my $threadId = $c->req->params->{'id'};
    my $thread = $c->model('DB::Thread')->find({id => $threadId});
    my $page = $c->req->params->{page}||1;      #index of current page
    #Display user name if signin
    if($c->session->{'user'})
    {
        $c->stash->{user} = $c->session->{'user'};
        $c->stash->{lastVisit} = $c->session->{'lastVisit'};    
    }
    #Executed when user edit a post and save it. Update post's information.
    if($c->req->params->{save})
    {
        my $post = $c->model('DB::Post')->find({id => $c->req->params->{editId}});
        if(!$post)
        {
            $c->stash->{err} = 'Can not find required post!';
            return;
        }
        $post->content(encode_entities($c->req->params->{contentEdit}));
        $post->lastupdate(DateTime->now(time_zone => 'local')->datetime());
        $post->update();
        $c->res->redirect($c->uri_for($c->controller('Root')->action_for('showthread'))."?id=".$post->thread->id."&page=$page#".$c->req->params->{position});
    }
    #Caculating for pager
    my @posts = $c->model('DB::Post')->search({thread => $threadId});
    my $numPerPage = 5;         #number of posts displayed per page
    my $numPost = scalar @posts;
    my $numPage = ($numPost - ($numPost % $numPerPage))/$numPerPage;
    if($numPost > $numPage*$numPerPage) {$numPage++}    #caculate number of pages
    if($c->req->params->{end})  #user require display last post
    {
        $c->res->redirect($c->uri_for($c->controller('Root')->action_for('showthread'))."?id=".$threadId."&page=".$numPage."#end");
    }
    my @returnPosts;
    if($page > $numPage) {$page = $numPage};
    if($page < 1) {$page = 1}
    if($c->req->params->{toPost})   #user want go to page which have specified post
    {
        my $id = $c->req->params->{toPost};
        my $tempPage = 0;
        SEARCH: for($tempPage = 0; $tempPage < $numPage; $tempPage++)
        {
            my $index = 0;
            for(my $i = 0; $i < $numPerPage; $i++)  
            {
                my $index = ($tempPage)*$numPerPage + $i;
                if($index >= scalar @posts) {last}
                else
                {
                    if($posts[$index]->id == $id)
                    {
                        $tempPage++;
                        $i++;
                        $c->res->redirect("/showthread?id=$threadId&page=$tempPage#$i");
                    }
                }
            }
        }
    }
    my $index = 0;
    for(my $i = 0; $i < $numPerPage; $i++)  #display posts in the current page
    {
        my $index = ($page-1)*$numPerPage + $i;
        if($index >= scalar @posts) {last}
        else {push(@returnPosts, $posts[$index])}
    }
    #Params interface need to display
    if($thread)
    {
        $c->stash->{topicId} = $thread->topic->id;
        $c->stash->{topicTitle} = $thread->topic->title;
        $c->stash->{threadId} = $threadId;
        $c->stash->{threadTitle} = $thread->title;
    }
    $c->stash->{numPage} = $numPage;
    $c->stash->{page} = $page;
    $c->stash->{detectLink} = sub {detectLink(@_)};
    $c->stash->{posts} = [@returnPosts];
    $c->stash->{pageLink} = '/showthread';
    $c->stash->{pageId} = $threadId;
    $c->stash->{now} = DateTime->now(time_zone=>'local')->date();
    $c->stash->{count} = 0;
    $c->stash->{parent} = $threadId;
    $c->stash->{action} = $c->uri_for($c->controller('Root')->action_for('showthread'))."?id=".$threadId."#reply";
    $c->stash->{legend} = 'Post a reply for this thread';
    $c->stash->{userId} = $c->session->{'userId'};
    $c->stash->{role} = $c->session->{'role'};
    if($c->req->params->{postId}) 
    {
        $c->stash->{postId} = $c->req->params->{postId};
    }
}

sub detectLink {    #parameters: string need to detect link = $content 
    my ($_) = @_;
    s#((https?://([A-Za-z0-9\?\#\/\:\=\.\_\-]|(\&amp;))*?(\s|\Z)){1})#<a href="$1">$1</a>#g;
    s#(\[IMG\](https?://([A-Za-z0-9\?\#\/\:\=\.\_\-]|(\&amp;))*?)\[/IMG\])#<img src="$2"></img>#gi;
    s#(([A-Za-z0-9._-]+)@([A-Za-z0-9._-]+)\.([A-Za-z0-9._-]{2,4}))#<a href="mailto:$1">$1</a>#g;
    s#\n#\<br\>#g;
    return $_;
}

sub reply :Local :Args(0) {
    my ( $self, $c ) = @_;
    my $content = encode_entities($c->req->params->{content});  #decode all HTML code
    my $now = DateTime->now(time_zone=>'local');
    my $threadId = $c->req->params->{threadId};
    my $thread = $c->model('DB::Thread')->find({id => $threadId});
    my $lastPost = $thread->lastestpost;
    my $order = $lastPost->ordernum + 1;    #create new orderNum for new post
    my $topicId = $thread->topic->id;
    my $topic =  $c->model('DB::Topic')->find({id => $topicId});
    if($topic)
    {   #Create new post
        my $newPost = $c->model('DB::Post')->create({
            content => $content,
            createdby => $c->session->{'userId'},
            createddate => $now->datetime(),
            thread => $threadId,
            ordernum => $order,
            lastupdate => undef
            });
        #Update information to parent thread and parent topic
        $thread->lastestpost($newPost->id);
        $thread->update(); 
        $topic->lastestthread($thread->id);
        $topic->update();   
    }
    $c->stash->{template} = 'posts.tt';
    $c->res->redirect('./showthread?id='.$threadId.'&end=1');
}

sub signIn :Local {
    my ( $self, $c ) = @_;
    $c->stash->{template} = "index.tt";
    if (lc $c->req->method eq 'post')
    {
        my $user_set = $c->model('DB::User');
        my $pass = $c->req->params->{'password'};
        my $name = encode_entities($c->req->params->{'username'});
        my $user = $user_set->find({name => $name});
        if($user)
        {
            my $salt = $user->password;
            my $encryptedPass = crypt($pass,$salt);
            if($encryptedPass eq $salt)
            {
                $c->session->{'user'} = $name;
                $c->stash->{user} = $name;
                $c->stash->{lastVisit} = $user->lastvisited;
                $c->session->{'lastVisit'} = $user->lastvisited;
                $c->session->{'userId'} = $user->id;
                if($name eq 'Admin') {$c->session->{'role'} = 'Admin'}
                else {$c->session->{'role'} = 'Member'}
                if($c->req->params->{topic})
                {
                    if($c->req->params->{thread}) {$c->res->redirect('/showthread?id='.$c->req->params->{thread}.'&page='.$c->req->params->{page})}
                    else {$c->res->redirect('/showtopic?id='.$c->req->params->{topic}.'&page='.$c->req->params->{page})}
                }
                else {$c->res->redirect('/')}
            }
            else
            {
                $c->stash->{template} = 'loginError.tt';
            }
        }
        else
        {
            $c->stash->{template} = 'loginError.tt';
        }
    }
}

sub signOut :Local {
    my ( $self, $c ) = @_;
    $c->stash->{template} = "index.tt";
    $c->session->{'user'} = undef;
    $c->session->{'userId'} = undef;
    $c->session->{'lastVisit'} = undef;
    $c->session->{'role'} = undef;
    $c->res->redirect('/');
}

=head2 end

Attempt to render a view, if needed.

=cut

sub end : ActionClass('RenderView') {}

=head1 AUTHOR

root

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
