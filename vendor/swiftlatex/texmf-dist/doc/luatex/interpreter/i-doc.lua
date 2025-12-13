--[[
Here's a description of "i-doc.lua", the file containing the interpretation
used for Interpreter's documentation. Remember that none of the TeX macros
used here is defined by Interpreter; instead, they are my own and should be
adapted if necessary. Also several options taken here are far from optimal but
are convenient examples.

Shorthands for often used functions.
--]]
local gsub, match = string.gsub, string.match
local add_pattern = interpreter.add_pattern
local nomagic     = interpreter.nomagic

--[[
Class 1 and 2 will be used for verbatim (thus protecting) and ``normal''
patterns go into class 3 or higher.
--]]
interpreter.default_class = 3

--[[
The reader might have observed that "interpreter-doc.txt" begins with a table
of contents. This table is useful for the source file only, and isn't typeset
by TeX, because the following pattern suppresses it: the entire paragraph
containing "TABLE OF CONTENTS" on a line of its own is deleted. Protecting the
paragraph is useless, but it makes things a little bit faster because the
paragraph won't be pointlessly searched for other patterns.
--]]
local function contents (buffer)
  for n in ipairs(buffer) do
    buffer[n] = ""
  end
  interpreter.protect()
end
add_pattern{
  pattern = "^%s*TABLE OF CONTENTS%s*$",
  call    = contents,
  class   = 1
}

--[[
Sections headers are typeset as
      
          ====================================== section_tag
          === Section title ====================
          ======================================

The first and third line are decorations and they are removed. The
"section_tag" is meant for the source only again (linking the section to the table
of contents). I could have used it to create PDF destinations, but that seemed
unnecessary in such a small file. The associated pattern is: at least four
equals signs.
--]]
add_pattern{
  pattern = "^====+.*",
  replace = ""
}

