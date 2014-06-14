# -*- coding:utf-8; mode:CPerl -*-
require 5; use warnings; use strict;
use Test;
BEGIN {plan tests => 2;}

ok 1;

my $modtime = q[ timestamp Time-stamp: "2014-01-24 23:57:23 MST sburke@cpan.org" ];
print "# Hello from line ", __LINE__, " file ", __FILE__, $modtime, "\n";

ok 1;

# End
