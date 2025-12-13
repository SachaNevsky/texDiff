function f(a) return (a*a) end
x=11;g =12
a={ [f(3)]=g; "x", "yy"; x=1,
    f(x), [30]=23; 45 }
print(table.maxn(a).." Elemente")
for i,j in pairs(a) do
  print(i,j)
end
