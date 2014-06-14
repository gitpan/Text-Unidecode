
require 5; # -*-mode:CPerl-*-
use Test; use strict; use warnings;
BEGIN {plan tests => 12};
print q[# // Time-stamp: "2014-01-24 23:40:23 MST sburke@cpan.org"], "\n";

# Summary of, well, things.
ok 1;
use utf8;

use Text::Unidecode;
ok "a", unidecode("a");

{
  my($i, $n);
  my $f = "# ^-- \"%s\" (U+%04x)\n";
  $n = unidecode( chr($i=0x0100) ); ok $n; printf $f, $n, $i;
  $n = unidecode( chr($i=0x0400) ); ok $n; printf $f, $n, $i;
  $n = unidecode( chr($i=0x0f00) ); ok $n; printf $f, $n, $i;
  $n = unidecode( chr($i=0xff00) ); ok $n; printf $f, $n, $i;
}

# Now let's see the symbol table, then especially %INC...


ok 1;
print "#\n#\n#\n# Now the symbol table:\n#\n";
{
  my @out;
  push @out,
    "\n\nPerl v",
    defined($^V) ? sprintf('%vd', $^V) : $],
    " under $^O ",
    (defined(&Win32::BuildNumber) and defined &Win32::BuildNumber())
      ? ("(Win32::BuildNumber ", &Win32::BuildNumber(), ")") : (),
    (defined $MacPerl::Version)
      ? ("(MacPerl version $MacPerl::Version)") : (),
    "\n"
  ;

  # Ugly code to walk the symbol tables:
  my %v;
  my @stack = ('');  # start out in %::
  my $this;
  my $count = 0;
  my $pref;
  while(@stack) {
    $this = shift @stack;
    die "Too many packages?" if ++$count > 1000;
    next if exists $v{$this};
    next if $this eq 'main'; # %main:: is %::

    #print "Peeking at $this => ${$this . '::VERSION'}\n";
    no strict 'refs';
    if(defined ${$this . '::VERSION'} ) {
      $v{$this} = ${$this . '::VERSION'}
    } elsif(
       defined *{$this . '::ISA'} or defined &{$this . '::import'}
       or ($this ne '' and grep defined *{$_}{'CODE'}, values %{$this . "::"})
       # If it has an ISA, an import, or any subs...
    ) {
      # It's a class/module with no version.
      $v{$this} = undef;
    } else {
      # It's probably an unpopulated package.
      ## $v{$this} = '...';
    }
    
    $pref = length($this) ? "$this\::" : '';
    push @stack, map m/^(.+)::$/ ? "$pref$1" : (), keys %{$this . '::'};
    #print "Stack: @stack\n";
  }
  push @out, " Modules in memory:\n";
  delete @v{'', '[none]'};
  foreach my $p (sort {lc($a) cmp lc($b)} keys %v) {
    my $indent = ' ' x (2 + ($p =~ tr/:/:/));
    push @out,  '  ', $indent, $p, defined($v{$p}) ? " v$v{$p};\n" : ";\n";
  }
  push @out, sprintf "[at %s (local) / %s (GMT)]\n",
    scalar(gmtime), scalar(localtime);
  my $x = join '', @out;
  $x =~ s/^/#/mg;
  print $x;

}
ok 1;

print "# Running",
  (chr(65) eq 'A') ? " in an ASCII world.\n" : " in a non-ASCII world.\n",
  "#\n",
;
ok 1;

print "# \@INC:\n", map("#   [$_]\n", @INC), "#\n#\n";
ok 1;

print "# \%INC:\n";
foreach my $x (sort {lc($a) cmp lc($b)} keys %INC) {
  print "#   [$x] = [", $INC{$x} || '', "]\n";
}

ok 1;

print "#\n#\n# Bye\n";
ok 1;

