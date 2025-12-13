{
  p=index($0,"{")
}

/^[^%]section\{/ {
  noss=0
  nos++
  sub("\\\\MF","Metafont",$0)
  s=substr($0,p+1,index($0,"}")-p-1)
  printf "\\BOOKMARK [1][-]{section."
  if (nos < 16) 
   print nos "}{" s "}{}"
  else
   printf "%c%s\n", nos+49, "}{" s "}{}"
}

/^[^%]subsection\{/ {
  noss++
  gsub("\\\\texttt\{|\\\\-|\{\}","",$0)
  gsub("\\\\","",$0)
  s=substr($0,p,index($0,"}")-p)
  print "\\BOOKMARK [2][-]{subsection." nos "." noss "}{" s "}{section." nos "}"
}