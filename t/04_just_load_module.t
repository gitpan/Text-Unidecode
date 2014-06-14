# -*- coding:utf-8; mode:CPerl -*-
require 5; use Test; use strict; use warnings; use utf8;
print q[# //Time-stamp: "2014-01-24 23:56:58 MST sburke@cpan.org"], "\n";

BEGIN {plan tests => 3;}


print "# Let's just see if a bare 'use Text::Unidecode' works:\n";

ok 1;

use Text::Unidecode;

print "# We just loaded Unidecode version: ",
  $Text::Unidecode::VERSION || "?", "\n";

ok "a", unidecode("a"); # sanity

ok 1;
print "# Bye\n";
