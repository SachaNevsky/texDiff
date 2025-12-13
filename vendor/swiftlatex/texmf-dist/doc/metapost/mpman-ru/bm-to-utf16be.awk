function to_utf16be(s) {
  s1="\\376\\377"
  for (i = 1; i <= length(s); i++) {
      k = x[substr(s, i, 1)]
      if (k == 208)
        s1=s1 sprintf("\\004\\%03o", x[substr(s, ++i, 1)] + 128)
      else if (k == 209)
        s1=s1 sprintf("\\004\\%03o", x[substr(s, ++i, 1)] - 64)
      else
        s1=s1 sprintf("\\000\\%03o", k)
  }
  return s1
}

BEGIN {
  for (i = 0; i < 256; i++) {
    x[sprintf("%c", i)] = i
  }
}

{
  p=index($0,"}{")
  s1=substr($0,1,p+1)
  s=substr($0,p+2)
  p=index(s,"}")
  s2=substr(s,p)
  s=substr(s,1,p-1)
  print s1 to_utf16be(s) s2
}
