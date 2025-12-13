#!/usr/bin/perl
#
#This perl install all the mandatory files for the use
#of GFS Didot fonts in a texmf directory.
#
#This program has 2 parameters:
#      1) The name of the root directory containing the Didot
#         distribution.
#      2) The name of the texmf tree root directory where the files should
#         be installed. 
use strict;
use warnings;
use File::Copy qw(copy);
use File::Path qw(make_path remove_tree);
use File::Spec::Functions;
use constant false => 0;
use constant true  => 1;

#If this variable is set to true, the output is a little more
#verbose
my $DEBUG=false;

#Number of arguments to this program
my $NB_ARGS=scalar @ARGV;

#OS where the program runs
#MSWin32 on Windows
#linux   on Linux
my $OS = $^O;
my $WINDOWS_OS="MSWin32";
my $LINUX_OS="linux";

#This constant is the name of placeholder for describing
#the root of a TEXMF tree.
my $ROOT_TEXMF="__ROOT_TEXMF__";
#A similar constant but for the tree of the GFS Didot distribution
my $ROOT_DISTRIB="__GFSDIDOT_DISTRIB__";
#This array contain the list of the directories which should
#be populated with the files of the GFS Didot distribution.
#inside a TEXMF tree.
my @TEXMF_DIDOT=(catfile($ROOT_TEXMF,"fonts","afm","GFS","Didot"),
                 catfile($ROOT_TEXMF,"doc","latex","GFS","Didot"),
                 catfile($ROOT_TEXMF,"fonts","enc","dvips","GFS","Didot"),
                 catfile($ROOT_TEXMF,"fonts","map","dvips","GFS","Didot"),
                 catfile($ROOT_TEXMF,"tex","latex","GFS","Didot"),
                 catfile($ROOT_TEXMF,"fonts","tfm","GFS","Didot"),
                 catfile($ROOT_TEXMF,"fonts","type1","GFS","Didot"),
                 catfile($ROOT_TEXMF,"fonts","source","public","GFS","Didot","vpl"),
                 catfile($ROOT_TEXMF,"fonts","vf","GFS","Didot"));
#List of the directories which should be copied
#from the GFSDidot distribution directory to the
#TEXMF directory. This list should match
#the list of the constant "@TEXMF_DIDOT".
my @GFSDIDOT_DISTRIB=(catfile($ROOT_DISTRIB,"afm"),
                      catfile($ROOT_DISTRIB,"doc"),
                      catfile($ROOT_DISTRIB,"enc"),
                      catfile($ROOT_DISTRIB,"map"),
                      catfile($ROOT_DISTRIB,"tex"),
                      catfile($ROOT_DISTRIB,"tfm"),
                      catfile($ROOT_DISTRIB,"type1"),
                      catfile($ROOT_DISTRIB,"vpl"),
                      catfile($ROOT_DISTRIB,"vf")); 
#Here is the list of file names which should not be copied
#from source dir to destination dir.
#
#The command readdir returns all the file names including
#"." and ".." (current directory and upper directory) which
#should be excluded to avoid infinite recursion.
my @FILE_TO_EXCLUDE=("CVS",
                     ".",
                     "..");
                    
#
#
#------------------------Functions-----------------------------
#Normally no change should be made beyond this line
#
#

#The following function will detect if the TeX used is MikTeX
#(the standrad TeX under Windows)
#
# The function has no parameter
#
# The function returns true if MikTeX is used under Windows
# and false otherwise
#
sub isMikTeX{
   if ($OS ne $WINDOWS_OS){
      return false;
   }

   open(my $fh, '-|', 'tex --version') or die "Can not run the command 'tex --version' $!\n";
   while (my $line = <$fh>) {
      if ($line =~ /.*miktex.*/i){
        return true;
      }
  }
  return false;
}

#The following function modify a list of directories
#to replace the variable part of the directory with
#the actual path.
#
#This function has 3 parameters:
#      1) A reference on an array containing the the list of directories
#      2) The placeholder string used for the variable part
#      3) Its actual value
#
#The function returns an array with all the diretory's name converted
#to the actual names.
sub realDirNames {
   my ($dirList,$toBeReplaced,$value)=@_;

   my @dirNames;

   foreach my $line (@$dirList){
       $line =~ s/$toBeReplaced/$value/;
       #remove double slash (//) in directory names.
       $line =~ s/\/\//\//g;
       push(@dirNames,$line);
   };

   return @dirNames;
}

