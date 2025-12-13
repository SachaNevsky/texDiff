<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:db="http://docbook.org/ns/docbook"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                version="2.0">

  <xsl:template match="db:bibliography">
    <xsl:if test="title">
      <xsl:text>% \renewcommand{\bibname}{</xsl:text>
      <xsl:value-of select="title"/>
      <xsl:text>}&#xa;</xsl:text>
    </xsl:if>
    <xsl:if test="count(//db:biblioref) +
                  count(//db:citetitle[@linkend]) +
                  count(//db:blockquote[@linkend])=0">
      <xsl:text>% \nocite{*}&#xa;</xsl:text>
    </xsl:if>
    <xsl:text>% \clearpage
% \raggedright
% \bibliography{</xsl:text>
    <xsl:value-of select="/db:book/@xml:id"/>
    <xsl:text>}
% \bibliographystyle{</xsl:text>
    <xsl:value-of select="@label"/>
    <xsl:text>}
% \begin{VerbatimOut}{</xsl:text>
    <xsl:choose>
      <xsl:when test="@xlink:href">
        <xsl:value-of select="@xlink:href"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="/db:book/@xml:id"/>    
      </xsl:otherwise>
    </xsl:choose>
    <xsl:text>.bib}
%&lt;*ignore>&#xa;</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>%&lt;/ignore>
% \end{VerbatimOut}&#xa;</xsl:text>
  </xsl:template>

  <xsl:template match="db:biblioentry">
    <xsl:text>@</xsl:text>
    <xsl:choose>
      <xsl:when test="@xreflabel='standard' and @role">
        <xsl:text>techreport</xsl:text>
      </xsl:when>
      <xsl:when test="@xreflabel='patent'">
        <xsl:text>misc</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="@xreflabel"/>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:text>{</xsl:text>
    <xsl:value-of select="@xml:id"/>
    <xsl:apply-templates/>
    <xsl:if test="@xreflabel='standard' and @role">
      <xsl:text>,&#xa;publisher &#x9; = {</xsl:text>
      <xsl:value-of select="@role"/>
      <xsl:text>}</xsl:text>
    </xsl:if>
    <xsl:if test="@xreflabel='inproceedings'
                  and not(descendant::db:publisher) 
                  and not(descendant::db:publishername) 
                  and not(descendant::db:orgname)
                  and not(descendant::db:volumenum)
                  and not(descendant::db:issuenum)">
      <xsl:text>,&#xa;publisher &#x9; = {Unpublished}</xsl:text>
    </xsl:if>
    <xsl:if test="not(descendant::db:date) and descendant::db:confdates">
      <xsl:for-each select="descendant::db:confdates[1]">
        <xsl:call-template name="dodate"/>
      </xsl:for-each>
    </xsl:if>
    <xsl:text>&#xa;}&#xa;</xsl:text>
  </xsl:template>

  <xsl:template match="db:biblioentry/db:authorgroup">
    <xsl:apply-templates/>
    <xsl:text>,&#xa;shortauthor &#x9; = {</xsl:text>
    <xsl:value-of select="db:author[1]/db:personname/db:surname |
                          db:author[1]/db:orgname | 
                          db:editor[1]/db:personname/db:surname"/>
    <xsl:choose>
      <xsl:when test="count(db:author)+count(db:editor)=2">
        <xsl:text> \&amp; </xsl:text>
        <xsl:value-of select="db:author[2]/db:personname/db:surname | 
                              db:author[2]/db:orgname | 
                              db:editor[2]/db:personname/db:surname"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text> \textit{et al.}</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
    <!--
    <xsl:if test="db:editor">
      <xsl:text> (Ed</xsl:text>
      <xsl:if test="count(db:editor)>1">
        <xsl:text>s</xsl:text>
      </xsl:if>
      <xsl:text>)</xsl:text>
    </xsl:if>
    -->
    <xsl:text>}</xsl:text>
  </xsl:template>

  <xsl:template match="db:biblioentry//db:author | 
                       db:biblioentry//db:editor |
                       db:biblioentry//db:authorgroup/db:author | 
                       db:biblioentry//db:authorgroup/db:editor">
    <xsl:if test="count(preceding-sibling::*[name()=current()/name()])=0">
      <xsl:text>,&#xa;</xsl:text>
      <xsl:value-of select="name()"/>
      <xsl:text> &#x9; = {</xsl:text>
    </xsl:if>
    <xsl:if test="preceding-sibling::*[name()=current()/name()]">
      <xsl:text> and </xsl:text>
    </xsl:if>
    <!-- only one -->
    <xsl:for-each select="db:personname | db:orgname">
      <xsl:if test="db:firstname">
        <xsl:choose>
          <xsl:when test="db:firstname/@role='as-is'">
            <xsl:text>{</xsl:text>
            <xsl:value-of select="db:firstname"/>
            <xsl:text>}</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="db:firstname"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:if>
      <xsl:if test="db:othername">
        <xsl:text> </xsl:text>
        <xsl:value-of select="db:othername"/>
      </xsl:if>
      <xsl:choose>
        <xsl:when test="local-name()='orgname'">
          <xsl:apply-templates/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text> </xsl:text>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
        <xsl:when test="contains(db:surname,' ')">
          <xsl:text>{</xsl:text>
          <xsl:value-of select="db:surname"/>
          <xsl:text>}</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="db:surname"/>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:if test="db:honorific">
        <xsl:text> </xsl:text>
        <xsl:value-of select="db:honorific"/>
      </xsl:if>
    </xsl:for-each>
    <xsl:if test="count(following-sibling::*[name()=current()/name()])=0">
      <xsl:text>}</xsl:text>
      <!-- do shortauthor for solo authors/editors here -->
      <xsl:if test="count(../*[name()=current()/name()]) = 1 
                    and not(parent::db:authorgroup)">
        <xsl:text>,&#xa;short</xsl:text>
      <xsl:value-of select="name()"/>
      <xsl:text> &#x9; = {</xsl:text>
        <xsl:value-of select="db:personname/db:surname | db:orgname"/>
        <xsl:text>}</xsl:text>
      </xsl:if>
    </xsl:if>
  </xsl:template>

  <xsl:template match="db:biblioentry//db:corpauthor">
    <xsl:if test="count(preceding-sibling::db:author |
                        preceding-sibling::db:corpauthor)=0">
      <xsl:text>,&#xa;author &#x9; = {{</xsl:text>
    </xsl:if>
    <xsl:if test="preceding-sibling::db:author |
                  preceding-sibling::db:corpauthor">
      <xsl:text> and </xsl:text>
    </xsl:if>
    <xsl:choose>
      <xsl:when test="@remap">
        <xsl:value-of select="@remap"/>
      </xsl:when>
      <xsl:when test="not(@remap)">
        <xsl:text>{</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>}</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates/>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:if test="count(following-sibling::db:author |
                        following-sibling::db:corpauthor)=0">
      <xsl:text>}}</xsl:text>
      <xsl:if test="count(preceding-sibling::db:author |
                          preceding-sibling::db:corpauthor)=0">
        <xsl:text>,&#xa;shortauthor &#x9; = {{</xsl:text>
        <xsl:choose>
          <xsl:when test="@remap">
            <xsl:value-of select="@remap"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of 
              select="translate(normalize-space(.),
                      '.,;:-abcdefghijklmnopqrstuvwxyz ','')"/>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:text>}}</xsl:text>
      </xsl:if>
    </xsl:if>
  </xsl:template>

  <xsl:template match="db:biblioset">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="db:biblioentry//db:title">
    <xsl:text>,&#xa;</xsl:text>
    <xsl:choose>
      <!-- if field is hardwired, use it -->
      <xsl:when test="@role">
        <xsl:value-of select="@role"/>
      </xsl:when>
      <!-- article titles are inside the biblioset -->
      <xsl:when test="parent::db:biblioset">
        <xsl:text>title</xsl:text>
      </xsl:when>
      <!-- articles use this for the journal because the article
           title was wrapped in a biblioset -->
      <xsl:when test="parent::db:biblioentry/@xreflabel='article'">
        <xsl:text>journal</xsl:text>
      </xsl:when>
      <!-- books and collections and journals use it for the booktitle -->
      <xsl:when test="parent::db:biblioentry/@xreflabel='inbook' or
                      parent::db:biblioentry/@xreflabel='incollection' or
                      parent::db:biblioentry/@xreflabel='inproceedings'">
        <xsl:text>booktitle</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>title</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:text> &#x9; = {{</xsl:text>
    <xsl:apply-templates/>
    <!-- if there is a matching subtitle, pick the right one -->
    <xsl:for-each select="following-sibling::db:subtitle
                          [@role=current()/@role or 
                           (not(@role) and not(current()/@role))]">
      <xsl:choose>
        <xsl:when test="starts-with(.,'(')">
          <xsl:text> </xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>: </xsl:text>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates/>
    </xsl:for-each>
    <xsl:text>}}</xsl:text>
  </xsl:template>

  <xsl:template match="db:biblioentry//db:subtitle"/>

  <xsl:template match="db:biblioid | db:bibliosource | 
                       db:citebiblioid | db:isbn | db:issn">
    <!-- doi isbn isrn issn libraryofcongress pubsnumber uri other -->
    <xsl:text>,&#xa;</xsl:text>
    <xsl:choose>
      <xsl:when test="@class='uri'">
        <xsl:text>url</xsl:text>
      </xsl:when>
      <xsl:when test="@class='doi'">
        <xsl:value-of select="@class"/>
      </xsl:when>
      <xsl:when test="local-name()='isbn' or 
                      @class='isbn' or
                      ancestor::db:biblioentry/@xreflabel='book'">
        <xsl:text>isbn</xsl:text>
      </xsl:when>
      <xsl:when test="local-name()='issn' or
                      @class='issn' or
                      ancestor::db:biblioentry/@xreflabel='article'">
        <xsl:text>issn</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>number</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:text> &#x9; = {</xsl:text>
    <xsl:choose>
      <xsl:when test="@class='other' and @otherclass">
        <xsl:value-of select="@otherclass"/>
        <xsl:text> </xsl:text>
      </xsl:when>
      <xsl:when test="@class='libraryofcongress'">
        <xsl:text>LoC</xsl:text>
        <xsl:text>: </xsl:text>
      </xsl:when>
    </xsl:choose>
    <xsl:apply-templates/>
    <xsl:text>}</xsl:text>
    <xsl:choose>
      <xsl:when test="@YYYY-MM-DD 
                      and ancestor::db:bibliography/@label='apacite'">
        <xsl:text>,&#xa;lastchecked &#x9; = {</xsl:text>
        <xsl:if test="string-length(@YYYY-MM-DD)>8">
          <xsl:value-of select="substring(@YYYY-MM-DD,9,2)"/>
          <xsl:text> </xsl:text>
        </xsl:if>
        <xsl:if test="string-length(@YYYY-MM-DD)>5">
          <xsl:call-template name="months">
            <xsl:with-param name="month" 
              select="number(substring(@YYYY-MM-DD,6,2))"/>
          </xsl:call-template>
          <xsl:text> </xsl:text>
        </xsl:if>
        <xsl:value-of select="substring(@YYYY-MM-DD,1,4)"/>
        <xsl:text>}</xsl:text>
      </xsl:when>
      <xsl:when test="@YYYY-MM-DD and not(ancestor::db:biblioentry//db:date)">
        <xsl:text>,&#xa;year &#x9; = {</xsl:text>
        <xsl:value-of select="substring(@YYYY-MM-DD,1,4)"/>
        <xsl:text>}</xsl:text>
        <xsl:if test="string-length(@YYYY-MM-DD)>5">
          <xsl:text>,&#xa;month &#x9; = {</xsl:text>
          <xsl:call-template name="months">
            <xsl:with-param name="month" 
              select="number(substring(@YYYY-MM-DD,6,2))"/>
          </xsl:call-template>
          <xsl:text>}</xsl:text>
        </xsl:if>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="db:titleabbrev">
    <xsl:text>,&#xa;shorttitle &#x9; = {{</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>}}</xsl:text>
  </xsl:template>

  <xsl:template match="db:bibliocoverage">
    <xsl:text>,&#xa;</xsl:text>
    <xsl:value-of select="@remap"/>
    <xsl:text> &#x9; = {</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>}</xsl:text>
  </xsl:template>

  <xsl:template match="db:seriesvolnums">
    <xsl:text>,&#xa;number &#x9; = {</xsl:text>
    <xsl:if test="@xreflabel">
      <xsl:value-of select="@xreflabel"/>
      <xsl:text> </xsl:text>
    </xsl:if>
    <xsl:apply-templates/>
    <xsl:text>}</xsl:text>
  </xsl:template>

  <xsl:template match="db:collab">
    <xsl:text>,&#xa;note &#x9; = {</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>}</xsl:text>
  </xsl:template>

  <xsl:template match="db:publisher">
    <xsl:choose>
      <xsl:when test="ancestor::db:biblioentry/@xreflabel='misc'">
        <xsl:text>,&#xa;howpublished &#x9; = {</xsl:text>
        <xsl:apply-templates select="db:address/node()"/>
        <xsl:text>: </xsl:text>
        <xsl:apply-templates select="db:publishername/node()"/>
        <xsl:text>}</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="db:publishername">
    <xsl:text>,&#xa;</xsl:text>
    <xsl:choose>
      <xsl:when test="ancestor::db:biblioentry/@xreflabel='techreport' or
                      ancestor::db:biblioentry/@xreflabel='standard'">
        <xsl:text>institution</xsl:text>
      </xsl:when>
      <xsl:when test="ancestor::db:biblioentry/@xreflabel='phdthesis' or
                      ancestor::db:biblioentry/@xreflabel='mastersthesis'">
        <xsl:text>school</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>publisher</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:text> &#x9; = {</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>}</xsl:text>
  </xsl:template>

  <xsl:template match="db:confgroup">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="db:conftitle">
    <xsl:text>,&#xa;series &#x9; = {{</xsl:text>
    <xsl:apply-templates/>
    <xsl:if test="../db:confdates">
      <xsl:text> (</xsl:text>
      <xsl:apply-templates select="../db:confdates/node()"/>
      <xsl:text>)</xsl:text>
    </xsl:if>
    <xsl:text>}}</xsl:text>
  </xsl:template>

  <xsl:template match="db:confsponsor">
    <xsl:text>,&#xa;organization &#x9; = {</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>}</xsl:text>
  </xsl:template>

  <xsl:template match="db:confgroup/db:address">
    <xsl:text>,&#xa;address &#x9; = {</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>}</xsl:text>
  </xsl:template>

  <xsl:template match="db:confdates"/>

  <xsl:template match="db:confnum">
        <xsl:text>,&#xa;series &#x9; = {</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>}</xsl:text>
  </xsl:template>

  <xsl:template match="db:date">
    <xsl:call-template name="dodate"/>
  </xsl:template>

  <xsl:template name="dodate">
    <xsl:text>,&#xa;year &#x9; = {</xsl:text>
    <xsl:value-of select="substring(@YYYY-MM-DD,1,4)"/>
    <xsl:text>}</xsl:text>
    <xsl:if test="string-length(@YYYY-MM-DD)&gt;=7">
      <xsl:text>,&#xa;month &#x9; = {</xsl:text>
      <xsl:variable name="month">
        <xsl:call-template name="months">
          <xsl:with-param name="month" 
            select="number(substring(@YYYY-MM-DD,6,2))"/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:value-of select="substring($month,1,3)"/>
      <xsl:text>}</xsl:text>
    </xsl:if>
    <xsl:if test="ancestor::db:biblioentry/@xreflabel='pc'">
      <xsl:text>,&#xa;howpublished &#x9; = {Pers.\ Comm.}</xsl:text>
    </xsl:if>
  </xsl:template>

  <xsl:template match="db:productnumber">
    <xsl:text>,&#xa;number &#x9; = {</xsl:text>
    <xsl:value-of select="."/>
    <xsl:text>}</xsl:text>
  </xsl:template>

  <xsl:template match="db:pagenums|db:artpagenums">
    <xsl:text>,&#xa;pages &#x9; = {</xsl:text>
    <xsl:value-of select="translate(.,'–','-')"/>
    <xsl:text>}</xsl:text>
  </xsl:template>

  <xsl:template match="db:volumenum">
    <xsl:text>,&#xa;volume &#x9; = {</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>}</xsl:text>
  </xsl:template>

  <xsl:template match="db:releaseinfo">
    <xsl:text>,&#xa;url &#x9; = {</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>}</xsl:text>
  </xsl:template>

  <xsl:template match="db:issuenum | db:invpartnumber">
    <xsl:text>,&#xa;number &#x9; = {</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>}</xsl:text>
  </xsl:template>

  <xsl:template match="db:publisher/db:address">
    <xsl:text>,&#xa;</xsl:text>
    <xsl:choose>
      <xsl:when test="starts-with(normalize-space(.),'http://') or
                      starts-with(normalize-space(.),'ftp://') or
                      starts-with(normalize-space(.),'mailto:') or
                      starts-with(normalize-space(.),'https://')">
        <xsl:text>url</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>address</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:text> &#x9; = {</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>}</xsl:text>
  </xsl:template>

  <xsl:template match="db:edition">
    <xsl:text>,&#xa;edition &#x9; = {</xsl:text>
    <xsl:choose>
      <xsl:when test="not(number(.))">
        <xsl:apply-templates/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates/>
        <xsl:choose>
          <xsl:when test="substring(.,string-length(.))='1' and 
                          substring(.,string-length(.)-1)!='11'">
            <xsl:text>st</xsl:text>
          </xsl:when>
          <xsl:when test="substring(.,string-length(.))='2' and
                          substring(.,string-length(.)-1)!='12'">
            <xsl:text>nd</xsl:text>
          </xsl:when>
          <xsl:when test="substring(.,string-length(.))='3' and
                          substring(.,string-length(.)-1)!='13'">
            <xsl:text>rd</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>th</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:text>}</xsl:text>
  </xsl:template>

  <xsl:template name="months">
    <xsl:param name="month"/>
    <xsl:choose>
      <xsl:when test="$month=1">
        <xsl:text>January</xsl:text>
      </xsl:when>
      <xsl:when test="$month=2">
        <xsl:text>February</xsl:text>
      </xsl:when>
      <xsl:when test="$month=3">
        <xsl:text>March</xsl:text>
      </xsl:when>
      <xsl:when test="$month=4">
        <xsl:text>April</xsl:text>
      </xsl:when>
      <xsl:when test="$month=5">
        <xsl:text>May</xsl:text>
      </xsl:when>
      <xsl:when test="$month=6">
        <xsl:text>June</xsl:text>
      </xsl:when>
      <xsl:when test="$month=7">
        <xsl:text>July</xsl:text>
      </xsl:when>
      <xsl:when test="$month=8">
        <xsl:text>August</xsl:text>
      </xsl:when>
      <xsl:when test="$month=9">
        <xsl:text>September</xsl:text>
      </xsl:when>
      <xsl:when test="$month=10">
        <xsl:text>October</xsl:text>
      </xsl:when>
      <xsl:when test="$month=11">
        <xsl:text>November</xsl:text>
      </xsl:when>
      <xsl:when test="$month=12">
        <xsl:text>December</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:message>
          <xsl:text>Month must be a number from 1 to 12 in </xsl:text>
          <xsl:value-of select="name()"/>
        </xsl:message>
        <xsl:text>NaN</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
