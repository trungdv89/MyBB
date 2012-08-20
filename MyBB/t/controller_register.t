use strict;
use warnings;
use Test::More;


use Catalyst::Test 'MyBB';
use MyBB::Controller::register;

ok( request('/register')->is_success, 'Request should succeed' );
done_testing();
