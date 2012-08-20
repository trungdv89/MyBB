use strict;
use warnings;
use Test::More;


use Catalyst::Test 'MyBB';
use MyBB::Controller::EditThread;

ok( request('/editthread')->is_success, 'Request should succeed' );
done_testing();
