#!/usr/bin/env perl
use strict;
$^W=1;
# pst-geo-uncompress.pl
# Copyright (C) 2009 Heiko Oberdiek.
#
# This work may be distributed and/or modified under the
# conditions of the LaTeX Project Public License, either version 1.3
# of this license or (at your option) any later version.
# The latest version of this license is in
#   http://www.latex-project.org/lppl.txt
# and version 1.3 or later is part of all distributions of LaTeX
# version 2005/12/01 or later.
#
# This work has the LPPL maintenance status `maintained'.
#
# The Current Maintainer of this work is Heiko Oberdiek.
#
# See file "README" for a list of files that belong to this project.
my $file        = "pst-geo-uncompress.pl";
my $program     = uc($&) if $file =~ /^\w+/;
my $version     = "1.0";
my $date        = "2009/07/30";
my $author      = "Heiko Oberdiek";
my $copyright   = "Copyright (c) 2009 by $author.";
# History:
#   2009/07/30 v1.0: First release.
my $title = "$program $version, $date - $copyright\n";
print STDERR $title;
my $prg_gs = "gs";
$prg_gs = "gs386"    if $^O =~ /dos/i;
$prg_gs = "gsos2"    if $^O =~ /os2/i;
$prg_gs = "gswin32c" if $^O =~ /mswin32/i;
$prg_gs = "gswin32c" if $^O =~ /cygwin/i;
$prg_gs = "mgs"      if defined($ENV{"TEXSYSTEM"}) and
                        $ENV{"TEXSYSTEM"} =~ /miktex/i;

$::opt_help = 0;

my $usage = <<"END_OF_USAGE";
Function: Compresses data files for pst-geo
Syntax: $0 <input file> [output file]
If the output file is not given, standard output is used.
Options:                                         (defaults:)
  --help           print usage
  --gscmd <name>   call of ghostscript           ($prg_gs)
END_OF_USAGE
use Getopt::Long;
GetOptions(
  "help!",
  "gscmd=s" => \$prg_gs
) or die $usage;
!$::opt_help or die $usage;

(@ARGV == 1 or @ARGV == 2) or die $usage;

my $input = $ARGV[0];
my $output = $ARGV[1];

open(IN, '<', $input) or die "!!! Error: Cannot open file `$input'!\n";
my $header = <IN> . <IN>;
$header =~ /^%!PS\s+(.*)currentfile((<<[^>]+>>)?\/[\w\d]+ filter) cvx exec\s*$/s
        or die "!!! Error: Unknown file format of `$input'!\n";
my $decode = $2;
my $pos = tell(IN);
my $ps_input = unpack 'H*', $input;
my $ps_output = '';
my $ps_output = unpack 'H*', $output if $output;

my $ps_code = <<"END_PS_CODE";
%!PS
/buf 10000 string def
<$ps_input> (r) file
dup $pos setfileposition
$decode
END_PS_CODE
$ps_code .= <<"END_PS_CODE" if $output;
<$ps_output> (w) file
exch
END_PS_CODE
$ps_code .= <<"END_PS_CODE";
{ dup buf readstring exch
END_PS_CODE
$ps_code .= <<"END_PS_CODE" unless $output;
  print
END_PS_CODE
$ps_code .= <<"END_PS_CODE" if $output;
  3 index exch writestring
END_PS_CODE
$ps_code .= <<"END_PS_CODE";
  not {exit} if
} loop
closefile
END_PS_CODE
$ps_code .= <<"END_PS_CODE" if $output;
closefile
END_PS_CODE
$ps_code .= <<"END_PS_CODE";
quit
%%EOF
END_PS_CODE
my @cmd = (
    $prg_gs,
    '-q',
    '-sDEVICE=nullpage',
    '-dBATCH',
    '-c',
    $ps_code
);
system @cmd;
if ($? & 127) {
    die sprintf "!!! Error: Ghostscript died with signal %d!\n",
                ($? & 127);
}
elsif ($? != 0) {
    die sprintf "!!! Error: Ghostscript exited with error code %d!\n",
                $? >> 8;
}
print STDERR "* `$output' written.\n" if $output;
__END__