--[[
The middle line is spotted with the tree equals sign at the beginning of the
line (the previous pattern being longer, the decoration lines have been
already removed and they won't be taken for section titles). The signs are
removed and replaced with "\section{" and "}".
--]]
local function section (buffer, num)
  local l = buffer[num]
  l = gsub(l, "^===%s*", "\\section{")
  l = gsub(l, "%s*=+%s*", "}")
  buffer[num] = l
end
add_pattern{
  pattern = "^===",
  call    = section
}

--[[
The following pattern simply turns "Interpreter" into "\ital{Interpreter}". The
meaning of the "\ital" command is obvious, I suppose. Note the offset:
starting at the backslash, this leads to the _n_ in Interpreter, thus avoiding
matching the pattern again. The Lua notation with double square brackets is
used for strings with no escape character (hence "\ital" and not "\\ital" as
would be necessary with a simple string).
--]]
add_pattern{
  pattern = "Interpreter",
  replace = [[\ital{Interpreter}]],
  offset  = 7
}

--[[
Turning "TeX" into TeX. This illustrates the use of a function as "replace";
the point is that "\TeX" should be suffixed with a space if initially followed
by anything but a space or end of line (so as not to form a control sequence
with the following letters), and it should be suffixed with a control space if
initially followed by a space or end of line (so as to avoid gobbling the
space). So the function checks the second capture. Note that simply replacing
"TeX" with "\TeX{}" would be much simpler, but less instructive!
--]]
local function maketex (tex, next)
  if next == " " or next == "" then
    return [[\TeX\ ]]
  else
    return [[\TeX ]] .. next
  end
end
add_pattern{
  pattern = "(TeX)(.?)",
  replace = maketex,
  offset  = 2
}

--[[
The following turns "<text>" into <text> and "_text_" into _text_. Setting a
class just so the patterns inherit the "nomagic" feature is of course an
overkill, but that's an example.
--]]
interpreter.set_class(4, {nomagic = true})
add_pattern{
  pattern = "<...>",
  replace = [[\arg{%1}]],
  class   = 4
}
add_pattern{
  pattern = "_..._",
  replace = [[\ital{%1}]],
  class   = 4
}

--[[
I use double quotes as protectors; they are replaced with a "\verb" command at
the very end of the processing (with class 0).
--]]
interpreter.protector('"')
add_pattern{
  pattern = nomagic'"..."',
  replace = [[\verb`%1`]],
  class   = 0
}

--[[
The description of functions (in red in the PDF file) are handled with the
"\describe" macro, which takes the function as its first argument and
additional information as its second one (typeset in italics in the PDF file).
In the source, it is simply marked as

          > function (arguments) [Additional information]

with "[Additional information]" sometimes missing (i.e. there is no empty
pairs of square brackets). Descriptions of entries in pattern tables follows
the same syntax, except the line begins with ">>". So the pattern first spots
lines beginning with ">[>]" followed by at least one space, adds an empty pair of
brackets at the end if there isn't any, and turn the whole into "\describe".
The number of ">" symbols sets "\describe"'s third argument, which specifies
the level of the bookmark.
--]]
local function describe (buffer, num)
  local l = buffer[num]
  if not match (l, "%[.-%]%s*$") then
    l = l .. " []"
  end
  local le = match(l, ">>") and 4 or 3
  buffer[num] = gsub(l, ">+%s+(.-)%s+%[(.-)%]",
                [[\describe{%1}{%2}{]] .. le .. "}")
end
add_pattern{
  pattern = "^>+%s+",
  call    = describe
}

--[[
Here's how multiline verbatim is handled; in the source it is simply marked by
indenting the line with ten spaces; thus code is easily spotted when reading
the source without useless and annoying "<code>"/"</code>" or anything similar
to mark it. To be properly processed by TeX, the code should be surrounded by
"\verbatim" and "\verbatim/" (my way of signalling blocks). Those must be on
their own lines, so we insert a line at the beginning and at the end of the
paragraph: for the closing "\verbatim/", we can simply replace the last line
of the paragraph, which is the boundary line, unless we're at the end of the
file. But for the opening "\verbatim" a line must be added at the beginning of
the paragraph; thus line numbers in the original source file and in its
processed version don't match anymore, and this might be annoying when TeX
reports erros. Besides, blank verbatim lines aren't handled correctly and
create a new verbatim block instead. So this way of marking verbatim material
is good for small documents, but explicit marking is cleaner and more
powerful (albeit not so good-looking in the source file).

Note that the verbatim pattern belongs to class 2 and the entire paragraph is
protected, so Interpreter leaves it alone afterward (remember the default
class is 3). Of course, the first ten space characters are removed.
--]]
local function verbatim (buffer)
  for n, l in ipairs(buffer) do
    buffer[n] = gsub(l, "%s%s%s%s%s%s%s%s%s%s","", 1)
  end
  table.insert(buffer, 1, [[\verbatim]])
  if gsub(buffer[#buffer],
          interpreter.paragraph, "") == "" then
    buffer[#buffer] = [[\verbatim/]]
  else
    table.insert(buffer, [[\verbatim/]])
  end
  interpreter.protect()
end
add_pattern{
  pattern = "^%s%s%s%s%s%s%s%s%s%s",
  call    = verbatim,
  class   = 2
}

--[[
And now comes the fun part. I wanted "i-doc.lua" to be self-describing. The
source of what you're reading right now isn't "interpreter-doc.txt", but
"i-doc.lua" itself input in the latter file with

          \intepreterfile{doc}{i-doc.lua}

How should code and comment be organized in "i-doc.lua"? Well, there is little
choice, since the file is a normal Lua file: comment lines should be prefixed
with "--" or surrounded with
\tcode{--[{}[} and \tcode{--]{}]}. % Sorry for the braces, I can't nest Lua comments!
I chose the latter option, which is simpler. But normal code should also be
typeset as verbatim material; I could have begun all lines with ten spaces,
but that would have seemed strange. Instead, \tcode{--]{}]} is turned into
"\source" and "\source/" is added at the end of the paragraph ("\source" is
just "\verbatim" with a different layout). Which means all paragraphs have the
same structure: comments between
\tcode{--[{}[} and \tcode{--]{}]}
and code immediately following (\tcode{--[{}[} is simply removed). The pattern
is in class 1 and the paragraph is protected, so that lines indented with ten
spaces or more aren't touched by the previous verbatim pattern (in class 2).
--]]
local function autoverbatim (buffer, line)
  buffer[line] = [[\source]]
  for n = line + 1, #buffer do
    interpreter.protect(n)
  end
  if gsub(buffer[#buffer],
          interpreter.paragraph, "") == "" then
    buffer[#buffer] = [[\source/]]
  else
    table.insert(buffer, [[\source/]])
  end
end
add_pattern{
  pattern = nomagic"%^--]]",
  call    = autoverbatim,
  class   = 1
}
local function remove_comment ()
  return ""
end
add_pattern{
  pattern = nomagic"%^--[[",
  replace = remove_comment
}
