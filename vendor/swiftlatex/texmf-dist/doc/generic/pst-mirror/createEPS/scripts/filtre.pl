#!/usr/bin/perl

my $DimMax = 6; # Dimension maximale, en cm.
my $cm     = 28.3464567; # Le centimètre, en points postscript

my @Bbox   = ();

my $option = $ARGV[0];

# ------------------------------------------------------------------------------
# Existence du fichier
my $Fichier = $ARGV[1];
-f $Fichier or die "Fichier <$Fichier> introuvable !\n";

# ------------------------------------------------------------------------------
# Adaptation du fichier
{
  my $ps = &FichierListe($Fichier);
  my $n  = 0;
  my $p  = 0;
  my $q  = 0;
  my $r  = 0;
  foreach (@$ps) {
    # On comment les lignes faisant référence aux fontes
    /pstoedit\.newfont/ and $_ = "%%>>> $_";
    # Numero de ligne de %%Page (début de la description)
    not($p) and /^\%\%Page: 1 1/ and $p = $n;
    # Numéro de ligne de %%BoundingBox: (atend)
    /^\%\%BoundingBox\: \(atend\)/ and $q = $n;
    # Acquisition de la BoundingBox
    /^\%\%BoundingBox\: ([\d\.-]+) ([\d\.-]+) ([\d\.-]+) ([\d\.-]+)/ and
      &setBbox($1,$2,$3,$4) and $r = $n;
    # Incrémentation
    $n++;
  }
  my $t     = &getTranslate();
  my $s     = &getScale();
  if ($option == 1) {
    $$ps[$p] .= "\n$DimMax $cm mul $s $t";
  } elsif ($option == 2) {
    $$ps[$q] = $$ps[$r];
    $$ps[$r] = "%%>>";
  }
  open PS, "> $Fichier"; print PS join("\n", @$ps); close PS;
}

# ==============================================================================
# === Manipulations de la BoundingBox
# ==============================================================================

# ------------------------------------------------------------------------------
# Acquisition de la BoundingBox
sub setBbox {
  @Bbox = @_;
  return 1;
}

# ------------------------------------------------------------------------------
# Translation
sub getTranslate {
  my $tx = "$Bbox[2] $Bbox[0] add 2 div neg";
  my $ty = "$Bbox[3] $Bbox[1] add 2 div neg";
  return "$tx $ty translate";
}

# ------------------------------------------------------------------------------
# Scale
sub getScale {
  my $lx = $Bbox[2] - $Bbox[0];
  my $ly = $Bbox[3] - $Bbox[1];
  my $m  = $lx; $m = $ly if $ly > $lx;
  return "$m div dup scale";
}

# ==============================================================================
# === Contenu d'un fichier et éléments du nom
# ==============================================================================

# ------------------------------------------------------------------------------
# Contenu sous forme d'une liste de lignes
sub FichierListe {
  my $f = shift;
  open(FICH, $f) or die "Le fichier $f est introuvable !\n";
  my @l = <FICH>;
  close FICH;
  chomp @l;
  return \@l;
}

# ------------------------------------------------------------------------------
# Contenu d'un seul tenant
sub FichierScalaire {
  my $f = shift;
  local $/;
  open(FICH, $f) or die "Le fichier $f est introuvable !\n";
  my $c = <FICH>;
  close FICH;
  return $c;
}

# ------------------------------------------------------------------------------
# Nom, Répertoire et Extension d'un fichier
sub FichierNRE {
  my $f = shift;
  use File::Basename;
  my ($n, $r, $e) = fileparse($f,qw{\..*});
  $e =~ s/^\.//;
  return ($n, $r, $e);
}



