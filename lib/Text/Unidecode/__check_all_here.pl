#!/usr/bin/perl
#: check that we have all tables here, 0x00__ to 0x_ff
#==============================================================================
#### See the end of this file for the distribution/copyright license.
# sburke@cpan.org
our $Last_Modified =' Time-stamp: "2014-07-25 02:59:20 MDT sburke@cpan.org"';
use strict; use warnings; use Carp;
our $VERSION= "0.01"; 
use constant DEBUG => 10;

use Text::Unidecode ();
$| = 1;
Main_Run();

exit;
#======================================================================

sub Main_Run {
  shift @ARGV if @ARGV and $ARGV[0] eq '--';
  die "I take no arguments" if @ARGV;

  my(@glob) = dir_files_matching("./",
    qr/    # like: "x0c.pm"
       \A
         x
         [0-9a-fA-F]{2}
         \.pm
         \z
      /x
  );

  #print "Them: @glob\n";

  foreach my $block_number ( 0x00 .. 0xFF ) {
    my $b_hex = sprintf "%02x", $block_number;
    my $fs = "x$b_hex.pm"; # like "x32.pm"
    unless(-e $fs) {
      print "Missing block: $fs\n";
      gen_block($fs, $b_hex);
    }

    my $charnum = 0xFE + 0xFF * $block_number;
    my $char = sprintf( "%c", $charnum );
    #printf( "# About to load table %s via char %02x)\n", $hex, $charnum );
    my $x = Text::Unidecode::unidecode($char);
    
  }

  print "Done.\n";

  return;
}
#======================================================================

sub gen_block {
  my($fs, $b_hex) = @_;
  die "WHERE!?" unless $fs and $fs =~ m/\S/;
  die "IT EXISTS!?!" if -e $fs;

  open my $NEW, ">", $fs or die "Can't write-open $fs - $!";
  print "  Generating $fs ...\n";
  
  my $code = 
  qq{# $Last_Modified
\$Text::Unidecode::Char[ 0x$b_hex ] = Text::Unidecode::make_placeholder_map();
1;
};

  print $NEW $code or die "Can't write to $fs - $!";
  close($NEW) or die "Can't close $fs - $!";

  return;
}

sub dir_files_matching {
  my($dirspec,$re) = @_;
  my(@items);
  {
    opendir my $D, $dirspec or die "Can't opendir $dirspec - $!";
    @items = readdir($D);
    closedir($D) or die "Can't closedir $dirspec - $!";
  }
  @items = grep $_ =~ $re, @items;
  return sort @items;
}

#======================================================================
__END__
