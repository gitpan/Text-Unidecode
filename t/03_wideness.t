
require 5; use warnings; use strict; # -*-mode:CPerl-*-
use Test;
BEGIN {plan tests => 6;}
print q[# // Time-stamp: "2014-01-24 23:38:19 MST sburke@cpan.org"], "\n";

print "# Checking basic operations with Unicode characters...\n";
      
use utf8;

ok 1;
binmode($_, ":utf8") for (*STDOUT, *STDIN, *STDERR);

ok length( "\x{9053}\x{5fb7}\x{7d93}" ), 3;
ok length( "道德經"                    ), 3;

ok "道德經", "\x{9053}\x{5fb7}\x{7d93}" ;

ok "道德經", join( '', chr(0x9053), chr(0x5fb7), chr(0x7d93) );

ok 1;

# End
