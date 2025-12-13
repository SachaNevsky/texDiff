bxdpx-beamer Package
====================

LaTeX: to fix some problems in use of Beamer with dvipdfmx

This packges makes the two types of links work:
  - Navigation symbols
  - \framezoom'd regions

### Installation

  - `*.sty` → $TEXMF/tex/latex/bxdpx-beamer

### Usage

Load this package as usual in the preamble of Beamer documents:

    \documentclass[dvipdfmx]{beamer}
    \usepackage{bxdpx-beamer}

This package does not provide any user commands.

### License

This package is distributed under the MIT License.

Revision History
----------------

  * Version 0.3  〈2016/08/06〉
      - The driver of geometry package is forced to be `dvipdfm`.
  * Version 0.2  〈2013/02/27〉
      - The first public version.

--------------------
Takayuki YATO (aka. "ZR")  
http://zrbabbler.sp.land.to/
