function f(a, b) return a,b end
function g(a, b, ...) return a,... end
function r() return 1,2,3 end
print(f(3))
print(f(3, 4))
print(f(3, 4, 5))
print(f(r(), 10))
print(f(r()))
print(g(3))
print(g(3, 4))
print(g(3, 4, 5, 8))
print(g(5, r()))
