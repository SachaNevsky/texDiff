{
  p=1
}
/\\indexspace|\\begin\{theindex|\\end\{theindex/ { 
  p=0
}
/\\item|\\subitem/ {
  p=0
  printf "\n%s", $0
}
{
  if (p) printf "%s", $0
}
END {
  printf "\n"
}
