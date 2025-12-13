<xsl:stylesheet xmlns:xsl="http://www.w3.org/TR/WD-xsl" default-space="strip">

<xsl:template match="makesum">
  <xsl:invoke classid="java:com.jclark.xsl.sax.TextFileOutputFilter">
    <xsl:arg name="file" value="sum.out"/>
    <xsl:invoke classid="java:com.jclark.xsl.sax.TotalFilter">
      <xsl:apply-templates/>
    </xsl:invoke>
  </xsl:invoke>
</xsl:template>

<xsl:template match="real">
  <number><xsl:apply-templates/></number>
</xsl:template>

</xsl:stylesheet>
