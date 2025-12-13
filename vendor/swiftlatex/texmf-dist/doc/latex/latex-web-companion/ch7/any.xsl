<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/XSL/Transform/1.0">
<xsl:template match="/">
  <xsl:text>(*root*)</xsl:text>
  <xsl:apply-templates/>
  <xsl:text>(/*root*)</xsl:text>
</xsl:template>
<xsl:template match="*" priority="-1">
  <xsl:text>(*)</xsl:text>
  <xsl:apply-templates/>
  <xsl:text>(/*)</xsl:text>
</xsl:template>
<xsl:template match="*[position()=1 and position()=last()]" priority="1">
  <xsl:text>($)</xsl:text>
  <xsl:apply-templates/>
  <xsl:text>(/$)</xsl:text>
</xsl:template>
</xsl:stylesheet>







