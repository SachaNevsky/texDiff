<?xml version='1.0'?>
<xsl:stylesheet
 xmlns:xsl="http://www.w3.org/XSL/Transform/1.0"
 xmlns="http://www.w3.org/TR/REC-html40"
 result-ns="">
<xsl:template match="/">
  <html  xmlns="http://www.w3.org/Profiles/xhtml1-transitional.dtd">
  <head>
  <title>UTF8 files</title>
  <meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
  </head>
  <body>
  <h1>Handling UTF-8 files</h1>
  <xsl:apply-templates/>
  </body>
  </html>
</xsl:template>
<xsl:template match="br">
  <br />
</xsl:template>
<xsl:template match="par">
  <p><xsl:apply-templates/></p>
</xsl:template>
<xsl:template match="head">
  <h2><xsl:apply-templates/></h2>
</xsl:template>
<!-- eliminate English keyboard input -->
<xsl:template match="eng">
</xsl:template>
<!-- transmit Russian keyboard input -->
<xsl:template match="&#x0440;&#x0443;&#x0441;">
<p>&#x25c6;&#x00a0;<xsl:apply-templates/></p>
</xsl:template>
<!-- transmit Greek keyboard input -->
<xsl:template match="ελλ">
<p>●&#x00a0;<xsl:apply-templates/></p>
</xsl:template>
</xsl:stylesheet>

