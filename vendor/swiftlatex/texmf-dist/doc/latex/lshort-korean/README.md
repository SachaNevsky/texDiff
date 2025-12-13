The Not So Short Introduction to LaTeX2e (Korean Translation)
================================================================

About
-------

version: 6.2(2018/0218)
  by Tobias Oetiker, et. al.

Korean translation:
  LaTeX2e 입문: 143분 동안 익히는 LaTeX2e (한국어판 2019/05/07)
  by Kangsoo Kim and In-Sung Cho <ischo at ktug.org>

License
-------

Permission is granted to copy, distribute and/or modify this document 
under the terms of the GNU Free Documentation License, 
Version 1.2 or any later version published by the Free Software Foundation. 
http://www.gnu.org/copyleft/fdl.html

Fonts
------

`lshort-ko` uses the [KoPubWorld font](http://www.kopus.org/biz/electronic/font.aspx), which is not redistributable.
To compile the document from source code, you need to install it by yourself and uncomment the lines for font setting in kopubworldfont.sty. 
Alternaltively, you can use the UnFonts shipped in the TeXLive distribution, in which case uncomment the related lines in the style file.
If you do not use the both of them, the truetype [Nanum font](https://hangeul.naver.com/2017/nanum) must be installed.

How to compile
--------------

   * `pygmentize` (Python pygments) is required.
   * run `xelatex` with `--shell-escape` option.
   * to make indices, run `komkindex` on the `.idx` file.

```
cd src && make
```
