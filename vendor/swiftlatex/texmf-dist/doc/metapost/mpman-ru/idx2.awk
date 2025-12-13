BEGIN {
koi8r["\\\\CYRA"]=161
koi8r["\\\\CYRB"]=162
koi8r["\\\\CYRV"]=163
koi8r["\\\\CYRG"]=164
koi8r["\\\\CYRD"]=165
koi8r["\\\\CYRE"]=166
koi8r["\\\\CYRYO"]=167
koi8r["\\\\CYRZH"]=168
koi8r["\\\\CYRZ"]=169
koi8r["\\\\CYRI"]=170
koi8r["\\\\CYRISHRT"]=171
koi8r["\\\\CYRK"]=172
koi8r["\\\\CYRL"]=173
koi8r["\\\\CYRM"]=174
koi8r["\\\\CYRN"]=175
koi8r["\\\\CYRO"]=176
koi8r["\\\\CYRP"]=177
koi8r["\\\\CYRR"]=178
koi8r["\\\\CYRS"]=179
koi8r["\\\\CYRT"]=180
koi8r["\\\\CYRU"]=181
koi8r["\\\\CYRF"]=182
koi8r["\\\\CYRH"]=183
koi8r["\\\\CYRC"]=184
koi8r["\\\\CYRCH"]=185
koi8r["\\\\CYRSH"]=186
koi8r["\\\\CYRSHCH"]=187
koi8r["\\\\CYRHRDSN"]=188
koi8r["\\\\CYRERY"]=189
koi8r["\\\\CYRSFTSN"]=190
koi8r["\\\\CYREREV"]=191
koi8r["\\\\CYRYU"]=192
koi8r["\\\\CYRYA"]=193
koi8r["\\\\cyra"]=161
koi8r["\\\\cyrb"]=162
koi8r["\\\\cyrv"]=163
koi8r["\\\\cyrg"]=164
koi8r["\\\\cyrd"]=165
koi8r["\\\\cyre"]=166
koi8r["\\\\cyryo"]=167
koi8r["\\\\cyrzh"]=168
koi8r["\\\\cyrz"]=169
koi8r["\\\\cyri"]=170
koi8r["\\\\cyrishrt"]=171
koi8r["\\\\cyrk"]=172
koi8r["\\\\cyrl"]=173
koi8r["\\\\cyrm"]=174
koi8r["\\\\cyrn"]=175
koi8r["\\\\cyro"]=176
koi8r["\\\\cyrp"]=177
koi8r["\\\\cyrr"]=178
koi8r["\\\\cyrs"]=179
koi8r["\\\\cyrt"]=180
koi8r["\\\\cyru"]=181
koi8r["\\\\cyrf"]=182
koi8r["\\\\cyrh"]=183
koi8r["\\\\cyrc"]=184
koi8r["\\\\cyrch"]=185
koi8r["\\\\cyrsh"]=186
koi8r["\\\\cyrshch"]=187
koi8r["\\\\cyrhrdsn"]=188
koi8r["\\\\cyrery"]=189
koi8r["\\\\cyrsftsn"]=190
koi8r["\\\\cyrerev"]=191
koi8r["\\\\cyryu"]=192
koi8r["\\\\cyrya"]=193
pascii["\\\\#"]=35
pascii["\\."]=46
pascii["\\+"]=43
pascii["\\-"]=45
pascii["\\*"]=42
pascii["\\\\&"]=38
pascii["\\["]=64
pascii["\\]"]=64
pascii[" "]=32
pascii["@"]=63
for (i = 58; i < 63; i++) {
    pascii[sprintf("%c", i)] = i
  }
for (i = 65; i < 91; i++) {
    pascii[sprintf("%c", i)] = i
  }
for (i = 97; i < 123; i++) {
    pascii[sprintf("%c", i)] = i-32
  }
}
{
  t=$0
  gsub("{|}|^ *","",t)
  s=""
  p=match(t,"\\\\[A-Za-z]+")
  while (p>0) {
    p=p+RLENGTH
    s=s substr(t,1,p-1)
    while (substr(t,p,1)==" ")
      p++
    t=substr(t,p)
    p=match(t,"\\\\[A-Za-z]+")
  }
  s=s t
  p=index(s,",")
  if (p) s=substr(s,1,p-1)
  xc = length(s)/3
  gsub("\\\\texttt|\\\\IeC|\\\\tt|\\\\tdescr|\\\\string|\\\\ttt","",s)
  if (index(s,"\\item")==1)
    mode=1
  if (index(s,"\\subitem")==1)
    mode=2
  gsub("\\\\item|\\\\subitem","",s)
  while (match(s,"^[^A-Za-z·-Ò¡-—0-9\\\\].*[A-Za-z·-Ò¡-—0-9]"))
    s=substr(s,2)
  for (i in koi8r)
     gsub(i,sprintf("%03d",koi8r[i]),s)
  for (i in pascii)
     gsub(i,sprintf("%03d",pascii[i]),s)
  gsub("\\\\","",s)
  if (mode==1) 
    s = idx = s sprintf("%03d",xc)
  else if (mode==2)
    s = idx "000" s
  while (length(s) < 90)
    s = s "000"
  print s " @@@ " $0
}
