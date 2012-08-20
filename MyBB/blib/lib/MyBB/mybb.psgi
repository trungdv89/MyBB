use strict;
use warnings;

use MyBB;

my $app = MyBB->apply_default_middlewares(MyBB->psgi_app);
$app;

