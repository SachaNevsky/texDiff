chomp ($d = `date +"%d %B, %Y"`);
$v = pop @ARGV;
while (<>) {
 s/^Versione.+/Versione~$v, $d/;
 print;
}

