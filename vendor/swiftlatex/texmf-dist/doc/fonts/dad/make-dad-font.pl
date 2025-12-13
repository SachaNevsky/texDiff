# %%% ====================================================================
# %%%  @Perl-file{
# %%%     filename        = "make-dad-font.pl",
# %%%     version         = "1.1",
# %%%     date            = "2014/10/11",
# %%%     author          = "Yannis Haralambous",
# %%%     copyright       = "This file is part of the dad package, released
# %%%                        under the LPPL."
# %%%     keywords        = "TeX, file header,
# %%%     supported       = "yes",
# %%%     abstract        = "This is the Perl script that creates
# %%%       the dad fonts out of their AFM and ADJUST files.",
# %%%  }
# %%% ====================================================================
$MAXHEIGHT=560;
$MAXDEPTH=-360;
if ($ARGV[0] ne "") { $STYLE_="-".$ARGV[0]; $STYLE=$ARGV[0]; } else { $STYLE=""; }

@LETTERS=("alif","ba","tamarbuta","ta","tha","dzim","he","khe","dal","dhal","ra","za",
"sin","shin","sad","dad","tta","zza","ayn","ghayn","fa","qaf","kaf","lam","meem","nun",
"ha","waw","ya","alifmaqsura","alifwasla","pe","tche","zhe","va","gaf",
"hahamza","alifuphamza","alifmadda","aliflohamza","wawhamza","yahamza","banodots","nunnodots","fanodots","qafnodots","keshideh");
@LETTERS_NO_LAMS=("alif","ba","tamarbuta","ta","tha","dzim","he","khe","dal","dhal","ra","za","sin","shin","sad","dad","tta","zza","ayn","ghayn","fa","qaf","kaf","meem","nun",
"ha","waw","ya","alifmaqsura","alifwasla","alifmadda","pe","tche","zhe","va","gaf",
"hahamza","alifuphamza","aliflohamza","wawhamza","yahamza","banodots","nunnodots","fanodots","qafnodots","keshideh");
@LETTERS_NO_ALIFS=("ba","tamarbuta","ta","tha","dzim","he","khe","dal","dhal","ra","za",
"sin","shin","sad","dad","tta","zza","ayn","ghayn","fa","qaf","kaf","lam","meem","nun",
"ha","waw","ya","alifmaqsura","pe","tche","zhe","va","gaf",
"hahamza","wawhamza","yahamza","banodots","nunnodots","fanodots","qafnodots","keshideh");
@LETTERS_NO_LAMS_NO_ALIFS=("ba","tamarbuta","ta","tha","dzim","he","khe","dal","dhal","ra","za","sin","shin","sad","dad","tta","zza","ayn","ghayn","fa","qaf","kaf","meem","nun",
"ha","waw","ya","alifmaqsura","pe","tche","zhe","va","gaf",
"hahamza","wawhamza","yahamza","banodots","nunnodots","fanodots","qafnodots","keshideh");
@LAMS=("lam");
@ALIFS=("alif","alifuphamza","aliflohamza","alifwasla","alifmadda");
@DIACS=("shadda","sukun","madda","vfatha");
@vDIACS=("fatha","kasra","damma");
$FORM{"apos"}=4;
$FORM{"alif"}=2;
$FORM{"ba"}=4;
$FORM{"banodots"}=4;
$FORM{"tamarbuta"}=4;
$FORM{"ta"}=4;
$FORM{"tha"}=4;
$FORM{"dzim"}=4;
$FORM{"he"}=4;
$FORM{"khe"}=4;
$FORM{"dal"}=2;
$FORM{"dhal"}=2;
$FORM{"ra"}=2;
$FORM{"za"}=2;
$FORM{"sin"}=4;
$FORM{"shin"}=4;
$FORM{"sad"}=4;
$FORM{"dad"}=4;
$FORM{"tta"}=4;
$FORM{"zza"}=4;
$FORM{"ayn"}=4;
$FORM{"ghayn"}=4;
$FORM{"fa"}=4;
$FORM{"fanodots"}=4;
$FORM{"qaf"}=4;
$FORM{"qafnodots"}=4;
$FORM{"kaf"}=4;
$FORM{"lam"}=4;
$FORM{"meem"}=4;
$FORM{"nun"}=4;
$FORM{"nunnodots"}=4;
$FORM{"ha"}=4;
$FORM{"waw"}=2;
$FORM{"ya"}=4;
$FORM{"alifmaqsura"}=2;
$FORM{"alifwasla"}=2;
$FORM{"pe"}=4;
$FORM{"tche"}=4;
$FORM{"zhe"}=2;
$FORM{"va"}=4;
$FORM{"gaf"}=4;
$FORM{"hahamza"}=2;
$FORM{"alifuphamza"}=2;
$FORM{"aliflohamza"}=2;
$FORM{"wawhamza"}=2;
$FORM{"yahamza"}=4;
$FORM{"hamza"}=1;
$FORM{"keshideh"}=4;
$FORM{"zwj"}=4;
$POS{"alif0"}="41";
$POS{"alif3"}="00";
$POS{"alif4"}="8F";
$POS{"alif5"}="E6";
$POS{"ba0"}="62";
$POS{"ba1"}="1A";
$POS{"ba2"}="1B";
$POS{"ba3"}="1C";
$POS{"banodots0"}="88";
$POS{"banodots1"}="DE";
$POS{"banodots2"}="DF";
$POS{"banodots3"}="E1";
$POS{"tamarbuta0"}="84";
$POS{"tamarbuta1"}="F4";
$POS{"tamarbuta2"}="F5";
$POS{"tamarbuta3"}="D2";
$POS{"ta0"}="74";
$POS{"ta1"}="C1";
$POS{"ta2"}="EB";
$POS{"ta3"}="C3";
$POS{"tha0"}="63";
$POS{"tha1"}="D3";
$POS{"tha2"}="D4";
$POS{"tha3"}="D5";
$POS{"dzim0"}="6A";
$POS{"dzim1"}="A8";
$POS{"dzim2"}="A9";
$POS{"dzim3"}="AA";
$POS{"he0"}="48";
$POS{"he1"}="07";
$POS{"he2"}="08";
$POS{"he3"}="09";
$POS{"khe0"}="78";
$POS{"khe1"}="C7";
$POS{"khe2"}="C8";
$POS{"khe3"}="C9";
$POS{"dal0"}="64";
$POS{"dal3"}="1D";
$POS{"dhal0"}="85";
$POS{"dhal3"}="86";
$POS{"ra0"}="72";
$POS{"ra3"}="BD";
$POS{"za0"}="7A";
$POS{"za3"}="CB";
$POS{"sin0"}="73";
$POS{"sin1"}="BE";
$POS{"sin2"}="BF";
$POS{"sin3"}="C0";
$POS{"shin0"}="89";
$POS{"shin1"}="DA";
$POS{"shin2"}="DB";
$POS{"shin3"}="DC";
$POS{"sad0"}="53";
$POS{"sad1"}="0D";
$POS{"sad2"}="0E";
$POS{"sad3"}="0F";
$POS{"dad0"}="44";
$POS{"dad1"}="04";
$POS{"dad2"}="05";
$POS{"dad3"}="06";
$POS{"tta0"}="54";
$POS{"tta1"}="10";
$POS{"tta2"}="11";
$POS{"tta3"}="12";
$POS{"zza0"}="5A";
$POS{"zza1"}="14";
$POS{"zza2"}="15";
$POS{"zza3"}="16";
$POS{"ayn0"}="60";
$POS{"ayn1"}="17";
$POS{"ayn2"}="18";
$POS{"ayn3"}="19";
$POS{"ghayn0"}="52";
$POS{"ghayn1"}="D6";
$POS{"ghayn2"}="D7";
$POS{"ghayn3"}="D8";
$POS{"fa0"}="66";
$POS{"fa1"}="1F";
$POS{"fa2"}="A0";
$POS{"fa3"}="A1";
$POS{"fanodots0"}="8C";
$POS{"fanodots1"}="E2";
$POS{"fanodots2"}="E3";
$POS{"fanodots3"}="F3";
$POS{"qaf0"}="71";
$POS{"qaf1"}="BA";
$POS{"qaf2"}="BB";
$POS{"qaf3"}="BC";
$POS{"qafnodots0"}="8D";
$POS{"qafnodots1"}="EE";
$POS{"qafnodots2"}="F6";
$POS{"qafnodots3"}="E5";
$POS{"kaf0"}="6B";
$POS{"kaf1"}="AB";
$POS{"kaf2"}="AC";
$POS{"kaf3"}="AD";
$POS{"lam0"}="6C";
$POS{"lam1"}="AE";
$POS{"lam2"}="AF";
$POS{"lam3"}="B0";
$POS{"lam4"}="46"; #lam1-alif3
$POS{"lam5"}="47"; #lam2-alif3
$POS{"lam6"}="4C"; #lam1-(lam2)-ha3
$POS{"lam7"}="4D"; #lam2-(lam2)-ha3
$POS{"lam8"}="94"; #(lam1)-lam2-ha3
$POS{"ll0"}="F7";
$POS{"ll1"}="F8";
$POS{"ll5"}="F9";
$POS{"LLh0"}="FA";
$POS{"meem0"}="6D";
$POS{"meem1"}="B1";
$POS{"meem2"}="B2";
$POS{"meem3"}="B3";
$POS{"nun0"}="6E";
$POS{"nun1"}="B4";
$POS{"nun2"}="B5";
$POS{"nun3"}="B6";
$POS{"nunnodots0"}="8B";
$POS{"nunnodots1"}="EC";
$POS{"nunnodots2"}="ED";
$POS{"nunnodots3"}="E0";
$POS{"ha0"}="68";
$POS{"ha1"}="A5";
$POS{"ha2"}="A6";
$POS{"ha3"}="A7";
$POS{"ha4"}="93"; #(lam1-lam2)-ha3
$POS{"waw0"}="55";
$POS{"waw3"}="13";
$POS{"ya0"}="59";
$POS{"ya1"}="0A";
$POS{"ya2"}="0B";
$POS{"ya3"}="CA";
$POS{"alifmaqsura0"}="49";
$POS{"alifmaqsura3"}="0C";
$POS{"pe0"}="70";
$POS{"pe1"}="B7";
$POS{"pe2"}="B8";
$POS{"pe3"}="B9";
$POS{"tche0"}="43";
$POS{"tche1"}="01";
$POS{"tche2"}="02";
$POS{"tche3"}="03";
$POS{"zhe0"}="4A";
$POS{"zhe3"}="D9";
$POS{"va0"}="76";
$POS{"va1"}="C4";
$POS{"va2"}="C5";
$POS{"va3"}="C6";
$POS{"gaf0"}="67";
$POS{"gaf1"}="A2";
$POS{"gaf2"}="A3";
$POS{"gaf3"}="A4";
$POS{"hahamza0"}="65";
$POS{"hahamza3"}="1E";
$POS{"alifuphamza0"}="E4";
$POS{"alifuphamza3"}="CC";
$POS{"alifuphamza4"}="90";
$POS{"alifuphamza5"}="E7";
$POS{"aliflohamza0"}="EF";
$POS{"aliflohamza3"}="CD";
$POS{"aliflohamza4"}="91";
$POS{"aliflohamza5"}="E8";
$POS{"alifmadda0"}="C2";
$POS{"alifmadda3"}="DD";
$POS{"alifmadda4"}="92";
$POS{"alifmadda5"}="E9";
$POS{"alifwasla0"}="83";
$POS{"alifwasla3"}="F0";
$POS{"alifwasla4"}="F1";
$POS{"alifwasla5"}="F2";
$POS{"wawhamza0"}="FC";
$POS{"wawhamza3"}="CE";
$POS{"yahamza0"}="FF";
$POS{"yahamza1"}="CF";
$POS{"yahamza2"}="D0";
$POS{"yahamza3"}="D1";
$POS{"hamza0"}="7C";
$POS{"keshideh0"}="4B";
$POS{"keshideh1"}="4F";
$POS{"keshideh2"}="50";
$POS{"keshideh3"}="51";
$POS{"zwj0"}="2D";
$POS{"zwj1"}="2D";
$POS{"zwj2"}="2D";
$POS{"zwj3"}="26";
$POS{"fatha"}="61";
$POS{"vfatha"}="8E";
$POS{"kasra"}="69";
$POS{"damma"}="75";
$POS{"sukun"}="6F";
$POS{"madda"}="9F";
$POS{"fathatan"}="99";
$POS{"kasratan"}="9A";
$POS{"dammatan"}="9B";
$POS{"shadda"}="2B";
$POS{"shaddafatha"}="96";
$POS{"shaddavfatha"}="EA";
$POS{"shaddakasra"}="97";
$POS{"shaddadamma"}="98";
$POS{"shaddamadda"}="8A";
$POS{"shaddafathatan"}="9C";
$POS{"shaddakasratan"}="9D";
$POS{"shaddadammatan"}="9E";
$POS{"BC"}="7C";
$POS{"plus"}="2B";
$POS{"apos0"}="27";
$POS{"apos1"}="56";
$POS{"apos2"}="57";
$POS{"apos3"}="58";
$POS{"apos4"}="5E";
$POS{"apos5"}="5F";
$POS{"aster"}="2A";
$POS{"N"}="4E";
$POS{"zero"}="30";
$POS{"un"}="31";
$POS{"deux"}="32";
$POS{"trois"}="33";
$POS{"quatre"}="34";
$POS{"cinq"}="35";
$POS{"six"}="36";
$POS{"sept"}="37";
$POS{"huit"}="38";
$POS{"neuf"}="39";
$POS{"question"}="3F";
$POS{"comma"}="2C";
$POS{"semicolon"}="EB";
$DECALAGE{"fatha"}=1;
$DECALAGE{"kasra"}=2;
$DECALAGE{"damma"}=3;
$DECALAGE{"fathatan"}=4;
$DECALAGE{"kasratan"}=5;
$DECALAGE{"dammatan"}=7;
$DECALAGE{"shadda"}=8;
$DECALAGE{"shaddafatha"}=9;
$DECALAGE{"shaddakasra"}=10;
$DECALAGE{"shaddadamma"}=11;
$DECALAGE{"shaddafathatan"}=12;
$DECALAGE{"shaddakasratan"}=13;
$DECALAGE{"shaddadammatan"}=14;
$DECALAGE{"sukun"}=15;
$DECALAGE{"madda"}=16;
$DECALAGE{"vfatha"}=17;
$DECALAGE{"shaddavfatha"}=18;
$DECALAGE{"shaddamadda"}=19;

