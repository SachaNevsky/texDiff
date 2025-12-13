<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/XSL/Transform/1.0"
                default-space="strip"
                result-ns="">

<xsl:template match="invitation">
<xsl:text>\documentclass[]{article}
\usepackage{invitation}
\begin{document}
</xsl:text>
<xsl:apply-templates/>
<xsl:text>\end{document}
</xsl:text>
</xsl:template>

<xsl:template match="invitation/front">
<xsl:text>\begin{Front}
\To{</xsl:text>
<xsl:value-of select="to"/>
<xsl:text>}
\Date{</xsl:text>
<xsl:value-of select="date"/>
<xsl:text>}
\Where{</xsl:text>
<xsl:value-of select="where"/>
<xsl:text>}
\Why{</xsl:text>
<xsl:value-of select="why"/>
<xsl:text>}
\end{Front}
</xsl:text>
</xsl:template>

<xsl:template match="invitation/body">
<xsl:text>\begin{Body}
</xsl:text>
  <xsl:apply-templates/>
<xsl:text>\end{Body}
</xsl:text>
</xsl:template>

<xsl:template match="invitation/body/par">
<xsl:text>\par</xsl:text>
<xsl:apply-templates/>
</xsl:template>

<xsl:template match="invitation/body/par/emph">
<xsl:text>\emph{</xsl:text>
<xsl:apply-templates/>
<xsl:text>}</xsl:text>
</xsl:template>

<xsl:template match="invitation/back">
<xsl:text>\begin{Back}
\Signature{</xsl:text>
<xsl:value-of select="signature"/>
<xsl:text>}
\end{Back}
</xsl:text>
</xsl:template>

</xsl:stylesheet>

