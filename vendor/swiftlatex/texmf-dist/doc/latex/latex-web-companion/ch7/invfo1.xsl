<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/XSL/Transform/1.0"
                xmlns:fo="http://www.w3.org/XSL/Format/1.0"
                result-ns="fo"
                default-space="">
<xsl:variable name="Fontsize">12pt</xsl:variable>
<xsl:template name="listitem">
  <xsl:param-variable name="labeltext">labeltext</xsl:param-variable>
  <xsl:param-variable name="itemid">itemid</xsl:param-variable>
  <xsl:param-variable name="itemtext">itemtext</xsl:param-variable>
  <fo:list-item id="{$itemid}">
    <fo:list-item-label font-style="italic">
      <xsl:value-of select="$labeltext"/>
      <xsl:text>:</xsl:text>
    </fo:list-item-label>
    <fo:list-item-body>
      <xsl:value-of select="$itemtext"/>
    </fo:list-item-body>
  </fo:list-item>
</xsl:template>

<xsl:template match='/'>
 <fo:page-sequence font-family="serif" font-size="{$Fontsize}"
                   margin-top="15mm"   margin-bottom="15mm"
                   margin-left="15mm"  margin-right="15mm"
                   page-width="120mm"  id="pageseq">
   <xsl:apply-templates/>
 </fo:page-sequence>
</xsl:template>

<xsl:template match="invitation/front">
<fo:block font-family="sans-serif"  font-size="24pt"
          font-weight="bold"        text-align="center">
  <xsl:text>INVITATION</xsl:text>
</fo:block>
<fo:list  label-width="2cm">
  <xsl:call-template name="listitem">
    <xsl:param name="labeltext">To</xsl:param>
    <xsl:param name="itemid">listto</xsl:param>
    <xsl:param name="itemtext"><xsl:value-of select="to"/></xsl:param>
  </xsl:call-template>
  <xsl:call-template name="listitem">
    <xsl:param name="labeltext">When</xsl:param>
    <xsl:param name="itemid">listdate</xsl:param>
    <xsl:param name="itemtext"><xsl:value-of select="date"/></xsl:param>
  </xsl:call-template>
  <xsl:call-template name="listitem">
    <xsl:param name="labeltext">Venue</xsl:param>
    <xsl:param name="itemid">listwhere</xsl:param>
    <xsl:param name="itemtext" expr="where"/>
  </xsl:call-template>
  <xsl:call-template name="listitem">
    <xsl:param name="labeltext">Occasion</xsl:param>
    <xsl:param name="itemid">listwhy</xsl:param>
    <xsl:param name="itemtext"><xsl:value-of select="why"/></xsl:param>
  </xsl:call-template>
</fo:list>
</xsl:template>

<xsl:template match="invitation/body/par">
  <fo:block space-before="{$Fontsize}">
    <xsl:apply-templates/>
  </fo:block>
</xsl:template>

<xsl:template match="invitation/body/par/emph">
  <fo:sequence font-style="italic">
    <xsl:apply-templates/>
  </fo:sequence>
</xsl:template>

<xsl:template match="invitation/back">
<fo:block space-before="{$Fontsize}"
          font-weight="bold" text-align="right">
   <xsl:text>From: </xsl:text>
   <xsl:value-of select="signature"/>
</fo:block>
</xsl:template>

</xsl:stylesheet>
