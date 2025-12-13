<?xml version="1.0" encoding="UTF-8"?>
<!--
 ! bibhtml-extract-aux.xslt
 !
 ! Part of bibhtml, version 2.0.2, released 2013 September 8
 ! Hg Node 7076ce83a035.
 ! See <http://purl.org/nxg/dist/bibhtml>
 !
 ! This sample script processes an XML file which contains elements like
 ! <span class='cite'>citation</span>, extracting each of the `citation'
 ! strings and emitting a .aux file which, once a \bibdata line has been
 ! appended, is suitable for processing with BibTeX.  Adapt or extend as
 ! appropriate.
 !-->
<stylesheet xmlns="http://www.w3.org/1999/XSL/Transform"
                version="1.0"
                exclude-result-prefixes="h"
                xmlns:h="http://www.w3.org/1999/xhtml">

  <output method="xml"
            version="1.0"
            doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
            doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
            omit-xml-declaration="yes"/>

  <template match="/">
    <text>\relax
</text>
    <apply-templates select="//h:span[@class='cite']"/>
    <apply-templates select='//processing-instruction("bibliography")'/>
    <!--
    <call-template name="make-tex-command">
      <with-param name="command">bibstyle</with-param>
      <with-param name="content">plainhtml</with-param>
    </call-template>
    -->
  </template>

  <template match="h:span[@class='cite']">
    <!--
    <h:a>
      <attribute name='href'>
        <text>#</text>
        <copy-of select='.'/>
      </attribute>
      <copy-of select='.'/>
    </h:a>
    -->
    <call-template name="make-tex-command">
      <with-param name="command">citation</with-param>
      <with-param name="content">
        <copy-of select="."/>
      </with-param>
    </call-template>
  </template>

  <template match='processing-instruction("bibliography")'>
    <choose>
      <when test='string-length(.) = 0'>
        <text>% No bibliography file specified!
</text>
      </when>
      <when test='contains(.," ")'>
        <call-template name='make-tex-command'>
          <with-param name='command'>bibdata</with-param>
          <with-param name='content'>
            <value-of select='substring-before(.," ")'/>
          </with-param>
        </call-template>
        <call-template name='make-tex-command'>
          <with-param name='command'>bibstyle</with-param>
          <with-param name='content'>
            <value-of select='substring-after(.," ")'/>
          </with-param>
        </call-template>
      </when>
      <otherwise>
        <call-template name='make-tex-command'>
          <with-param name='command'>bibdata</with-param>
          <with-param name='content'>
            <value-of select='normalize-space(.)'/>
          </with-param>
        </call-template>
      </otherwise>
    </choose>
  </template>  

  <template name="make-tex-command">
    <param name="command"/>
    <param name="content"/>
    <text>\</text>
    <value-of select="$command"/>
    <text>{</text>
    <value-of select="$content"/>
    <text>}
</text>
  </template>

</stylesheet>
