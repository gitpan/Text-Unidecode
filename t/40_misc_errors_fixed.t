# -*- coding:utf-8; mode:CPerl -*-
require 5; use Test; use strict; use warnings; use utf8;
print q[# //Time-stamp: "2014-05-12 01:36:10 MDT sburke@cpan.org"], "\n";

BEGIN {plan tests => 4;}

use Text::Unidecode;
print "# Checking various errors to be fixedbasic operations with Unicode characters...\n";

ok 1;
binmode($_, ":utf8") for (*STDOUT, *STDIN, *STDERR);



ok( "\x{02b0}", "ʰ" );
ok( unidecode( "ʰ" ), "h" );



ok 1;

# End


