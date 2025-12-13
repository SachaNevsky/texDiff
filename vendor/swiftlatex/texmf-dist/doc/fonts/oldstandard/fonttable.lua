-- the following is adapted from https://tex.stackexchange.com/a/380780
ft = {}
function ft.print_glyphs(maxCols,maxChars) 
   local id = font.current()
   local fnt = font.getfont(id)
   local col = 1
   local maxU4 = 15*(16^3+16^2+16+1)
   a = {}
   for k, v in pairs(fnt.characters) do
      a [#a + 1] = k
   end
   table.sort(a)
   for i, k in ipairs(a) do
      if i >= maxChars then break end
      if col == 1 then
	 if k > maxU4 then
	    tex.sprint(string.format("U+%06x", k))
	 else
	    tex.sprint(string.format("U+%04x", k))
	 end
	 tex.sprint("&") 
      end
      if (i) then
	 tex.sprint(string.format([[\char%i]], k))
      else
	 tex.sprint("~")
      end
      if col == maxCols then
	 tex.sprint([[\\\cline{2-]] .. maxCols+1 .. "} ")
	 col = 1
      else
	 tex.sprint("&")
	 col = col + 1
      end
   end
end
