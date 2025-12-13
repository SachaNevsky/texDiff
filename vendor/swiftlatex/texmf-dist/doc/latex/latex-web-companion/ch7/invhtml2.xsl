<?xml version='1.0'?>
<xsl:stylesheet
 xmlns:xsl="http://www.w3.org/XSL/Transform/1.0"
 xmlns="http://www.w3.org/TR/REC-html40"
 result-ns="">

<xsl:template match="/">
<html>
<head>
<title> Invitation (XSL/CSS formatting) </title>
<link href="invit.css" rel="stylesheet" type="text/css"/>
<!-- 12 November 1998 mg -->
</head>
<body>
<h1>INVITATION</h1>
<table>
<tbody>
<tr><td class="front">To: </td>
<td><xsl:value-of select="@to"/></td></tr>
<tr><td class="front">When: </td>
<td><xsl:value-of select="@date"/></td></tr>
<tr><td class="front">Venue: </td>
<td><xsl:value-of select="@where"/></td></tr>
<tr><td class="front">Occasion: </td>
<td><xsl:value-of select="@why"/></td></tr>
</tbody>
</table>
<xsl:apply-templates/>
<p class="signature"><xsl:value-of select="@signature"/></p>
</body>
</html>
</xsl:template>

<xsl:template match="invitation/par">
<p><xsl:apply-templates/></p>
</xsl:template>

<xsl:template match="invitation/par/emph">
<em><xsl:apply-templates/></em>
</xsl:template>

</xsl:stylesheet>

