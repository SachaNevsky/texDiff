#!/usr/bin/perl -w

# Perl script to convert LaTeX / biokey diagnistic keys from absolute to relative (automatic)
# Usage: perl ./abs2rel.pl input.tex > output.tex

# Anna Shipunova, 2000
# Updated by Alexey Shipunov, 20150912
# Updated by Alexey Shipunov 20150919

# NOTE: multiple keys in one document possibly lead to conflicting references
# Temporary solution: modify $prefix which is specified below.

$/="";

print STDERR "Converts absolute LaTeX biokey to the relative... \n";

&points();

print "\n";
while(<>){
 s/\\Z(\d+)\./\\TE{$points[$1-1]}/g;
 s/\\T+?\s*(\d+)\./\\SS{$points[$1-1]}/sg;
 s/\\ZZ(\d+)\((\d+)\)\./\\SE{$points[$1-1]}{$points[$2-1]}/g;
 print;
}

# refs will be in in form $prefix[A-Z][1-3]
sub points {
$prefix="G"; # modify here!
$B1 = $nom = "";
@points = ();
 for ($x = 0; $x < 26; $x++) {
  for ($z = 1; $z < 9; $z++) {
   $B1 = chr($x + 65);
   $nom = "$prefix$B1$z";
   @points = (@points, $nom)
  }
 }
}
#
