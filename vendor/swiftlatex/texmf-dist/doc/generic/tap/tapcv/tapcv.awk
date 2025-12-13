# ---------------------------------------------------------------------------
                 This file belongs to the TAP package
# ---------------------------------------------------------------------------
# This is an AWK translator of tables written in extended ASCII format
# to TeX/TAP format.

# VERSION: 0.71, Tuesday, January 27th, 1998 -- essentially the
#          same as ver. 0.5 of Friday, May 3rd, 1996 (BachoTeX 96 release)

# AUTHORS' COORDINATES
# 
# Names:  Bogu\l{}aw Jackowski, Piotr Pianowski, Piotr Strzelczyk
# Mail:   BOP s.c., ul. Piastowska 70, 80-363 Gda\'nsk, Poland
# Email:  B.Jackowski@GUST.ORG.PL

# ===========================================================================
BEGIN {
  EXPROW=EXPROW+0 # pad each cell with at least EXPROW spaces
  NOSPAN=NOSPAN+0 # use " mark instead of @ operator
# INSROW is inserted in rows ~ "^[ " U S "]+$" (if not empty)
  H="Õ"; V="∂∑π∫ªºΩ«»… ÀÃŒ–“”÷◊"; h="ƒ"; v="µ∏¥≥øŸæ∆¿⁄¡¬√≈œ—‘’ÿ"
  U=" ∫≥"  # U is the subset of V + v + " "
  S="∞"    # the explicit mark of a strut column (converted later to ")
}
# ===========================================================================
function int_subst(u) {# task-specific substitutions for table interior
  gsub("<","$<$",u); gsub(">","$>$",u); gsub("%","\\%",u); return u
}
function spaces(n) {return (n>0 ? sprintf("%" n "s", "") : "")}
function chars(n,c, t) {t=spaces(n); gsub(" ", c, t); return t}
function tildes(n) {return chars(n,"~")}
function center(l,s, k1,k2) {
# pads string s symmetrically with spaces such that result has length=l
  k2=0; k1=int((l-length(s))/2); if (k1>=0) k2=l-length(s)-k1
  return spaces(k1) s spaces(k2)
}
# ===========================================================================
#                          STORE ALL THE STUFF
# ===========================================================================
/[^ ]/ {
 if ( !(($0 ~ "^[ " U S "]+$") && (INSROW=="")) ) {
   gsub(/ +$/,"") # trailing spaces are meaningless
   line[++line_]=$0
   if (longest<length($0)) longest=length($0) # fix max line length
   PFX[line_]=(line[line_] ~ "(^[" V v S " ]+$)|([" H h "])" ? "-" : "+")
   if ($0 ~ "^[ " U S "]+$") PFX[line_]="0"
 }
}
# ===========================================================================
END {
# PASS 0:
# 0a: truncate leading spaces
  u=longest
  for (l=1; l<=line_; ++l)
    if (match(line[l],/^ +[^ ]/)) {if (RLENGTH<u) u=RLENGTH} else u=1
  if (u>1) for (l=1; l<=line_; ++l) line[l]=substr(line[l],u)
  longest=longest-u+1
# 0b: check whether the first and the last columns contain vrules
  i=1; j=1;
  for (l=1; l<=line_; ++l) {
    if (substr(line[l],1,1) ~ ("[" V v S "]")) i=0
    if (length(line[l])==longest)
      if (substr(line[l],longest) ~ ("[" V v S "]")) j=0
  }
# 0c: pad with trailing spaces (make the length of all rows equal)
  for (l=1; l<=line_; ++l) line[l]=line[l] spaces(longest-length(line[l]))
# 0d: add artificial begin and end strut, if needed
  if (j) for (l=1; l<=line_; ++l) line[l]=line[l] S
  if (i) for (l=1; l<=line_; ++l) line[l]=S line[l]
  longest=longest+i+j
# 0e: fix prefixes
  for (l=1; l<=line_-1; ++l)
    if ((PFX[l]=="-") && (PFX[l+1]=="+")) PFX[l+1]="^"
  for (l=1; l<=line_-1; ++l) {
    if ((PFX[l]=="^") && (PFX[l+1]=="-")) PFX[l]=":"
    if ((PFX[l]=="+") && (PFX[l+1]=="-")) PFX[l]="_"
  }
# PASS 1: check input data
# 1a: find position of vrules for all rows
  for (l=1; l<=line_; ++l) {
    for (i=1; i<=length(line[l]); ++i) {
      ch=substr(line[l],i,1)
      if ((ch!=".") && (ch!="?") && (ch!="(") && (ch!=")")\
        && (ch!="+") && (ch!="*") && (ch!="[") && (ch!="]"))
          if (match(V v S,ch)) C[i]=i
    }
  }
  for (i in C) if ((i+0)>C_) C_=i+0 # index is a string, hence forced coercion
  for (i=1; i<=C_; ++i) if (i in C) {D[++D_]=i; C[i]=D_}
# if (c in C) holds, a vrule has occured in c-th column; C_ is the maximal
# such c; for d such that 1<=d<=D_ (D[d] in C) holds; moreover, C[D[d]]=d
# 1b: check consistency of data (in the positions of vrules only spaces
#     or vrules or struts may appear, unless NOSPAN==0)
  for (l=1; l<=line_; ++l) for (i=1; i<=D_; ++i)
    if ((NOSPAN) || (i==1)  || (i==D_))
      if (!match(V v S " ",substr(line[l],D[i],1))) {
        print "! INCONSISTENT DATA."
        print "ROW:", l ", COLUMN:", i ", CHARACTER:",
               substr(line[l],D[i],1) "."
        exit
     }
# 1c: put opening and closing struts, and all remaining struts if (NOSPAN==1)
  for (l=1; l<=line_; ++l) for (i=1; i<=D_; ++i)
    if ((NOSPAN) || (i==1)  || (i==D_))
      if (substr(line[l],D[i],1)==" ")
        line[l]=substr(line[l],1,D[i]-1) S substr(line[l],D[i]+1)
# PASS 2: check areas between vertical rules (find the longest one)
  for (l=1; l<=line_; ++l) {
    s=line[l]; t=""; u2=1
    while (s!="") {
      if (match(s,"[" V v S "][^" V v S "]+[" V v S "]")) {
        t=t substr(s,RSTART,1)
        u=substr(s,RSTART+1,RLENGTH-2)
        s=substr(s,RSTART+RLENGTH-1)
        u_=length(u); gsub("^ +","",u); gsub(" +$","",u)
        u1=u2+RSTART-1; u2=u1+RLENGTH-1; c1=C[u1]; c2=C[u2]
        if (u ~ /^[0-9]+[\.,]?[0-9]*$/) {
          if (match(u,/^[0-9]+$/)) {
            if (DD[c1,c2]<RLENGTH) DD[c1,c2]=RLENGTH
          } else {
            if (match(u,/^[0-9]+/))
              if (LD[c1,c2]<RLENGTH) LD[c1,c2]=RLENGTH
            if (match(u,/[\.,][0-9]*$/))
              if (RD[c1,c2]<RLENGTH) RD[c1,c2]=RLENGTH
          }
        }
        if ((u=="") && (NOSPAN)) {
          u=spaces(u_)
          for (i=C[u1]+1; i<=C[u2]-1; ++i) {
            u=substr(u,1,D[i]-D[C[u1]]-1) S substr(u,D[i]-D[C[u1]]+1)
          }
        }
        t=t center(u_,u)
      } else {t=t s; s=""}
    }
    line[l]=t
  }
# PASS 3: transform appropriately (adding @ operator, if needed)
#         areas between vertical rules
  for (l=1; l<=line_; ++l) {
    s=line[l]; t=""; u2=1
    while (s!="") {
      if (match(s,"[" V v S "][^" V v S "]+[" V v S "]")) {
        t=t substr(s,RSTART,1)
        u=substr(s,RSTART+1,RLENGTH-2)
        s=substr(s,RSTART+RLENGTH-1)
        u_=length(u); gsub("^ +","",u); gsub(" +$","",u)
        u1=u2+RSTART-1; u2=u1+RLENGTH-1; c1=C[u1]+0; c2=C[u2]+0
        if (u ~ /^[0-9]+[\.,]?[0-9]*$/) {
          if (match(u,/^[0-9]+$/)) {u=tildes(DD[c1,c2]-RLENGTH) u}
          else {
            if (match(u,/^[0-9]+/))  u=tildes(LD[c1,c2]-RLENGTH) u
            if (match(u,/[\.,][0-9]*$/)) u=u tildes(RD[c1,c2]-RLENGTH)
          }
        }
        gsub("[" h "]+","\\-",u); gsub("[" H "]+","\\=",u)
        if ((c1==1) && (line[l] ~ "^[" U S " ]+$"))
          {u=INSROW} else u=int_subst(u)
        if ((c2-c1)>1) u="@" c2-c1 " " u
        u=center(u_,u)
        PAD[l,u2]=length(u)-u_ # PAD[l,u2] = shift of vrule u2 in line l
        t=t u
      } else {t=t s; s=""}
    }
    line[l]=t
  }
# PASS 4: align distorted columns (surprisingly hard task...)
# 4a: find maximal shifts of vrules for all table rows
  for (i=1; i<=D_; ++i) PADmax[D[i]]=EXPROW
  for (l=1; l<=line_; ++l)
    for (j=2; j<=D_; ++j) {i=D[j]
      if ((l,i) in PAD)
        PADmax[i]=(PAD[l,i]>PADmax[i] ? PAD[l,i] : PADmax[i])
    }
  for (l=1; l<=line_; ++l) {
# 4b: find shifts of vrules for a given row
    PAD_=0
    for (j=2; j<=D_; ++j) {i=D[j]
      if ((l,i) in PAD) {PADloc[i]=PADmax[i]+PAD_; PAD_=0}
      else {PADloc[i]=0; PAD_+=PADmax[i]} # slip over non-existant rules
    }
# 4c: add spaces before appropriate vrules
    cc=0;
    for (j=2; j<=D_; ++j) {i=D[j]
      if (PADloc[i]>0) {
        line[l]=substr(line[l],1,i+cc-1+PAD[l,i]) spaces(PADloc[i]-PAD[l,i]) substr(line[l],i+cc+PAD[l,i])
        cc+=PADloc[i]
      }
    }
  }
# 4d: center cells again
  for (l=1; l<=line_; ++l) {
    s=line[l]; t=""
    while (s!="") {
      if (match(s,"[" V v S "][^" V v S "]+[" V v S "]")) {
        t=t substr(s,RSTART,1)
        u=substr(s,RSTART+1,RLENGTH-2); s=substr(s,RSTART+RLENGTH-1)
        u_=length(u); gsub("^ +","",u); gsub(" +$","",u); t=t center(u_,u)
      } else {t=t s; s=""}
    }
    line[l]=t
  }
# PASS 5: output results
# 5a: insert !, | and "
  for (l=1; l<=line_; ++l) {
    gsub("[" V "]","!",line[l])
    gsub("[" v "]","|",line[l])
    gsub("[" S "]","\"",line[l])
    p=line[l]; gsub(/(\\\|)|(\\!)|(\\")/,"  ",p); gsub(/[^\|!"]/," ",p);
    PAT[p]=1 # fix row pattern
    print "\\B" substr(line[l],1,1)\
          PFX[l] substr(line[l],2,length(line[l])-2)\
          "\\E" substr(line[l],length(line[l]),1)
  }
# 5b: clear old values of C and D and fix new ones
  for (i in C) delete C[i]; for (i in D) delete D[i]; C_=0; D_=0;
  for (p in PAT) for (i=1; i<=length(p); ++i) if (substr(p,i,1)!=" ")
    {C[i]=1; if (i>C_) C_=i}
  for (i=1; i<=C_; ++i) if (i in C) {D[++D_]=i; C[i]=D_}
# 5c: write extra information
  if (NOSPAN) {# add a row with complete column marks (a comment in fact)
    p=spaces(D[D_]-D[1])
    for (i=1; i<=D_; ++i) p=substr(p,1,D[i]-1) "\"" substr(p,D[i]+1)
      print "\\B" substr(p,1,1) " " substr(p,2,length(p)-2)\
            "\\E" substr(p,length(p),1)
  }
# 5d: add the ``rear''
#  print "% ROW PATTERNS:"
#  for (p in PAT) {
#    for (i in C) if (substr(p,i,1)==" ") p=substr(p,1,i-1) "\"" substr(p,i+1)
#    print "%\\B" substr(p,1,1)\
#          "0" substr(p,2,length(p)-2) "\\E" substr(p,length(p),1)
#  }
#  print "% VRULES FOUND IN THE FOLLOWING COLUMNS:"
#  print "%"
#  print "% No.    Col.:"
#  for (j=1; j<=D_; ++j) printf("%s %3d %4d\n", "%", j, D[j])
}
# ===========================================================================
