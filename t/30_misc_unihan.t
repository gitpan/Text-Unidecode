# -*- coding:utf-8; mode:CPerl -*-
require 5; use Test; use strict; use warnings; use utf8;
print q[# //Time-stamp: "2014-06-13 03:42:12 MDT sburke@cpan.org"], "\n";

BEGIN {plan
                tests =>   4
;}

use Text::Unidecode;
print "# Checking basic operations with Unicode characters...\n";

ok 1;
binmode($_, ":utf8") for (*STDOUT, *STDIN, *STDERR);

ok( "\x{4e00}", "一" );
ok( unidecode("\x{4e00}"), "Yi " );

ok 1;

# End


