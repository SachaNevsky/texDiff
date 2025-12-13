<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/XSL/Transform/1.0"
                xmlns:fo="http://www.w3.org/XSL/Format/1.0"
                result-ns="fo"
                default-space="">

<xsl:template match='/'>
 <fo:page-sequence>
   <xsl:apply-templates/>
 </fo:page-sequence>
</xsl:template>

<xsl:template match="invitation">
<fo:list-block>
  <fo:list-item id="listto">
    <fo:list-item-label font-style="italic">
      <xsl:text>To:</xsl:text>
    </fo:list-item-label>
    <fo:list-item-body>
      <xsl:value-of select="to"/>
    </fo:list-item-body>
  </fo:list-item>
</fo:list-block>
</xsl:template>

</xsl:stylesheet>





