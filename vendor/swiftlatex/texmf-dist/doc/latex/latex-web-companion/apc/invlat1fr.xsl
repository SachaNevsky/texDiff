<?xml version='1.0' encoding="ISO-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/XSL/Transform/1.0"
                xmlns="http://www.tug.org/latex"
                default-space="strip"
                indent-result="no"
                result-ns="">

<xsl:template match="/">
<xsl:text>\documentclass[francais]{article}
\usepackage{invitation}
\usepackage[T1]{fontenc}
\begin{document}
</xsl:text>
<xsl:apply-templates/>
<xsl:text>\end{document}
</xsl:text>
</xsl:template>

<xsl:template match="invitation/entête">
<xsl:text>\begin{Front}
\To{</xsl:text>
<xsl:value-of select="à"/>
<xsl:text>}
\Date{</xsl:text>
<xsl:value-of select="date"/>
<xsl:text>}
\Where{</xsl:text>
<xsl:value-of select="où"/>
<xsl:text>}
\Why{</xsl:text>
<xsl:value-of select="pourquoi"/>
<xsl:text>}
\end{Front}
</xsl:text>
</xsl:template>

<xsl:template match="invitation/corps">
<xsl:text>\begin{Body}
</xsl:text>
  <xsl:apply-templates/>
<xsl:text>\end{Body}
</xsl:text>
</xsl:template>

<xsl:template match="invitation/corps/par">
<xsl:text>\par</xsl:text>
<xsl:apply-templates/>
</xsl:template>

<xsl:template match="invitation/corps/par/emph">
<xsl:text>\emph{</xsl:text>
<xsl:apply-templates/>
<xsl:text>}</xsl:text>
</xsl:template>

<xsl:template match="invitation/fin">
<xsl:text>\begin{Back}
\Signature{</xsl:text>
<xsl:value-of select="signature"/>
<xsl:text>}
\end{Back}
</xsl:text>
</xsl:template>

</xsl:stylesheet>

