use strict;
use warnings;
use Test::More;


use Catalyst::Test 'MyBB';
use MyBB::Controller::admin;

ok( request('/admin')->is_success, 'Request should succeed' );
done_testing();