$UTFPOS{"alif0"}="0627";
$UTFPOS{"ba0"}="0628";
$UTFPOS{"banodots0"}="066E";
$UTFPOS{"tamarbuta0"}="0629";
$UTFPOS{"ta0"}="062A";
$UTFPOS{"tha0"}="062B";
$UTFPOS{"dzim0"}="062C";
$UTFPOS{"he0"}="062D";
$UTFPOS{"khe0"}="062E";
$UTFPOS{"dal0"}="062F";
$UTFPOS{"dhal0"}="0630";
$UTFPOS{"ra0"}="0631";
$UTFPOS{"za0"}="0632";
$UTFPOS{"sin0"}="0633";
$UTFPOS{"shin0"}="0634";
$UTFPOS{"sad0"}="0635";
$UTFPOS{"dad0"}="0636";
$UTFPOS{"tta0"}="0637";
$UTFPOS{"zza0"}="0638";
$UTFPOS{"ayn0"}="0639";
$UTFPOS{"ghayn0"}="063A";
$UTFPOS{"fa0"}="0641";
$UTFPOS{"fanodots0"}="06A1";
$UTFPOS{"qaf0"}="0642";
$UTFPOS{"qafnodots0"}="066F";
$UTFPOS{"kaf0"}="0643";
$UTFPOS{"lam0"}="0644";
$UTFPOS{"meem0"}="0645";
$UTFPOS{"nun0"}="0646";
$UTFPOS{"nunnodots0"}="06BA";
$UTFPOS{"ha0"}="0647";
$UTFPOS{"waw0"}="0648";
$UTFPOS{"ya0"}="064A";
$UTFPOS{"alifmaqsura0"}="0649";
$UTFPOS{"pe0"}="067E";
$UTFPOS{"tche0"}="0686";
$UTFPOS{"zhe0"}="0698";
$UTFPOS{"va0"}="06A4";
$UTFPOS{"gaf0"}="06AF";
$UTFPOS{"hahamza0"}="06C2";
$UTFPOS{"alifuphamza0"}="0623";
$UTFPOS{"aliflohamza0"}="0625";
$UTFPOS{"alifmadda0"}="0622";
$UTFPOS{"alifwasla0"}="0671";
$UTFPOS{"wawhamza0"}="0624";
$UTFPOS{"yahamza0"}="0626";
$UTFPOS{"hamza0"}="0621";
$UTFPOS{"keshideh0"}="0640";
$UTFPOS{"zwj0"}="200D";
$UTFPOS{"fatha"}="064E";
$UTFPOS{"vfatha"}="0670";
$UTFPOS{"kasra"}="0650";
$UTFPOS{"damma"}="064F";
$UTFPOS{"shadda"}="0651";
$UTFPOS{"sukun"}="0652";
$UTFPOS{"madda"}="0653";
$UTFPOS{"fathatan"}="064B";
$UTFPOS{"kasratan"}="064D";
$UTFPOS{"dammatan"}="064C";
$UTFPOS{"zero"}="0660";
$UTFPOS{"un"}="0661";
$UTFPOS{"deux"}="0662";
$UTFPOS{"trois"}="0663";
$UTFPOS{"quatre"}="0664";
$UTFPOS{"cinq"}="0665";
$UTFPOS{"six"}="0666";
$UTFPOS{"sept"}="0667";
$UTFPOS{"huit"}="0668";
$UTFPOS{"neuf"}="0669";
$UTFPOS{"question"}="061F";
$UTFPOS{"comma"}="060C";
$UTFPOS{"semicolon"}="061B";
foreach $utf (%UTFPOS) {
if ($POS{$utf} ne "") {
$UTF_GOTO{$POS{$utf}}=$UTFPOS{$utf};
}}

