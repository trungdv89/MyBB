use strict;
use warnings;
use Test::More;


use Catalyst::Test 'MyBB';
use MyBB::Controller::CreateTopic;

ok( request('/createtopic')->is_success, 'Request should succeed' );
done_testing();
