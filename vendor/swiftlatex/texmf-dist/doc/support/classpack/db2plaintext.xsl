<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:db="http://docbook.org/ns/docbook"
                version="2.0">

  <!-- ClassPack README STRUCTURE ONLY for inclusion in db2dtx.xsl

     23 para
     11 productname
     11 title
     10 olink
      6 filename
      6 sect1
      5 acronym
      4 listitem
      4 systemitem
      4 term
      4 varlistentry
      3 programlisting
      3 sect2
      2 anchor
      2 guilabel
      2 varname
      1 chapter
      1 emphasis
      1 guibutton
      1 replaceable
      1 uri
      1 variablelist
      1 warning

-->

  <xsl:variable name="maindoc" select="."/>

  <xsl:variable name="width">
    <xsl:text>72</xsl:text>
  </xsl:variable>

  <!-- plain titles and plain paras -->

  <xsl:template mode="readme"
    match="db:title[not(parent::db:chapter) and
                    not(parent::db:sect1) and
                    not(parent::db:sect2) and
                    not(parent::db:sect3) and
                    not(parent::db:warning)] | 
           db:para[not(parent::db:listitem) and
                   not(parent::db:warning)]">
    <xsl:variable name="content">
      <xsl:apply-templates select="node()" mode="inline"/>
    </xsl:variable>
    <xsl:call-template name="normtext">
      <xsl:with-param name="content" select="normalize-space($content)"/>
      <xsl:with-param name="indent">
        <xsl:if test="ancestor::db:part[@xml:id='code'] or
                      ancestor::db:procedure[@xml:id='prepackage']">
          <xsl:text>%% </xsl:text>
        </xsl:if>
      </xsl:with-param>
    </xsl:call-template>
    <xsl:if test="ancestor::db:part[@xml:id!='code']">
      <xsl:text>&#xa;</xsl:text>
    </xsl:if>
  </xsl:template>

  <!-- section headings -->

  <xsl:template match="db:chapter/db:title" mode="readme">
    <xsl:variable name="content">
      <xsl:apply-templates select="node()" mode="inline"/>
    </xsl:variable>
    <xsl:call-template name="normtext">
      <xsl:with-param name="content" 
        select="upper-case(normalize-space($content))"/>
      <xsl:with-param name="indent">
        <xsl:if test="ancestor::db:part[@xml:id='code'] or
                      ancestor::db:procedure[@xml:id='prepackage']">
          <xsl:text>%% </xsl:text>
        </xsl:if>
      </xsl:with-param>
    </xsl:call-template>
    <xsl:if test="ancestor::db:part[@xml:id!='code']">
      <xsl:text>&#xa;</xsl:text>
    </xsl:if>
  </xsl:template>

  <xsl:template match="db:sect1/db:title" mode="readme">
    <xsl:variable name="content">
      <xsl:apply-templates select="node()" mode="inline"/>
    </xsl:variable>
    <xsl:call-template name="normtext">
      <xsl:with-param name="content" select="normalize-space($content)"/>
      <xsl:with-param name="prefix">
        <xsl:value-of 
          select="count(parent::db:sect1/preceding-sibling::db:sect1) + 1"/>
        <xsl:text>  </xsl:text>
      </xsl:with-param>
      <xsl:with-param name="indent">
        <xsl:if test="ancestor::db:part[@xml:id='code'] or
                      ancestor::db:procedure[@xml:id='prepackage']">
          <xsl:text>%% </xsl:text>
        </xsl:if>
      </xsl:with-param>
    </xsl:call-template>
    <xsl:if test="ancestor::db:part[@xml:id!='code']">
      <xsl:text>&#xa;</xsl:text>
    </xsl:if>
  </xsl:template>

  <xsl:template match="db:sect2/db:title" mode="readme">
    <xsl:variable name="content">
      <xsl:apply-templates select="node()" mode="inline"/>
    </xsl:variable>
    <xsl:call-template name="normtext">
      <xsl:with-param name="content" select="normalize-space($content)"/>
      <xsl:with-param name="prefix">
        <xsl:value-of 
          select="count(ancestor::db:sect1/preceding-sibling::db:sect1) + 1"/>
        <xsl:text>.</xsl:text>
        <xsl:value-of 
          select="count(parent::db:sect2/preceding-sibling::db:sect2) + 1"/>
        <xsl:text>  </xsl:text>
      </xsl:with-param>
      <xsl:with-param name="indent">
        <xsl:if test="ancestor::db:part[@xml:id='code'] or
                      ancestor::db:procedure[@xml:id='prepackage']">
          <xsl:text>%% </xsl:text>
        </xsl:if>
      </xsl:with-param>
    </xsl:call-template>
    <xsl:if test="ancestor::db:part[@xml:id!='code']">
      <xsl:text>&#xa;</xsl:text>
    </xsl:if>
  </xsl:template>

  <xsl:template match="db:sect3/db:title" mode="readme">
    <xsl:variable name="content">
      <xsl:apply-templates select="node()" mode="inline"/>
    </xsl:variable>
    <xsl:call-template name="normtext">
      <xsl:with-param name="content" select="normalize-space($content)"/>
      <xsl:with-param name="prefix">
        <xsl:value-of 
          select="count(ancestor::db:sect1/preceding-sibling::db:sect1) + 1"/>
        <xsl:text>.</xsl:text>
        <xsl:value-of 
          select="count(ancestor::db:sect2/preceding-sibling::db:sect2) + 1"/>
        <xsl:text>.</xsl:text>
        <xsl:value-of 
          select="count(parent::db:sect3/preceding-sibling::db:sect3) + 1"/>
        <xsl:text>  </xsl:text>
      </xsl:with-param>
      <xsl:with-param name="indent">
        <xsl:if test="ancestor::db:part[@xml:id='code'] or
                      ancestor::db:procedure[@xml:id='prepackage']">
          <xsl:text>%% </xsl:text>
        </xsl:if>
      </xsl:with-param>
    </xsl:call-template>
    <xsl:if test="ancestor::db:part[@xml:id!='code']">
      <xsl:text>&#xa;</xsl:text>
    </xsl:if>
  </xsl:template>

  <xsl:template match="db:warning/db:title" mode="readme">
    <xsl:variable name="content">
      <xsl:apply-templates select="node()" mode="inline"/>
    </xsl:variable>
    <xsl:call-template name="normtext">
      <xsl:with-param name="content" select="normalize-space($content)"/>
      <xsl:with-param name="prefix">
        <xsl:text>  WARNING: </xsl:text>
      </xsl:with-param>
      <xsl:with-param name="indent">
        <xsl:if test="ancestor::db:part[@xml:id='code'] or
                      ancestor::db:procedure[@xml:id='prepackage']">
          <xsl:text>%% </xsl:text>
        </xsl:if>
      </xsl:with-param>
    </xsl:call-template>
    <xsl:text>  !&#xa;</xsl:text>
  </xsl:template>

  <xsl:template match="db:programlisting" mode="readme">
    <xsl:variable name="curdoctype">
      <xsl:value-of select="$maindoc/db:book/@arch"/>
    </xsl:variable>
    <xsl:if test="@condition=$curdoctype or not(@condition)">
      <xsl:variable name="content">
        <xsl:apply-templates select="node()" mode="inline"/>
      </xsl:variable>
      <xsl:call-template name="normtext">
        <xsl:with-param name="content" select="normalize-space($content)"/>
        <xsl:with-param name="indent">
          <xsl:text>  </xsl:text>
        </xsl:with-param>
      </xsl:call-template>
      <xsl:text>&#xa;</xsl:text>
    </xsl:if>
  </xsl:template>

  <xsl:template match="db:term" mode="readme">
    <xsl:variable name="content">
      <xsl:apply-templates select="node()" mode="inline"/>
    </xsl:variable>
    <xsl:call-template name="normtext">
      <xsl:with-param name="content" select="normalize-space($content)"/>
      <xsl:with-param name="indent">
        <xsl:text>  </xsl:text>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="db:para[parent::db:listitem]" mode="readme">
    <xsl:variable name="content">
      <xsl:apply-templates select="node()" mode="inline"/>
    </xsl:variable>
    <xsl:call-template name="normtext">
      <xsl:with-param name="content" select="normalize-space($content)"/>
      <xsl:with-param name="indent">
        <xsl:if test="ancestor::db:part[@xml:id='code']">
          <xsl:text>%% </xsl:text>
        </xsl:if>
        <xsl:choose>
          <xsl:when test="ancestor::db:variablelist">
            <xsl:text>    </xsl:text>
          </xsl:when>
          <xsl:when test="ancestor::db:itemizedlist">
            <xsl:text>  * </xsl:text>
          </xsl:when>
          <xsl:when test="ancestor::db:orderedlist">
            <xsl:text>  </xsl:text>
            <xsl:value-of 
              select="count(parent::db:listitem/preceding-sibling::db:listitem)+1"/>
            <xsl:text> </xsl:text>
          </xsl:when>
        </xsl:choose>
      </xsl:with-param>
    </xsl:call-template>
    <xsl:if test="ancestor::db:part[@xml:id!='code']">
      <xsl:text>&#xa;</xsl:text>
    </xsl:if>
  </xsl:template>

  <xsl:template match="db:para[parent::db:warning]" mode="readme">
    <xsl:variable name="content">
      <xsl:apply-templates select="node()" mode="inline"/>
    </xsl:variable>
    <xsl:call-template name="normtext">
      <xsl:with-param name="content" select="normalize-space($content)"/>
      <xsl:with-param name="indent">
        <xsl:if test="ancestor::db:part[@xml:id='code'] or
                      ancestor::db:procedure[@xml:id='prepackage']">
          <xsl:text>%% </xsl:text>
        </xsl:if>
        <xsl:text>  ! </xsl:text>
      </xsl:with-param>
    </xsl:call-template>
    <xsl:if test="following-sibling::db:para">
      <xsl:if test="ancestor::db:part[@xml:id='code'] or
                    ancestor::db:procedure[@xml:id='prepackage']">
        <xsl:text>%% </xsl:text>
      </xsl:if>
      <xsl:text>  !</xsl:text>
    </xsl:if>
    <xsl:text>&#xa;</xsl:text>
  </xsl:template>

  <xsl:template match="db:sect1" mode="readme">
    <xsl:choose>
      <xsl:when 
        test="@xml:id='bugs' and 
              $maindoc//db:revhistory/db:revision[1]/db:revdescription/db:orderedlist">
        <xsl:apply-templates mode="readme" select="db:title"/>
        <xsl:text>The following need attention:&#xa;&#xa;</xsl:text>
        <xsl:apply-templates  mode="readme"
          select="$maindoc//db:revhistory/db:revision[1]/db:revdescription/db:orderedlist"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates mode="readme"/>        
      </xsl:otherwise>
    </xsl:choose>
    <xsl:text>&#xa;</xsl:text>
  </xsl:template>

  <xsl:template match="db:anchor" mode="readme">
    <xsl:variable name="loc" select="@targetptr"/>
    <xsl:variable name="pos" select="@type"/>
    <xsl:variable name="omit" select="@remap"/>
    <!--
    <xsl:message>
      <xsl:text>Getting </xsl:text>
      <xsl:value-of select="$loc"/>
      <xsl:text>/</xsl:text>
      <xsl:value-of select="$pos"/>
    </xsl:message>
    -->
    <xsl:choose>
      <!-- special usage referencing a macro -->
      <xsl:when test="@targetptr='copyright' and @type='*'">
        <xsl:for-each select="$maindoc">
          <xsl:call-template name="copyright-statement">
            <xsl:with-param name="ftype" select="/db:book/@userlevel"/>
          </xsl:call-template>
        </xsl:for-each>
      </xsl:when>
      <!-- normal operation -->
      <xsl:otherwise>
        <xsl:apply-templates mode="readme"
          select="$maindoc/
                  descendant::*[local-name()=$loc][1]/*[local-name()!=$omit]"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- CONTENT -->

  <xsl:template match="db:olink" mode="inline">
    <xsl:call-template name="metadata"/>
  </xsl:template>

  <xsl:template match="db:acronym | db:uri | db:filename" 
    mode="inline">
    <xsl:apply-templates mode="inline"/>
  </xsl:template>

  <xsl:template match="db:phrase | db:wordasword | db:quote" 
    mode="inline">
    <xsl:text>"</xsl:text>
    <xsl:apply-templates mode="inline"/>
    <xsl:text>"</xsl:text>
  </xsl:template>

  <xsl:template match="db:footnote" mode="inline">
    <xsl:text> [</xsl:text>
    <xsl:apply-templates mode="inline"/>
    <xsl:text>]</xsl:text>
  </xsl:template>

  <xsl:template match="db:command" mode="inline">
    <xsl:if test="@xml:lang='TeX' or @xml:lang='LaTeX' or not(@xml:lang)">
      <xsl:text>\</xsl:text>
    </xsl:if>
    <xsl:apply-templates mode="inline"/>
  </xsl:template>

  <xsl:template match="text()" mode="inline">
    <xsl:choose>
      <xsl:when test="parent::db:emphasis">
        <xsl:value-of select="upper-case(.)"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="."/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="db:biblioref" mode="inline">
    <xsl:text>(</xsl:text>
    <xsl:variable name="bibref" select="@linkend"/>
    <!-- go to the entry -->
    <xsl:for-each select="$maindoc/descendant::db:biblioentry[@xml:id=$bibref]">
      <xsl:variable name="authors" select="count(descendant::db:author)"/>
      <!-- only name up to the first two -->
      <xsl:for-each select="descendant::db:author
                            [count(preceding-sibling::db:author)&lt;2]">
        <xsl:if test="$authors>2
                      and count(preceding-sibling::db:author)=1">
          <xsl:text>, </xsl:text>
        </xsl:if>
        <xsl:if test="count(preceding-sibling::db:author)=2">
          <xsl:text> &amp; </xsl:text>
        </xsl:if>
        <xsl:value-of select="db:personname/db:surname"/>
      </xsl:for-each>
      <xsl:if test="$authors>3">
        <xsl:text> et al</xsl:text>
      </xsl:if>
      <xsl:text>, </xsl:text>
      <xsl:value-of select="substring(descendant::db:date[1]/@YYYY-MM-DD,1,4)"/>
    </xsl:for-each>
    <xsl:text>)</xsl:text>
  </xsl:template>

  <!-- extraction of metadata from master file -->

  <xsl:template name="metadata">
    <xsl:variable name="loc" select="@targetptr"/>
    <xsl:variable name="pos" select="@type"/>
    <!--
    <xsl:message>
      <xsl:text>Getting </xsl:text>
      <xsl:value-of select="$loc"/>
      <xsl:text>/</xsl:text>
      <xsl:value-of select="$pos"/>
    </xsl:message>
    -->
    <xsl:value-of 
      select="$maindoc/
              descendant::*[local-name()=$loc][1]/@*[name()=$pos]"/>
  </xsl:template>

  <!-- typesetting  -->

  <xsl:template name="normtext">
    <xsl:param name="content"/>
    <xsl:param name="indent">
      <xsl:text></xsl:text>
    </xsl:param>
    <xsl:param name="prefix">
      <xsl:text></xsl:text>
    </xsl:param>
    <xsl:call-template name="set">
      <!--
      <xsl:value-of select='replace(., "\$\d+\.\d{2}","\$xx.xx")'/>
-->
      <xsl:with-param name="text" 
        select="replace(replace(replace(replace(
                    concat($prefix,$content),'\\TeX\{\}','TeX'),
                        '\\LaTeX\{\}','LaTeX'),
                            '\\thinspace\{\}',' '),
                                '\\nicefrac(.)(.)','$1/$2')"/>
      <xsl:with-param name="indent" select="$indent"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="set">
    <xsl:param name="text"/>
    <xsl:param name="indent">
      <xsl:text></xsl:text>
    </xsl:param>
    <xsl:choose>
      <xsl:when test="string-length($text) &lt; $width">
        <xsl:value-of select="$indent"/>
        <xsl:value-of select="$text"/>
        <xsl:text>&#xa;</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="line">
          <xsl:call-template name="token">
            <xsl:with-param name="text" select="$text"/>
            <xsl:with-param name="indent" select="$indent"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:value-of select="$line"/>
        <xsl:text>&#xa;</xsl:text>
        <xsl:call-template name="set">
          <xsl:with-param name="text"
            select="normalize-space(substring-after(
                    concat($indent,$text),$line))"/>
          <xsl:with-param name="indent" select="$indent"/>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="token">
    <xsl:param name="text"/>
    <xsl:param name="line"/>
    <xsl:param name="length">
      <xsl:text>0</xsl:text>
    </xsl:param>
    <xsl:param name="indent">
      <xsl:text></xsl:text>
    </xsl:param>
    <xsl:variable name="word">
      <xsl:choose>
        <xsl:when test="contains($text,' ')">
          <xsl:value-of select="substring-before($text,' ')"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$text"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="size" select="string-length($word)"/>
    <xsl:choose>
      <!-- too much for line -->
      <xsl:when test="$length + 1 + $size > $width">
        <xsl:value-of select="$line"/>
      </xsl:when>
      <!-- another word will fit -->
      <xsl:otherwise>
        <xsl:call-template name="token">
          <xsl:with-param name="line">
            <xsl:choose>
              <xsl:when test="$length=0">
                <xsl:value-of select="$indent"/>
                <xsl:value-of select="$word"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="concat($line,' ',$word)"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:with-param>
          <xsl:with-param name="length">
            <xsl:choose>
              <xsl:when test="$length=0">
                <xsl:value-of select="$size + string-length($indent)"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="string-length($line) + 1 + $size"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:with-param>
          <xsl:with-param name="text" select="substring-after($text,' ')"/>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
