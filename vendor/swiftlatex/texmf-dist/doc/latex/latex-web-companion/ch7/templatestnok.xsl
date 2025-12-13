<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/XSL/Transform/1.0"
                xmlns:fo="http://www.w3.org/XSL/Format/1.0"
                result-ns="fo"
                default-space="">
<xsl:template name="listitem">
  <xsl:param-variable name="labeltext">labeltext</xsl:param-variable>
  <xsl:param-variable name="itemid">itemid</xsl:param-variable>
  <xsl:param-variable name="itemtext">itemtext</xsl:param-variable>
  <fo:list-item id="{$itemid}">
    <fo:list-item-label font-style="italic">
      $labeltext<xsl:text>:</xsl:text>
    </fo:list-item-label>
    <fo:list-item-body>
      <xsl:value-of select="$itemtext"/>
    </fo:list-item-body>
  </fo:list-item>
</xsl:template>

<xsl:template match='/'>
 <fo:page-sequence>
   <xsl:apply-templates/>
 </fo:page-sequence>
</xsl:template>

<xsl:template match="invitation">
<fo:list-block>
  <xsl:call-template name="listitem">
    <xsl:param name="labeltext">To</xsl:param>
    <xsl:param name="itemid">listto</xsl:param>
    <xsl:param name="itemtext">to</xsl:param>
  </xsl:call-template>
</fo:list-block>
</xsl:template>

</xsl:stylesheet>





