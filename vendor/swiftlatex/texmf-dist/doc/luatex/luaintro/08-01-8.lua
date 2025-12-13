Wtage={"Sonntag", "Montag", "Dienstag","Mittwoch",
       "Donnerstag", "Freitag", "Samstag"}
WtagNr={}  -- neue Tabelle
for v,w in pairs(Wtage) do
  WtagNr[w] = v
end
for i,j in pairs(WtagNr) do
  print(string.format("%10s: %2i",i,j))
end
print(i,j) -- nicht definiert
