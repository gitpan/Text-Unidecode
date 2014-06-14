# -*- coding:utf-8; mode:CPerl -*-
require 5; use Test; use strict; use warnings; use utf8;
print q[# //Time-stamp: "2014-01-24 23:56:48 MST sburke@cpan.org"], "\n";

BEGIN {plan tests => 5};
ok 1;
print "# Checking  that xXX and x{XXXX} syntaxes work in this Perl...\n";

# No actual manipulation of the xXXXX or anything here.
# This file is just so we'll error out if we're in some ancient pre-\x{XXXX} Perl.

ok  "\xE1"; 
ok  "\x{E1}";
ok  "\x{9053}";

ok 1;
#End
