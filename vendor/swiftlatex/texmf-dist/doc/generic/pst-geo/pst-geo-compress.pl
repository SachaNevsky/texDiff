#!/usr/bin/env perl
use strict;
$^W=1;
# pst-geo-compress.pl
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
my $file        = "pst-geo-compress.pl";
my $program     = uc($&) if $file =~ /^\w+/;
my $version     = "1.2";
my $date        = "2012/12/08";
my $author      = "Heiko Oberdiek/Herbert Voß";
my $copyright   = "Copyright (c) 2017 by $author.";
# History:
#   2009/07/30 v1.0: First release.
my $title = "$program $version, $date - $copyright\n";
print $title;
my $prg_gs = "gs";
$prg_gs = "gs386"    if $^O =~ /dos/i;
$prg_gs = "gsos2"    if $^O =~ /os2/i;
$prg_gs = "gswin32c" if $^O =~ /mswin32/i;
$prg_gs = "gswin32c" if $^O =~ /cygwin/i;
$prg_gs = "mgs"      if defined($ENV{"TEXSYSTEM"}) and
                        $ENV{"TEXSYSTEM"} =~ /miktex/i;
my $prg_gstest = $prg_gs;

my $data = 1;
my @bool = ('false', 'true');
$::opt_help = 0;
$::opt_test = 0;
$::opt_gscmd = '';
$::opt_gstestcmd = '';

my $usage = <<"END_OF_USAGE";
Function: Compresses data files for pst-geo
Options:                                               (defaults:)
  --help              print usage
  --data1 | -1        .dat files from data.tgz         ($bool[$data == 1])
  --data2 | -2        .dat files from dataII.tgz       ($bool[$data == 2])
  --gscmd <name>      call of ghostscript              ($prg_gs)
  --gstestcmd <name>  call of ghostscript for testing  ($prg_gstest)
  --test              test mode without compressing    ($bool[$::opt_test])
END_OF_USAGE
use Getopt::Long;
GetOptions(
  "help!",
  "test!",
  "data1|1" => sub { $data = 1; },
  "data2|2" => sub { $data = 2; },
  "prediction!",
  "gscmd=s",
  "gstestcmd=s",
) or die $usage;
!$::opt_help or die $usage;

$prg_gs = $::opt_gscmd if $::opt_gscmd;
if ($::opt_gstestcmd) {
    $prg_gstest = $::opt_gstestcmd;
}
else {
    $prg_gstest = $prg_gs;
}

my $tmpfile = "__geo-pst-compress__$$.tmp";
my $predict_threshold = 0.95;

my @data1 = qw[
    aus.dat
    canada.dat
    capitals.dat
    c-cap.dat
    citysub.dat
    corse.dat
    c-sub.dat
    france.dat
    mex.dat
    pborder.dat
    pcoast.dat
    pisland.dat
    plake.dat
    rhone.dat
    ridge.dat
    river.dat
    seine.dat
    transfrm.dat
    trench.dat
    usa.dat
    wfraczon.dat
    wmaglin.dat
];

my @data2 = qw[
    africa-bdy_II.dat
    africa-cil_II.dat
    africa-riv_II.dat
    asia-bdy_II.dat
    asia-cil_II.dat
    asia-isl_II.dat
    asia-riv_II.dat
    europe-bdy_II.dat
    europe-cil_II.dat
    europe-riv_II.dat
    northamerica-bdy_II.dat
    northamerica-cil_II.dat
    northamerica-pby_II.dat
    northamerica-riv_II.dat
    southamerica-arc_II.dat
    southamerica-bdy_II.dat
    southamerica-cil_II.dat
    southamerica-riv_II.dat
];

my @data = ($data == 1) ? @data1 : @data2;

my %city = (
    'capitals.dat' => 1,
    'c-cap.dat' => 1,
    'citysub.dat' => 1,
    'c-sub.dat' => 1,
    'citycapitals.dat' => 1,
);

