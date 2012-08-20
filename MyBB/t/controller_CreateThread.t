use strict;
use warnings;
use Test::More;


use Catalyst::Test 'MyBB';
use MyBB::Controller::CreateThread;

ok( request('/createthread')->is_success, 'Request should succeed' );
done_testing();
