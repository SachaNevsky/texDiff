<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/XSL/Transform/1.0"
                xmlns:fo="http://www.w3.org/XSL/Format/1.0"
                result-ns="fo">
  <xsl:template match="/">
    <fo:basic-page-sequence font-family="Helvetica" font-size="10pt" >
      <xsl:apply-templates/>
    </fo:basic-page-sequence>
  </xsl:template>
  <xsl:template match="par">
    <fo:block indent-start="10pt" space-before="12pt">
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>
  <xsl:template match="emph">
    <fo:inline-sequence font-style="italic">
      <xsl:apply-templates/>
    </fo:inline-sequence>
  </xsl:template>
<!--
<xsl:template match='/'>
 <fo:basic-page-sequence font-family="serif">
  <fo:simple-page-master page-master-name='scrolling'/>
  <fo:queue queue-name='body'>
   <xsl:apply-templates/>
  </fo:queue>
 </fo:basic-page-sequence>
</xsl:template>
-->
</xsl:stylesheet>
