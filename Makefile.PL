# This -*-perl-*- script writes the Makefile for installing this distribution.
# ( Last Modified Time-stamp: "2014-06-13 18:51:55 MDT sburke@cpan.org" )
#======================================================================
#
# For info on instaling this module and how to control it, see:
#   perldoc cpan
#   perldoc cpanp
#   perldoc perlmodinstall
#   perldoc ExtUtils::MakeMaker
#
#
#======================================================================

require 5.006;
use ExtUtils::MakeMaker;

# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.

WriteMakefile(
  'NAME'         => 'Text::Unidecode',
  'ABSTRACT'     => 'Provide plain ASCII transliterations of Unicode text',

  'VERSION_FROM' => 'lib/Text/Unidecode.pm', # finds $VERSION

  'AUTHOR'       => 'Sean Burke <sburke@cpan.org>',
  'LICENSE'      => 'perl',
                   #  "...under the same terms as Perl itself"

  'dist'  => {
     'COMPRESS' => 'gzip -4f',
       # from 4 to 6 is where there's a sudden doubling
       #  of processing time,  So 4 is cool.
     'SUFFIX'   => 'gz',
     'TARFLAGS' => 'cfh', # h=follow symlinks when making dist
  },

);

__END__
