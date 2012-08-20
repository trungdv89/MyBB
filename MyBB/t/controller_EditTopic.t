use strict;
use warnings;
use Test::More;


use Catalyst::Test 'MyBB';
use MyBB::Controller::EditTopic;

ok( request('/edittopic')->is_success, 'Request should succeed' );
done_testing();
