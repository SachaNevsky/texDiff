<?xml version="1.0" encoding="UTF-8"?>
<!--
 ! bibhtml-extract-aux.xslt
 !
 ! Part of bibhtml, version 2.0.2, released 2013 September 8
 ! Hg node 7076ce83a035.
 ! See <http://purl.org/nxg/dist/bibhtml>
 !
 ! This sample script processes an XML file which contains elements like
 ! <span class='cite'>citation</span>, extracting each of the `citation'
 ! strings and emitting a .aux file which, once a \bibdata line has been
 ! appended, is suitable for processing with BibTeX.  Adapt or extend as
 ! appropriate.
 !-->
<x:stylesheet xmlns:x="http://www.w3.org/1999/XSL/Transform"
                version="1.0"
                xmlns="http://www.w3.org/1999/xhtml"
                exclude-result-prefixes="h"
                xmlns:h="http://www.w3.org/1999/xhtml">

  <x:output method="xml"
            version="1.0"
            doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
            doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
            omit-xml-declaration="yes"/>

  <x:param name='bibfile-name'>bibliography</x:param>
    

  <!-- identity transform -->
  <x:template match="*">
    <x:copy>
      <x:copy-of select="@*"/>
      <x:apply-templates/>
    </x:copy>
  </x:template>

  <x:template match="h:span[@class='cite']">
    <a>
      <x:attribute name='href'>
        <x:text>#</x:text>
        <x:copy-of select='.'/>
      </x:attribute>
      <x:apply-templates/>
    </a>
  </x:template>

  <x:template match='processing-instruction("bibliography")'>
    <x:copy-of select='document(concat($bibfile-name,".bbl"))'/>
  </x:template>
</x:stylesheet>