###read AFM file
open IN, "Dad$STYLE_.afm";
while (<IN>) {
if (m/^C ([0-9]+) ; WX ([0-9]+) ; N [^;]+ ; B ([0-9-]+) ([0-9-]+) ([0-9-]+) ([0-9-]+) ;/) {
$w=$2;
$h=$6;
$d=$4;
$HEX=sprintf("%X",$1 + 0);
$HEX=~s/^([0-9A-F])$/0\1/;
$WIDTH{$HEX}=$w/1000;
$HEIGHT{$HEX}=($h>$MAXHEIGHT?$MAXHEIGHT/1000:$h/1000);
if ($d != 0) { $DEPTH{$HEX}=-($d<$MAXDEPTH?$MAXDEPTH/1000:$d/1000); } else { $DEPTH{$HEX}="0.0"; }
}
}
close IN;

if ($STYLE eq "bold") { $thickness="0.111"; } 
elsif ($STYLE eq "mono") { $thickness="0.113"; } 
else { $thickness="0.072"; }

$PRELUDE="(OFMLEVEL D 0)
(FONTDIR TL)
(FAMILY YARABIC)
(FACE F MRR)
(CODINGSCHEME FONTSPECIFIC)
(DESIGNSIZE R 10.0)
(CHECKSUM H 9DCC4880)
(FONTDIMEN
   (SLANT R 0.000000)
   (SPACE R 0.333334)
   (STRETCH R 0.166667)
   (SHRINK R 0.111112)
   (XHEIGHT R 0.430555)
   (QUAD R 1.000003)
   (EXTRASPACE R 0.111112)
   (DEFAULTRULETHICKNESS R $thickness)
   )
(MAPFONT D 0
   (FONTNAME dadreal$STYLE)
   (FONTAT R 1.0)
   (FONTDSIZE R 10.0)
   )