#The following function copy all the files from a directory
#to a destination directory by copying all the subdirectories.
#
#The function has 2 parameters:
#      1)The name of the source directory
#      2)The name of destination directory
sub copyDir {
   my ($srcDir,$dstDir)=@_;

   my $errMsg;
   my $rc;

    if ( ! -d $srcDir ){
       die "The source directory '$srcDir' is not a directory.\n"
    }
    if ( ! -d $dstDir ){
       die "The destination directory '$dstDir' is not a directory.\n"
    }

    opendir(my $dh, $srcDir) || die "Can't open $srcDir: $!";
    while (my $currEntry=readdir $dh) {
      $errMsg="";
      my $fullCurrEntry=catfile($srcDir,$currEntry);
      if ( ! -d $fullCurrEntry){
        my $srcFile=$fullCurrEntry;
        my $dstFile=catfile($dstDir,$currEntry);
        $errMsg="The copy of '$srcFile' to '$dstFile'";
        $rc=copy($srcFile,$dstFile) if ! grep {$_ eq $currEntry } @FILE_TO_EXCLUDE;
        if ($rc){
           print "$errMsg has suceeded.\n" if $DEBUG;
        }
        else{
           print "$errMsg has failed (code: $!).\n";
        }
      } 
      else{
        #Not a file, the subdirectory should be created and
        #copied if it is not in the list of excluded files.
        if ( ! grep {$_ eq $currEntry } @FILE_TO_EXCLUDE){
           my $newSrcDir=$fullCurrEntry;
           my $newDstDir=catfile($dstDir,$currEntry);

           $errMsg="The creation of directory '$newDstDir'";
           $rc=make_path($newDstDir);
           if ($rc){
              print "$errMsg has suceeded.\n";
           }
           else{
              print "$errMsg has failed (code: $!).\n";
           }
           copyDir($newSrcDir,$newDstDir);
        }
      }
    } 
    closedir($dh);
}

#
#---------------------------------Main program----------------------------
#

if ( $NB_ARGS != 2 ) {
   print "This script installs all the necessary files for the use of the GFS Didot fonts\n";
   print "in a texmf tree.\n";
   print "$0 has 2 arguments:\n";
   print "   1) The name of the directory containing the GFS Didot distribution.\n";
   print "   2) The name of the root directory of the texmf tree where the files\n";
   print "      should be installed\n";
   exit 1
}


my $distribDir=$ARGV[0];
my $texmfDir=$ARGV[1];

my @dstDirs=realDirNames(\@TEXMF_DIDOT,$ROOT_TEXMF,$texmfDir);
my @srcDirs=realDirNames(\@GFSDIDOT_DISTRIB,$ROOT_DISTRIB,$distribDir);
my $i;
my $errMsg;
my $rc;

if ((scalar @TEXMF_DIDOT) != (scalar @GFSDIDOT_DISTRIB)){
     die "There are not the same number of source and destination directories.\n";
}

#Create directories in TEXMF tree
foreach my $line (@dstDirs){
    if (-e $line){
       if (-d $line){
         remove_tree($line) or die "The directory '$line' can not be removed $!\n";
       }
       else{
         unlink($line) or die "The file '$line' can not be removed $!\n";
       }
    };
    make_path($line);
}
#Now copy the different source directories.
$i=0;
foreach my $dir (@srcDirs){
    my $dstDir=$dstDirs[$i];

    copyDir($dir,$dstDir);
    print "The source directory '$dir' has been copied to the directory '$dstDir'.\n";
    $i += 1;
}

my $TeXcmd;
#The TeX command to include the new file in TeXMF
if (isMikTeX()){
   #MikTeX does not allow the command "mktexlsr" with an argument
   $TeXcmd="mktexlsr";
}
else {
   $TeXcmd="mktexlsr $texmfDir"; 
}
$rc=system($TeXcmd) ;
if ($rc != 0){
   die "The command '$TeXcmd' has failed: $!\n";
}

if (isMikTeX()){
   #MikTeX does not allow the command "updmap-sys" with an argument
   #To configure the file 'updmap.cfg' on MikTeX one has to pass
   #the command: initexmf --edit-config-file updmap
   $TeXcmd="updmap --verbose";
}
else {
   $TeXcmd="updmap-sys";
}
$rc=system($TeXcmd) ;
if ($rc != 0){
   die "The command '$TeXcmd'  has failed: $!\n";
}

exit 0;
