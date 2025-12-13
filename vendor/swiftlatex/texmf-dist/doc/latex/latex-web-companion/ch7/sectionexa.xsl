<?xml version='1.0'?>
<xsl:stylesheet
 xmlns:xsl="http://www.w3.org/XSL/Transform/1.0"
 result-ns="">
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
<xsl:template match="par">
  <xsl:text>(T1)</xsl:text>
  <xsl:apply-templates/>
  <xsl:text>(/T1)</xsl:text>
</xsl:template>
<xsl:template match="par[@ident]" priority="1"> 
  <xsl:text>(T2)</xsl:text>
  <xsl:apply-templates/>
  <xsl:text>(/T2)</xsl:text>
</xsl:template>
<xsl:template match="par[@ident='first']" priority="2">
  <xsl:text>(T3)</xsl:text>
  <xsl:apply-templates/>
  <xsl:text>(/T3)</xsl:text>
</xsl:template>
<xsl:template match="section[@sectid='S2']
              /par[@ident='normal' and @id='special']">
  <xsl:text>(T4)</xsl:text>
  <xsl:apply-templates/>
  <xsl:text>(/T4)</xsl:text>
</xsl:template>
<xsl:template match="section[position()=last()]">
  <xsl:text>(P1)</xsl:text>
  <xsl:apply-templates/>
  <xsl:text>(/P1)</xsl:text>
</xsl:template>
<xsl:template match="section[position()>1]/par[position()=1]">
  <xsl:text>(P2)</xsl:text>
  <xsl:apply-templates/>
  <xsl:text>(/P2)</xsl:text>
</xsl:template>
<xsl:template match="author">
  <xsl:text>(A1)</xsl:text>
  <xsl:text>author   1: </xsl:text>
  <xsl:text>(/A1)</xsl:text>
  <xsl:apply-templates/>
</xsl:template>
<xsl:template match="author[position()=last()]" priority="1">
  <xsl:text>(A2)</xsl:text>
  <xsl:apply-templates/>
  <xsl:text>(/A2)</xsl:text>
</xsl:template>
<xsl:template match="*[position()=1 and position()=last()]" priority="1">
  <xsl:text>(WD)</xsl:text>
  <xsl:apply-templates/>
  <xsl:text>(/WD)</xsl:text>
</xsl:template>
<xsl:template match="emph[position()=1 and position()=last()]" priority="1">
  <xsl:text>(E1)</xsl:text>
  <xsl:apply-templates/>
  <xsl:text>(/E1)</xsl:text>
</xsl:template>
<xsl:template match="emph[not(position()=1 and position()=last())]" priority="1">
  <xsl:text>(E2)</xsl:text>
  <xsl:apply-templates/>
  <xsl:text>(/E2)</xsl:text>
</xsl:template>
</xsl:stylesheet>
