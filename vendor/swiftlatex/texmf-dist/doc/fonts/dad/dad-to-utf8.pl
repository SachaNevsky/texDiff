#!/usr/bin/perl
use utf8;
binmode stdin,":utf8";
binmode stdout,":utf8";

sub encode {
my $s=shift;
my @RES=();
while ($s =~ m/(.)/g) {
$c=$1;
#if ($c =~ m/[A-Za-z]/) {
push @RES, ord($c);
#} else {
#push @RES, $c;
#}
}
return join("•",@RES);
}

sub decode {
my $s=shift;
my @S=split(/•/,$s);
my $res="";
foreach $c (@S) {
#if ($c =~ m/^[0-9]+$/) {
$res.=chr($c);
#} else { $res.=$c; }
}
return $res;
}

while (<>) {
s/\\([A-Za-z]+)/"\\".&encode($1)."§"/ge;
s/\|/ء/g;
s/'A/آ/g;
s/'a/أ/g;
s/'u/ؤ/g;
s/'i/إ/g;
s/'I/ئ/g;
s/'b/ٮ/g;
s/'n/ں/g;
s/'f/ڡ/g;
s/'q/ٯ/g;
s/s-h/سه/g;
s/t-h/ته/g;
s/z-h/زه/g;
s/d-h/ده/g;
s/A/ا/g;
s/b/ب/g;
s/t\*/ة/g;
s/c/ث/g;
s/t/ت/g;
s/j/ج/g;
s/H/ح/g;
s/x/خ/g;
s/dh/ذ/g;
s/d/د/g;
s/r/ر/g;
s/zh/ژ/g;
s/z/ز/g;
s/sh/ش/g;
s/s/س/g;
s/S/ص/g;
s/D/ض/g;
s/T/ط/g;
s/Z/ظ/g;
s/`/ع/g;
s/R/غ/g;
s/f/ف/g;
s/q/ق/g;
s/k/ك/g;
s/[Ll]/ل/g;
s/m/م/g;
s/n/ن/g;
s/h/ه/g;
s/U/و/g;
s/I/ى/g;
s/Y/ي/g;
s/p/پ/g;
s/C/چ/g;
s/v/ڤ/g;
s/g/گ/g;
s/e/ۀ/g;
s/--/ـ/g;
s/-/‍/g;
s/aN/ً/g;
s/uN/ٌ/g;
s/iN/ٍ/g;
s/a\*\*/ٓ/g;
s/a\*/ٰ/g;
s/a/َ/g;
s/u/ُ/g;
s/i/ِ/g;
s/\+/ّ/g;
s/o/ْ/g;
s/\\([0-9•]+)§/"\\".&decode($1)/ge;
print;
}