(LIGTABLE
";
$PL_PRELUDE="(FAMILY DADREAL)
(CODINGSCHEME FONTSPECIFIC)
(DESIGNSIZE R 10.0)
(FONTDIMEN
   (SPACE R 0.333334)
   (STRETCH R 0.166667)
   (SHRINK R 0.111112)
   (XHEIGHT R 0.430555)
   (QUAD R 1.000003)
   (EXTRASPACE R 0.111112)
   )
(LIGTABLE
";

###write real PL file
open OUT, ">dadreal$STYLE.pl";
print OUT $PL_PRELUDE;
print OUT "   )\n";
foreach $i (0 .. 255) {
$i_hex=sprintf("%X",$i);
$i_hex=~s/^([0-9A-F])$/0\1/;
print OUT "(CHARACTER H $i_hex (COMMENT char$i_hex)
   (CHARWD R ".$WIDTH{$i_hex}.")
   (CHARHT R ".$HEIGHT{$i_hex}.")
   (CHARDP R ".$DEPTH{$i_hex}.")
   )
";
}
close OUT;
system("pltotf dadreal$STYLE.pl");

sub alter_LIGS {
my $label=shift;
my $LIG=shift;
my $right=shift;
my $result=shift;
if ($label ne "" and $LIG ne "" and $right ne "" and $result ne "") {
if ($LIGS{$label} =~ m|[/]?LIG[/>]*:$right:([0-9A-F]+)|) {
$LIGS{$label} =~ s|[/]?LIG[/>]*:$right:([0-9A-F]+)|$LIG:$right:$result|;
} else {
if ($LIGS{$label} ne "") {
$LIGS{$label} .= "#";
}
$LIGS{$label} .= "$LIG:$right:$result";
}
}
}

sub addoperation {
my $tmp=shift;
my $label=$POS{$tmp};
my $LIG=shift;
my $tmp=shift;
my $right=$POS{$tmp};
my $tmp=shift;
my $result=$POS{$tmp};
&alter_LIGS($label,$LIG,$right,$result);
}

sub addplusutfvowoperation {
my $tmp=shift;
my $label=$POS{$tmp};
my $LIG=shift;
my $tmp=shift;
my $right=$UTFPOS{$tmp};
my $tmp=shift;
my $result=$POS{$tmp};
&alter_LIGS($label,$LIG,$right,$result);
}

sub addutfoperation {
my $tmp=shift;
if ($tmp =~ m/^(.+?)([0-9])$/) { $labelc=$1; $labelp=$2; }
my $label=$POS{$tmp};
my $LIG=shift;
my $tmp=shift;
if ($tmp =~ m/^(.+?)([0-9])$/) { $rightc=$1; $rightp=$2; }
my $right=$POS{$tmp};
my $tmp=shift;
if ($tmp =~ m/^(.+?)([0-9])$/) { $resultc=$1; $resultp=$2; }
my $result=$POS{$tmp};

if ($labelp==0 and $UTFPOS{$labelc.$labelp} ne "") { $label=$UTF_GOTO{$label}; }
if ($rightp==0 and $UTFPOS{$rightc.$rightp} ne "") { $right=$UTF_GOTO{$right}; }
if ($resultp==0 and $UTFPOS{$resultc.$resultp} ne "") { $result=$UTF_GOTO{$result}; }

&alter_LIGS($label,$LIG,$right,$result);
}

sub addutfvowoperation {
my $tmp=shift;
my $label=$UTFPOS{$tmp};
my $labellow=$POS{$tmp};
my $tmp=shift;
my $vowelname=$tmp;
my $vow=$UTFPOS{$tmp};
my $vowlow=$POS{$tmp};

&alter_LIGS($label,"LIG",$vow,sprintf("%X",$DECALAGE{$vowelname}).$labellow);
}

# sub addutfccoperation {
# my $tmp=shift;
# my $label=$UTFPOS{$tmp};
# my $labellow=$POS{$tmp};
# my $tmp=shift;
# my $vowelname=$tmp;
# my $vow=$UTFPOS{$tmp};
# my $vowlow=$POS{$tmp};
# my $tmp=shift;
# my $labelb=$UTFPOS{$tmp};
# my $labelblow=$POS{$tmp};•••
# 
# &alter_LIGS(sprintf("%X",$DECALAGE{$vowelname}).$labellow,"/LIG",$labelb,$labelblow);
# }

##k0 + l0 - /LIG/ -> k0 - l0
##k0 + - LIG/ -> k1 - 
##- + l0 LIG -> l3
# foreach $lettera (@LETTERS) {
# if ($FORM{$lettera}==4) {
# foreach $letterb (@LETTERS) {
# &addoperation($lettera."0","/LIG/",$letterb."0","zwj0");
# }
# &addoperation($lettera."0","LIG/","zwj0",$lettera."1");
# }
# if ($FORM{$lettera}==4 or $FORM{$lettera}==2) {
# &addoperation("zwj0","LIG",$lettera."0",$lettera."3");
# }
# }
foreach $lettera (@LETTERS) {
&addoperation("zwj0","LIG",$lettera."0",$lettera."3");
&addutfoperation("zwj0","LIG",$lettera."0",$lettera."3");
}
&addoperation("zwj0","LIG","apos0","apos3");

foreach $lettera (@LETTERS) {
if ($FORM{$lettera}==4) {
&addoperation($lettera."0","LIG/","zwj0",$lettera."1");
&addoperation($lettera."3","LIG/","zwj0",$lettera."2");
&addutfoperation($lettera."0","LIG/","zwj0",$lettera."1");
&addutfoperation($lettera."3","LIG/","zwj0",$lettera."2");
&addoperation($lettera."0","LIG/","apos0",$lettera."1");
&addoperation($lettera."3","LIG/","apos0",$lettera."2");
&addoperation($lettera."0","LIG/","lam6",$lettera."1");
&addoperation($lettera."3","LIG/","lam6",$lettera."2");
&addoperation($lettera."2","/LIG","lam6","lam7");
&addoperation($lettera."1","/LIG","lam6","lam7");
&addutfoperation($lettera."0","LIG/","lam6",$lettera."1");
&addutfoperation($lettera."3","LIG/","lam6",$lettera."2");
&addutfoperation($lettera."2","/LIG","lam6","lam7");
&addutfoperation($lettera."1","/LIG","lam6","lam7");
}
elsif ($FORM{$lettera}==2) {
&addoperation($lettera."0","/LIG","zwj0","zwj3");
&addoperation($lettera."3","/LIG","zwj0","zwj3");
}
}
foreach $lettera (@LETTERS_NO_LAMS) {
if ($FORM{$lettera}==4) {
&addoperation($lettera."1","/LIG","apos0","apos3");
&addoperation($lettera."2","/LIG","apos0","apos3");
}
}
foreach $lettera (@LAMS) {
if ($FORM{$lettera}==4) {
&addoperation($lettera."1","/LIG","apos0","apos3");
&addoperation($lettera."2","/LIG","apos0","apos3");
&addoperation($lettera."0","LIG/","apos0",$lettera."4");
&addoperation($lettera."3","LIG/","apos0",$lettera."5");
&addoperation($lettera."4","/LIG>","apos0","apos4");
&addoperation($lettera."5","/LIG>","apos0","apos5");
}
}

foreach $lettera (@LETTERS_NO_LAMS) {
if ($FORM{$lettera}==4) {
foreach $letterb (@LETTERS_NO_ALIFS) {
if ($FORM{$letterb}==4 or $FORM{$letterb}==2) {
&addoperation($lettera."0","LIG/",$letterb."0",$lettera."1");
&addoperation($lettera."3","LIG/",$letterb."0",$lettera."2");
&addoperation($lettera."1","/LIG",$letterb."0",$letterb."3");
&addoperation($lettera."2","/LIG",$letterb."0",$letterb."3");
&addutfoperation($lettera."0","LIG/",$letterb."0",$lettera."1");
&addutfoperation($lettera."3","LIG/",$letterb."0",$lettera."2");
&addutfoperation($lettera."1","/LIG",$letterb."0",$letterb."3");
&addutfoperation($lettera."2","/LIG",$letterb."0",$letterb."3");
}
}
}
}
foreach $lettera (@LAMS) {
if ($FORM{$lettera}==4) {
foreach $letterb (@LETTERS_NO_ALIFS) {
if ($FORM{$letterb}==4 or $FORM{$letterb}==2) {
&addoperation($lettera."0","LIG/",$letterb."0",$lettera."1");
&addoperation($lettera."3","LIG/",$letterb."0",$lettera."2");
&addoperation($lettera."1","/LIG",$letterb."0",$letterb."3");
&addoperation($lettera."2","/LIG",$letterb."0",$letterb."3");
&addutfoperation($lettera."0","LIG/",$letterb."0",$lettera."1");
&addutfoperation($lettera."3","LIG/",$letterb."0",$lettera."2");
&addutfoperation($lettera."1","/LIG",$letterb."0",$letterb."3");
&addutfoperation($lettera."2","/LIG",$letterb."0",$letterb."3");
}
}
}
}
foreach $lettera (@LETTERS_NO_LAMS) {
if ($FORM{$lettera}==4) {
foreach $letterb (@ALIFS) {
if ($FORM{$letterb}==4 or $FORM{$letterb}==2) {
&addoperation($lettera."0","LIG/",$letterb."0",$lettera."1");
&addoperation($lettera."3","LIG/",$letterb."0",$lettera."2");
&addoperation($lettera."1","/LIG",$letterb."0",$letterb."3");
&addoperation($lettera."2","/LIG",$letterb."0",$letterb."3");
&addutfoperation($lettera."0","LIG/",$letterb."0",$lettera."1");
&addutfoperation($lettera."3","LIG/",$letterb."0",$lettera."2");
&addutfoperation($lettera."1","/LIG",$letterb."0",$letterb."3");
&addutfoperation($lettera."2","/LIG",$letterb."0",$letterb."3");
}
}
}
}
foreach $lettera (@LAMS) {
foreach $letterb (@ALIFS) {
&addoperation($lettera."0","LIG/",$letterb."0",$lettera."4");
&addoperation($lettera."3","LIG/",$letterb."0",$lettera."5");
&addoperation($lettera."4","/LIG>",$letterb."0",$letterb."4");
&addoperation($lettera."5","/LIG>",$letterb."0",$letterb."5");
&addutfoperation($lettera."0","LIG/",$letterb."0",$lettera."4");
&addutfoperation($lettera."3","LIG/",$letterb."0",$lettera."5");
&addutfoperation($lettera."4","/LIG>",$letterb."0",$letterb."4");
&addutfoperation($lettera."5","/LIG>",$letterb."0",$letterb."5");
}
}

foreach $letter (@LETTERS) {
foreach $vowel ("fatha","kasra","damma","sukun","shadda","madda","vfatha") {
&addutfvowoperation($letter."0",$vowel);
# foreach $letterb (@LETTERS) {
# if ($FORM{$letter}==4 and $FORM{$letterb}==4) {•••
# &addutfccoperation($letter."0",$vowel,"LIG/",$letterb."0",$letter."1");
# &addutfccoperation($letter."1",$vowel,"/LIG",$letterb."0",$letterb."3");
# }
# }
}
}

##encoding operations
# &operation("'","LIG","a","alifuphamza0");	ä
# &operation("'","LIG","i","aliflohamza0");	ï
# &operation("'","LIG","u","wawhamza0");		ü
# &operation("'","LIG","I","yahamza0");		ÿ
# &operation("'","LIG","A","alifmadda0");		Â
&addoperation("lam6","/LIG","lam6","lam8");		
&addoperation("lam7","/LIG","lam6","lam8");		
&addoperation("lam8","/LIG","ha0","ha4");		
&addoperation("apos0","LIG","ba0","banodots0");		
&addoperation("apos3","LIG","ba0","banodots3");		
&addoperation("apos0","LIG","nun0","nunnodots0");		
&addoperation("apos3","LIG","nun0","nunnodots3");		
&addoperation("apos0","LIG","fa0","fanodots0");		
&addoperation("apos3","LIG","fa0","fanodots3");		
&addoperation("apos0","LIG","qaf0","qafnodots0");		
&addoperation("apos3","LIG","qaf0","qafnodots3");		
&addoperation("apos0","LIG","fatha","alifuphamza0");		
&addoperation("apos3","LIG","fatha","alifuphamza3");		
&addoperation("apos4","LIG","fatha","alifuphamza4");		
&addoperation("apos5","LIG","fatha","alifuphamza5");		
&addoperation("apos0","LIG","kasra","aliflohamza0");		
&addoperation("apos3","LIG","kasra","aliflohamza3");		
&addoperation("apos4","LIG","kasra","aliflohamza4");		
&addoperation("apos5","LIG","kasra","aliflohamza5");		
&addoperation("apos0","LIG","alif0","alifmadda0");		
&addoperation("apos3","LIG","alif0","alifmadda3");		
&addoperation("apos4","LIG","alif0","alifmadda4");		
&addoperation("apos5","LIG","alif0","alifmadda5");		
&addoperation("apos0","LIG","damma","wawhamza0");		
&addoperation("apos3","LIG","damma","wawhamza3");		
&addoperation("apos0","LIG","alifmaqsura0","yahamza0");		
&addoperation("apos3","LIG","alifmaqsura0","yahamza3");		
&addoperation("alif0","LIG","aster","alifwasla0");		
&addoperation("alif3","LIG","aster","alifwasla3");		
&addoperation("ta0","LIG","aster","tamarbuta0");
&addoperation("ta1","LIG","aster","tamarbuta1");		
&addoperation("ta2","LIG","aster","tamarbuta2");		
&addoperation("ta3","LIG","aster","tamarbuta3");		
&addoperation("ta0","LIG","ha0","tha0");
&addoperation("ta1","LIG","ha0","tha1");
&addoperation("ta2","LIG","ha0","tha2");
&addoperation("ta3","LIG","ha0","tha3");
&addoperation("dal0","LIG","ha0","dhal0");
&addoperation("dal3","LIG","ha0","dhal3");
# &addoperation("za0","LIG","ha0","zhe0");
# &addoperation("za3","LIG","ha0","zhe3");
# &addoperation("kaf0","LIG","ha0","khe0");
# &addoperation("kaf1","LIG","ha0","khe1");
# &addoperation("kaf2","LIG","ha0","khe2");
# &addoperation("kaf3","LIG","ha0","khe3");
&addoperation("lam0","LIG","quatre","lam4");
&addoperation("lam3","LIG","cinq","lam5");
&addoperation("lam1","LIG","quatre","lam4");
&addoperation("lam2","LIG","cinq","lam5");
&addoperation("alif3","LIG","quatre","alif4");
&addoperation("alif3","LIG","cinq","alif5");
&addoperation("alifuphamza3","LIG","quatre","alifuphamza4");
&addoperation("alifuphamza3","LIG","cinq","alifuphamza5");
&addoperation("aliflohamza3","LIG","quatre","aliflohamza4");
&addoperation("aliflohamza3","LIG","cinq","aliflohamza5");
&addoperation("alifmadda3","LIG","quatre","alifmadda4");
&addoperation("alifmadda3","LIG","cinq","alifmadda5");
&addoperation("alifwasla3","LIG","quatre","alifwasla4");
&addoperation("alifwasla3","LIG","cinq","alifwasla5");
&addoperation("sin0","LIG","ha0","shin0");
&addoperation("sin1","LIG","ha0","shin1");
&addoperation("sin2","LIG","ha0","shin2");
&addoperation("sin3","LIG","ha0","shin3");
# &addoperation("gaf0","LIG","ha0","ghayn0");
# &addoperation("gaf1","LIG","ha0","ghayn1");
# &addoperation("gaf2","LIG","ha0","ghayn2");
# &addoperation("gaf3","LIG","ha0","ghayn3");
&addoperation("plus","LIG","fatha","shaddafatha");
&addoperation("plus","LIG","kasra","shaddakasra");
&addoperation("plus","LIG","damma","shaddadamma");
&addoperation("fatha","LIG","N","fathatan");
&addoperation("kasra","LIG","N","kasratan");
&addoperation("damma","LIG","N","dammatan");
&addoperation("fatha","LIG","aster","vfatha");
&addoperation("vfatha","LIG","aster","madda");
&addoperation("shaddafatha","LIG","aster","shaddavfatha");
&addoperation("shaddavfatha","LIG","aster","shaddamadda");
&addoperation("shaddafatha","LIG","N","shaddafathatan");
&addoperation("shaddakasra","LIG","N","shaddakasratan");
&addoperation("shaddadamma","LIG","N","shaddadammatan");
&addoperation("zwj0","LIG","zwj0","keshideh0");
&addoperation("zwj3","LIG","zwj0","keshideh3");
&addoperation("keshideh0","/LIG>","zwj0","keshideh0");
&addoperation("keshideh3","/LIG>","zwj0","keshideh3");

if (-e "dad$STYLE.adjust") {
open ADJ, "dad$STYLE.adjust";
while (<ADJ>) {
if (m/^KRN ([^ ]+) ([^ ]+) ([0-9.-]+)/) {
$l=$1;
$r=$2;
$k=$3;
if ($POS{$l} ne "" and $POS{$r} ne "") {
if ($LIGS{$POS{$l}} eq "") {
$LIGS{$POS{$l}} = "KRN:".$POS{$r}.":".$k;
} else {
$LIGS{$POS{$l}} .= "#KRN:".$POS{$r}.":".$k;
}
}
}
elsif (m/^ADJ ([^ ]+) ([^ ]+) ([0-9.-]+) ([0-9.-]+)/) {
$l=$1;
$r=$2;
$h=$3;
$v=$4;
if ($POS{$l} ne "" and ($POS{$r} ne "" or $r eq "#UVOWEL#" or $r eq "#LVOWEL#")) {
$HADJUST{"$l:$r"}=$h;
$VADJUST{"$l:$r"}=$v;
}
}
}
close ADJ;
}

%ALREADY_OUTPUT=();

sub clone_LIGS {
my $orig=shift;
my $diac=shift;
my $decalage=shift;

my $new=$orig."+".$diac;

foreach $i ("0","1","2","3","4","5","6","7","8") {
if ($POS{$orig.$i} ne "") {


###############
$POS{$new.$i}=sprintf("%X",hex($POS{$orig.$i})+$decalage*256);

my @lesLIGS=split(/#/,$LIGS{$POS{$orig.$i}});
my @tmp=();
foreach $laLIG (@lesLIGS) {
($a,$b,$c)=split(/:/,$laLIG);

if ($a eq "LIG/" and hex($b)<256) { $c=sprintf("%X",hex($c)+$decalage*256); }
push @tmp, "$a:$b:$c";
#if ($b eq "69" and $c eq "A6C") { print STDERR "zut"; }
if ($UTF_GOTO{$b} ne "") {
if ($decalage==8 and ($diac eq "fatha" or $diac eq "kasra" or $diac eq "damma" or $diac eq "fathatan" or $diac eq "kasratan" or $diac eq "dammatan" or $diac eq "vfatha" or $diac eq "damma")) {}
else { push @tmp, "$a:".$UTF_GOTO{$b}.":$c"; }
#if ($UTF_GOTO{$b} eq "0650" and $c eq "26C") { print STDERR "$b $c yes"; }
}
}

###############
if ($diac eq "fathatan" or $diac eq "kasratan" or $diac eq "dammatan") {
$new_without_tan=$new;
$new_without_tan=~s/tan$//;
&addoperation($new_without_tan.$i,"LIG","N",$new.$i);
}
elsif ($diac eq "shaddafathatan" or $diac eq "shaddakasratan" or $diac eq "shaddadammatan") {
$new_without_tan=$new;
$new_without_tan=~s/tan$//;
&addoperation($new_without_tan.$i,"LIG","N",$new.$i);
$diac_without_shadda=$diac;
$diac_without_shadda=~s/^shadda//;
&addplusutfvowoperation($orig."+"."shadda".$i,"LIG",$diac_without_shadda,$new.$i);
}
elsif ($diac eq "shaddafatha" or $diac eq "shaddakasra" or $diac eq "shaddadamma") {
$diac_without_shadda=$diac;
$diac_without_shadda=~s/^shadda//;
&addoperation($orig."+"."shadda".$i,"LIG",$diac_without_shadda,$new.$i);
&addplusutfvowoperation($orig."+"."shadda".$i,"LIG",$diac_without_shadda,$new.$i);
}
elsif ($diac eq "shaddavfatha") {
&addoperation($orig."+"."shaddafatha".$i,"LIG","aster",$orig."+"."shaddavfatha".$i);
&addplusutfvowoperation($orig."+"."shadda".$i,"LIG","vfatha",$new.$i);
}
elsif ($diac eq "vfatha") {
&addoperation($orig."+"."fatha".$i,"LIG","aster",$orig."+"."vfatha".$i);
}
elsif ($diac eq "madda") {
&addoperation($orig."+"."vfatha".$i,"LIG","aster",$orig."+"."madda".$i);
}
elsif ($diac eq "shaddamadda") {
&addoperation($orig."+"."shaddavfatha".$i,"LIG","aster",$orig."+"."shaddamadda".$i);
&addplusutfvowoperation($orig."+"."shadda".$i,"LIG","madda",$new.$i);
}
###############

$LIGS{$POS{$new.$i}}=join("#",@tmp);
###############


}
}
}


$UVOWEL{"fatha"}=1;
$UVOWEL{"damma"}=1;
$LVOWEL{"kasra"}=1;
$UVOWEL{"fathatan"}=1;
$UVOWEL{"dammatan"}=1;
$LVOWEL{"kasratan"}=1;
$UVOWEL{"shaddafatha"}=1;
$UVOWEL{"shaddadamma"}=1;
$UVOWEL{"shaddakasra"}=1;
$UVOWEL{"shaddafathatan"}=1;
$UVOWEL{"shaddadammatan"}=1;
$UVOWEL{"shaddakasratan"}=1;
$UVOWEL{"sukun"}=1;
$UVOWEL{"shadda"}=1;
$UVOWEL{"madda"}=1;
$UVOWEL{"vfatha"}=1;
$UVOWEL{"shaddavfatha"}=1;
$UVOWEL{"shaddamadda"}=1;

sub buildchar_one {
my $base=shift;
my $form=shift;
my $diac=shift;
my $decalage=shift;
my $position=sprintf("%X",hex($POS{$base.$form})+$decalage*256);
my $res="";

if ($POS{"$base$form"} ne "") {
$POS{"$base+$diac$form"}=$position;
&addoperation("$base$form","LIG",$diac,"$base+$diac$form");
&addplusutfvowoperation("$base$form","LIG",$diac,"$base+$diac$form");
$res="(CHARACTER H $position (COMMENT $base+$diac$form)
   (CHARWD R ".$WIDTH{$POS{$base.$form}}.")
   (CHARHT R ".$HEIGHT{$POS{$base.$form}}.")
   (CHARDP R ".$DEPTH{$POS{$base.$form}}.")
   (MAP
      (SELECTFONT D 0)
";

if ($UVOWEL{$diac}==1 and ($HADJUST{"$base$form:#UVOWEL#"} ne "" or $VADJUST{"$base$form:#UVOWEL#"} ne "")) {
$HADJUST{"$base$form:$diac"}=$HADJUST{"$base$form:#UVOWEL#"};
$VADJUST{"$base$form:$diac"}=$VADJUST{"$base$form:#UVOWEL#"};
}
if ($LVOWEL{$diac}==1 and ($HADJUST{"$base$form:#LVOWEL#"} ne "" or $VADJUST{"$base$form:#LVOWEL#"} ne "")) {
$HADJUST{"$base$form:$diac"}=$HADJUST{"$base$form:#LVOWEL#"};
$VADJUST{"$base$form:$diac"}=$VADJUST{"$base$form:#LVOWEL#"};
}

$res.=
"      (PUSH)
      (SETCHAR H ".$POS{$base.$form}.")
      (POP)
";
if ($HADJUST{"$base$form:$diac"} ne "" or $VADJUST{"$base$form:$diac"} ne "")
{
$res.=
"      (PUSH)
      (MOVERIGHT R ".($HADJUST{"$base$form:$diac"}/1000).")
      (MOVEUP R ".($VADJUST{"$base$form:$diac"}/1000).")
      (SETCHAR H ".$POS{$diac}.")
      (POP)
"; } else {
$res.="      (SETCHAR H ".$POS{$diac}.")
"; }
$res.="      )
   )
";
}
}

foreach $utf (sort keys %UTFPOS) {
if ($WIDTH{$POS{$utf}} ne "") {
$BUILD .= "(CHARACTER H ".$UTFPOS{$utf}." (COMMENT char".$UTFPOS{$utf}.")
   (CHARWD R ".$WIDTH{$POS{$utf}}.")
   (CHARHT R ".$HEIGHT{$POS{$utf}}.")
   (CHARDP R ".$DEPTH{$POS{$utf}}.")
   (MAP
      (SELECTFONT D 0)
      (SETCHAR H ".$POS{$utf}.")
      )
   )
";
}
}

foreach $vowel ("fatha","kasra","damma","fathatan","kasratan","dammatan","sukun","shadda","shaddafatha","shaddakasra","shaddadamma","shaddafathatan","shaddakasratan","shaddadammatan",
"vfatha","shaddavfatha","madda","shaddamadda") #,"shadda","sukun","madda","shaddafatha","shaddakasra","shaddadamma","shaddafathatan","shaddakasratan","shaddadammatan") 
{
foreach $letter (@LETTERS_NO_LAMS_NO_ALIFS) {
if ($FORM{$letter}==4) {
$BUILD .= &buildchar_one($letter,"0",$vowel,$DECALAGE{$vowel});
$BUILD .= &buildchar_one($letter,"1",$vowel,$DECALAGE{$vowel});
$BUILD .= &buildchar_one($letter,"2",$vowel,$DECALAGE{$vowel});
$BUILD .= &buildchar_one($letter,"3",$vowel,$DECALAGE{$vowel});
$BUILD .= &buildchar_one($letter,"4",$vowel,$DECALAGE{$vowel});
} elsif ($FORM{$letter}==2) {
$BUILD .= &buildchar_one($letter,"0",$vowel,$DECALAGE{$vowel});
$BUILD .= &buildchar_one($letter,"3",$vowel,$DECALAGE{$vowel});
} elsif ($FORM{$letter}==1) {
$BUILD .= &buildchar_one($letter,"0",$vowel,$DECALAGE{$vowel});
}
&clone_LIGS($letter,$vowel,$DECALAGE{$vowel});
}
foreach $letter (@LAMS) {
$BUILD .= &buildchar_one($letter,"0",$vowel,$DECALAGE{$vowel});
$BUILD .= &buildchar_one($letter,"1",$vowel,$DECALAGE{$vowel});
$BUILD .= &buildchar_one($letter,"2",$vowel,$DECALAGE{$vowel});
$BUILD .= &buildchar_one($letter,"3",$vowel,$DECALAGE{$vowel});
$BUILD .= &buildchar_one($letter,"4",$vowel,$DECALAGE{$vowel});
$BUILD .= &buildchar_one($letter,"5",$vowel,$DECALAGE{$vowel});
$BUILD .= &buildchar_one($letter,"6",$vowel,$DECALAGE{$vowel});
$BUILD .= &buildchar_one($letter,"7",$vowel,$DECALAGE{$vowel});
$BUILD .= &buildchar_one($letter,"8",$vowel,$DECALAGE{$vowel});
&clone_LIGS($letter,$vowel,$DECALAGE{$vowel});
}
foreach $letter (@ALIFS) {
$BUILD .= &buildchar_one($letter,"0",$vowel,$DECALAGE{$vowel});
$BUILD .= &buildchar_one($letter,"3",$vowel,$DECALAGE{$vowel});
$BUILD .= &buildchar_one($letter,"4",$vowel,$DECALAGE{$vowel});
$BUILD .= &buildchar_one($letter,"5",$vowel,$DECALAGE{$vowel});
&clone_LIGS($letter,$vowel,$DECALAGE{$vowel});
}
$BUILD .= &buildchar_one("hamza","0",$vowel,$DECALAGE{$vowel});
&clone_LIGS("hamza",$vowel,$DECALAGE{$vowel});
}

# sub printLIGS {
# my $res="";
# my $letter=shift;
# if ($ALREADY_OUTPUT{$POS{$letter}} ne "") { return ""; }
# else { $ALREADY_OUTPUT{$POS{$letter}}=1;
# if ($LIGS{$POS{$letter}} ne "") {
# @lesLIGS=split(/#/,$LIGS{$POS{$letter}});
# $res .= "   (LABEL H ".$POS{$letter}.")\n";
# foreach $uneLIG (@lesLIGS) {
# ($LIG,$right,$result)=split(/:/,$uneLIG);
# $res .= "   ($LIG H $right H $result)\n";
# }
# $res .= "   (STOP)\n";
# }
# return $res;
# }
# }

%BIG=();
foreach $key (sort keys %LIGS) {
$BIG{$key."|".$LIGS{$key}}=1;
}
%LIGS=();
foreach $entry (sort keys %BIG) {
($left,$right)=split(/\|/,$entry);
$LIGS{$left}=$right;
}

sub erase_ligature {
my $left=shift;
my $right=shift;
$LIS{$left} =~ /#$right:[^:]+:[^#:]+/g;
$LIS{$left} =~ /^$right:[^:]+:[^#:]+/;
}

&erase_ligature("0644","0644");
&alter_LIGS("0644","LIG","0644","F7");

foreach $letterb (@ALIFS) {
&addutfoperation("ll0","LIG/",$letterb."0","ll5");
&addutfoperation("ll5","/LIG>",$letterb."0",$letterb."5");
}

foreach $letterb (@LETTERS_NO_ALIFS) {
if ($letterb ne "ha") {
if ($FORM{$letterb}==4 or $FORM{$letterb}==2) {
&addutfoperation("ll0","LIG/",$letterb."0","ll1");
&addutfoperation("ll1","/LIG",$letterb."0",$letterb."3");
}
}
}
&addutfoperation("ll0","LIG","ha0","LLh0");

###write dad.ovp
open OUT, ">dad$STYLE.ovp";
print OUT $PRELUDE;
foreach $key (sort keys %LIGS) {
if ($key ne "" and $LIGS{$key} ne "") {
@lesLIGS=split(/#/,$LIGS{$key});
$res .= "   (LABEL H $key)\n";
foreach $uneLIG (@lesLIGS) {
($LIG,$right,$result)=split(/:/,$uneLIG);
if ($LIG eq "KRN") {
$result /= 1000;
$res .= "   ($LIG H $right R $result)\n";
} else {
$res .= "   ($LIG H $right H $result)\n";
}
}
$res .= "   (STOP)\n";
}
}
print OUT $res;

# print OUT &printLIGS("zwj0");
# foreach $letter (@LETTERS_NO_LAMS_NO_ALIFS) {
# if ($FORM{$letter}==4) {
# print OUT &printLIGS($letter."0");
# print OUT &printLIGS($letter."1");
# print OUT &printLIGS($letter."2");
# print OUT &printLIGS($letter."3");
# } elsif ($FORM{$letter}==2) {
# print OUT &printLIGS($letter."0");
# print OUT &printLIGS($letter."3");
# } elsif ($FORM{$letter}==1) {
# print OUT &printLIGS($letter."0");
# }
# }
# foreach $letter (@LAMS) {
# print OUT &printLIGS($letter."0");
# print OUT &printLIGS($letter."1");
# print OUT &printLIGS($letter."2");
# print OUT &printLIGS($letter."3");
# print OUT &printLIGS($letter."4");
# print OUT &printLIGS($letter."5");
# }
# foreach $letter (@ALIFS) {
# print OUT &printLIGS($letter."0");
# print OUT &printLIGS($letter."3");
# print OUT &printLIGS($letter."4");
# print OUT &printLIGS($letter."5");
# }
# foreach $diac (@DIACS) {
# print OUT &printLIGS($diac);
# }
# foreach $diac (@vDIACS) {
# print OUT &printLIGS($diac."tan");
# print OUT &printLIGS("shadda".$diac);
# print OUT &printLIGS("shadda".$diac."tan");
# }


print OUT "   )\n"; ###END OF LIGTABLE

foreach $i (0 .. 255) {
$i_hex=sprintf("%X",$i);
$i_hex=~s/^([0-9A-F])$/0\1/;
print OUT "(CHARACTER H $i_hex (COMMENT char$i_hex)
   (CHARWD R ".$WIDTH{$i_hex}.")
   (CHARHT R ".$HEIGHT{$i_hex}.")
   (CHARDP R ".$DEPTH{$i_hex}.")
   (MAP
      (SELECTFONT D 0)
      (SETCHAR H $i_hex)
      )
   )
";
}


print OUT $BUILD;




close OUT;
system("cp Dad$STYLE_.pfa /hom/yannis/texmf-static/fonts/pfb/");
system("wovp2ovf dad$STYLE.ovp");

open IN, "dad$STYLE.ovp";
while (<IN>) {
if (m/LIG[^T]/) { $countLIG++; }
if (m|/LIG/|) { $countSMA++; }
elsif (m|/LIG|) { $countSMA++; }
elsif (m|LIG/|) { $countSMA++; }
if (m/KRN/) { $countKRN++; }
if (m/CHARACTER/) { $countCHA++; }
}
print "$countLIG ligatures ($countSMA smart), $countKRN kerns, $countCHA characters\n";
close IN;
