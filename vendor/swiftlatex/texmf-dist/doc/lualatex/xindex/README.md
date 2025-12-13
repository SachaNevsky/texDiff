# xindex

Unicode compatible index programm for LaTeX. It needs Lua 5.3 which
will be included in at least LuaTeX 1.09 (TeXLive 2019)


* xindex.lua            -- main file
* xindex-cfg.lua        -- config module
* xindex-cfg-common.lua -- main config module
* xindex-base.lua       -- base file
* xindex-lib.lua        -- functions module
* xindex-lapp.lua       -- read parameter
* xindex-unicode.lua    -- list of Unicode categories

The syntax of `xindex`

     xindex [options] <inputfile>[.idx]

possible options are (short,long):
    -q,--quiet
    -h,--help
    -v...          Verbosity level; can be -v, -vv, -vvv
    -c,--config (default cfg)
    -e,--escapechar (default ")
    -n,--noheadings 
    -a,--no_casesensitive
    -o,--output (default "")
    -l,--language (default en)
    -p,--prefix (default L)
    <input> (string)

Testfiles:

demo.tex:  run

    lualatex demo
    ./xindex.lua demo.idx
    lualatex demo


buch.tex:  run

    ./xindex.lua buch.idx
    lualatex buch

