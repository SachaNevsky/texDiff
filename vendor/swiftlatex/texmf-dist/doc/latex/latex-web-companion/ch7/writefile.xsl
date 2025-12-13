<xsl:stylesheet xmlns:xsl="http://www.w3.org/TR/WD-xsl" default-space="strip">
  <xsl:template match="file">
    <xsl:invoke classid="java:com.jclark.xsl.sax.TextFileOutputFilter">
      <xsl:arg name="file" value="{@filename}"/>
      <xsl:apply-templates/>
    </xsl:invoke>
  </xsl:template>
</xsl:stylesheet>
