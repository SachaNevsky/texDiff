$dvi_mode = 0;
$pdf_mode = 1;

@default_files=();
foreach $file (glob('makedtx.{dtx,tex}'))
{
   if(-e $file){
      @default_files=($file);
      break;
   }
}

$makeindex= "makeindex -s gind.ist %O -o %D %S";

# 1. For glossaries using glossary package --- \changes generatated by the ltxdoc \changes directive
add_cus_dep( 'glo', 'gls', 0, 'makeglo2gls' );
sub makeglo2gls {
    system("makeindex -s gglo.ist -t \"$_[0].glg\" -o \"$_[0].gls\" \"$_[0].glo\"" );
}
