BEGIN {
  print "\\begin{theindex}"
  l=65
}
{
  if (0+substr($0,1,3)>=l && pl!=l && index($0,"\\subitem")==0) {
    print "\\indexspace"
    l=0+substr($0,1,3)
    pl=l++
    if (l==91) l=161
  }
  print substr($0,index($0,"@@@")+4)
}
END {
  print "\\end{theindex}"
}