my %predict = (
    # data 1
    'pborder.dat' => 24,
    'pcoast.dat' => 24,
    'pisland.dat' => 25,
    'plake.dat' => 24,
    'ridge.dat' => 25,
    'river.dat' => 24,
    'seine.dat' => 26,
    'transfrm.dat' => 24,
    'trench.dat' => 25,
    'wfraczon.dat' => 25,
    'wmaglin.dat' => 25,
    # data 2
    'africa-cil_II.dat' => 22,
    'asia-cil_II.dat' => 23,
    'europe-riv_II.dat' => 21,
    'southamerica-cil_II.dat' => 23,
);

my %array;

sub catch_zap {
    unlink $tmpfile if -f $tmpfile;
    my $signame = shift;
    chomp $signame;
    die "!!! Aborted by SIG$signame!\n";
}
$SIG{'INT'} = \&catch_zap;
$SIG{'__DIE__'} = sub { unlink $tmpfile if -f $tmpfile; };

sub tmp_open () {
    open(TMP, '>', $tmpfile) or die "!!! Error: Cannot write `$tmpfile'!\n";
}
sub file_open ($) {
    my $file = shift;
    open(IN, '<', $file) or die "!!! Error: Cannot open `$file'!\n";
}

sub tmp_move ($) {
    my $file = shift;
    close(IN);
    close(TMP);
    unlink $file or die "!!! Error: Cannot delete `$file'!\n";
    rename $tmpfile, $file or die "!!! Error: Cannot move `$tmpfile' to `$file'!\n";
}

# 1. sanitizing
print "\n";
print "1. Sanitizing\n";
print "=============\n";

foreach my $file (@data) {
    if ($::opt_test) {
        print "[skipping because of test mode]\n";
        last;
    }
    print "* $file\n";
    file_open $file;
    my $old_line = <IN>;
    not($old_line =~ /^%!PS/)
            or die "!!! Error: File `$file' is already compressed!\n";
    $old_line =~ /\/([\w\-]+)(\s|\[)/
            or die "!!! Internal error: Name not found!\n";
    $array{$file} = $1;
    $old_line =~ s/%.*$// unless $city{$file};
    $old_line =~ s/\s+$//;
    tmp_open;
    while (<IN>) {
        if ($old_line and $old_line =~ /%/) {
            print TMP "$old_line\n";
            $old_line = '';
        }
        s/%.*$// unless $city{$file};
        s/^\s+//;
        s/\s+$//;
        /^\[%/ or s/(.)%.*$/$1/;
        s/\s+$//;
        s/([\[\]])\s+/$1/g;
        s/\s+(\])/$1/g;
        s/\s+/ /g;
        if ($file eq 'seine.dat') {
            s/(\[\d) /$1.000000000 /;
            s/(\[\d\.\d) /${1}00000000 /;
            s/(\[\d\.\d\d) /${1}0000000 /;
            s/( \d+)\]/$1.00000000]/;
            s/(\d\.\d)\]/${1}0000000]/;
            s/(\d\.\d\d)\]/${1}000000]/;
        }
        if ($city{$file}) {
            s/(\.0+)(\D)/$2/g;
            s/(\.\d*[1-9])0+(\D)/$1$2/g;
            s/(\D)0\./$1./g;
        }
        next unless $_;
        if ($_ eq '[' or $_ eq ']' or $_ eq ']def' or $_ =~ /\[%/) {
            $old_line .= $_;
            next;
        }
        if ($_ eq 'def') {
            $old_line .= $_;
            $_ = '';
        }
        if ($old_line) {
            print TMP "$old_line\n";
            $old_line = '';
        }
        print TMP "$_\n" if $_;
    }
    print TMP "$old_line\n" if $old_line;
    tmp_move $file;
}
print "\n";

# 2. line length analysis
print "2. Line length analysis\n";
print "=======================\n";

foreach my $file (@data) {
    if ($::opt_test) {
        print "[skipping because of test mode]\n";
        last;
    }
    print "* $file\n";
    my @lens;
    my $num;
    file_open $file;
    while (<IN>) {
        $num++;
        my $len = length $_;
        if ($lens[$len]) {
            $lens[$len]++;
        }
        else {
            $lens[$len] = 1;
        }
    }
    close(IN);
    my $max = 0;
    for (my $i = 0; $i < @lens; $i++) {
        next unless $lens[$i];
        $max = $i;
        print "  $i: $lens[$i]\n";
        my $threshold = $predict_threshold * $num;
        next if $predict{$file};
        if (($lens[$i] > $threshold) or
                ($lens[$i-1] and ($lens[$i-1] + $lens[$i] > $threshold)) or
                ($lens[$i-1] and $lens[$i-2] and
                 ($lens[$i-2] + $lens[$i-1] + $lens[$i] > $threshold))) {
            $predict{$file} = $i;
        }
    }
    if ($predict{$file}) {
        print "  --> predict($file) = $predict{$file}\n";
        $predict{$file} == $max
                or die "!!! Internal error: prediction ($predict{$file}) too small ($max)!\n";
    }
    else {
        print "  --> predict($file) = ??\n";
    }
}
print "\n";

