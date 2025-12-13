<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0">

  <xsl:import href="http://www.oucs.ox.ac.uk/stylesheets/teihtml.xsl"/>
  <xsl:import href="http://www.oucs.ox.ac.uk/stylesheets/teihtml-oucsdoc.xsl"/>

   <xsl:template name="logoPicture"><a href="http://sourceforge.net"> <img
                     src="http://sourceforge.net/sflogo.php?group_id=28782"
                     width="88" height="31" border="0" alt="SourceForge
   Logo"/></a></xsl:template>
   <xsl:variable name="cssFile">http://www.oucs.ox.ac.uk/stylesheets/tei-oucs.css</xsl:variable>
   <xsl:variable name="feedbackURL">mailto:sebastian.rahtz@oucs.ox.ac.uk</xsl:variable>
   <xsl:variable name="feedbackWords">Feedback</xsl:variable>
   <xsl:variable name="homeLabel">Home</xsl:variable>
   <xsl:variable name="homeURL">http://www.oucs.ox.ac.uk/</xsl:variable>
   <xsl:variable name="homeWords">Jadetex Project</xsl:variable>
   <xsl:variable name="institution">Sourceforge</xsl:variable>
   <xsl:variable name="department"/>
   <xsl:variable name="parentURL">http://sourceforge.net/</xsl:variable>
   <xsl:variable name="parentWords">Sourceforge</xsl:variable>
   <xsl:variable name="searchURL">http://cvs.sourceforge.net/cgi-bin/cvsweb.cgi/?cvsroot=yourproject </xsl:variable>
  <xsl:variable name="searchWords">CVS web interface</xsl:variable>
   <xsl:variable name="topNavigationPanel">true</xsl:variable>
   <xsl:variable name="bottomNavigationPanel">true</xsl:variable>
   <xsl:variable name="alignNavigationPanel">right</xsl:variable>
   <xsl:variable name="linkPanel">true</xsl:variable>
   <xsl:template name="copyrightStatement">&#169; Sebastian Rahtz</xsl:template>
   <xsl:variable name="leftLinks"/>
   <xsl:variable name="rightLinks"/>
   <xsl:variable name="linksWidth">10%</xsl:variable>
   <xsl:param name="makeFrames"/>
   <xsl:variable name="frameCols">200,*</xsl:variable>
   <xsl:variable name="frameAlternateURL"/>
   <xsl:template name="logoFramePicture"/>
   <xsl:variable name="sectionUpLink"/>
   <xsl:template name="topLink"><p>[<a href="#TOP">Back to top</a>]</p></xsl:template>
   <xsl:variable name="appendixWords">Appendix</xsl:variable>
   <xsl:variable name="tocWords">Contents</xsl:variable>
   <xsl:variable name="upWord">Up</xsl:variable>
   <xsl:variable name="nextWord">Next</xsl:variable>
   <xsl:variable name="previousWord">Previous</xsl:variable>
   <xsl:template name="contentsWord">Contents</xsl:template>
   <xsl:variable name="dateWord">Date:</xsl:variable>
   <xsl:variable name="authorWord">Author:</xsl:variable>
   <xsl:variable name="divOffset">2</xsl:variable>
   <xsl:variable name="numberHeadings">1</xsl:variable>
   <xsl:variable name="prenumberedHeadings"></xsl:variable>
   <xsl:variable name="numberFrontHeadings"/>
   <xsl:variable name="numberBackHeadings">A.1</xsl:variable>
   <xsl:variable name="headingNumberSuffix">. </xsl:variable>
   <xsl:variable name="numberHeadingsDepth">9</xsl:variable>
   <xsl:variable name="fontURL">tt</xsl:variable>
   <xsl:variable name="tableAlign">center</xsl:variable>
   <xsl:variable name="showTitleAuthor"/>
   <xsl:variable name="footnoteFile"/>
   <xsl:variable name="minimalCrossRef"/>
   <xsl:variable name="graphicsPrefix"/>
   <xsl:variable name="graphicsSuffix">.jpg</xsl:variable>
   <xsl:variable name="showFigures">true</xsl:variable>
   <xsl:template name="bodyHook"/>
   <xsl:template name="headHook"/>
   <xsl:param name="verbose"/>
   <xsl:variable name="downPicture">http://www.oucs.ox.ac.uk/images/down.gif</xsl:variable>
   <xsl:variable name="useHeaderFrontMatter"/>
   <xsl:variable name="outputEncoding">iso-8859-1</xsl:variable>

   <xsl:variable name="rendSeparator" select="';'"/>



</xsl:stylesheet>