# 3. Prediction preparation
print "3. Prepare prediction\n";
print "=====================\n";

foreach my $file (@data) {
    if ($::opt_test) {
        print "[skipping because of test mode]\n";
        last;
    }
    next unless $predict{$file};
    print "* $file\n";
    my $predict = $predict{$file};
    tmp_open;
    file_open $file;
    while (<IN>) {
        my $len = length $_;
        if ($len % $predict == 0) {
            print TMP $_;
            next;
        }
        chomp;
        $_ .= ' ' x ($predict - ($len % $predict));
        $_ .= "\n";
        length($_) % $predict == 0 or die "!!! Internal Error!\n";
        print TMP $_;
    }
    tmp_move $file;
}
print "\n";

# 4. Compression
print "4. Compress files\n";
print "=================\n";

sub check_gs_end () {
    if ($? & 127) {
        die sprintf "!!! Error: Ghostscript died with signal %d!\n",
                    ($? & 127);
    }
    elsif ($? != 0) {
        die sprintf "!!! Error: Ghostscript exited with error code %d!\n",
                    $? >> 8;
    }
}

foreach my $file (@data) {
    if ($::opt_test) {
        print "[skipping because of test mode]\n";
        last;
    }
    print "* $file\n";
    my $predict = $predict{$file};
    my $filter_dict = '';
    $filter_dict = "<</Predictor 12/Columns $predict>>" if $predict;
    my $compress_dict = "<</Effort 9>>";
    $compress_dict = "<</Effort 9/Predictor 12/Columns $predict>>" if $predict;
    my $ps_code = <<"END_PS_CODE";
%!PS
/buf 10000 string def
/tmpfilename ($tmpfile) def
/header (%!PS\\ncurrentfile$filter_dict/FlateDecode filter cvx exec\\n) def
($file)
% Convert file, stack: <file name>
(  converting `) print dup print (' ... ) print flush
dup (r) file
% test if file is already converted
dup header length string readstring
{
  1 index 0 setfileposition
  header eq
  {
    (nothing to do.\\n) print flush
    false
  }
  {true}
  ifelse
}
{
  (read error.\\n) print flush
  false
}
ifelse
{
  tmpfilename (w) file
  dup header writestring
  $compress_dict
  /FlateEncode filter
  exch
  % stack: <input file name> <output file obj> <input file obj>
  {
    2 copy
    buf readstring
    3 1 roll
    writestring
    not {exit} if
  } loop
  closefile
  closefile
  dup deletefile tmpfilename exch renamefile
  (done.\\n) print flush
} if
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
    check_gs_end;
}
print "\n";

# 5. Test
print "5. Testing\n";
print "==========\n";

foreach my $file (@data) {
    print "* $file\n";
    my $ps_code = <<"END_PS_CODE";
%!PS
(  testing `$file' ... ) print flush
($file) run
END_PS_CODE
    $ps_code .= <<"END_PS_CODE" if $::opt_test;
(\\n) print flush
END_PS_CODE
    $ps_code .= <<"END_PS_CODE" unless $::opt_test;
$array{$file} type /arraytype eq
{
  (ok.\\n) print flush
}{
  (FAILED!\\n) print flush
  ioerror
}
ifelse
END_PS_CODE
    $ps_code .= <<"END_PS_CODE";
quit
%%EOF
END_PS_CODE
    my @cmd = (
        $prg_gstest,
        '-q',
        '-sDEVICE=nullpage',
        '-dBATCH',
        '-c',
        $ps_code
    );
    system @cmd;
    check_gs_end;
}

print "\n";
__END__
