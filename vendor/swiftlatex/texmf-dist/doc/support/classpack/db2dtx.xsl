<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:db="http://docbook.org/ns/docbook"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                version="2.0">

  <!-- db2dtx.xsl
       XSL script to transform DocBook5 documentation and code of a
       LaTeX package or class file into a DocTeX (.dtx and .ins)
       distribution.
       Full processing command chain is output to file 'build'
       Note this requires an XSLT2 processor (eg Saxon9 or above)
  -->

  <xsl:variable name="thisversion">
    <xsl:text>15.02 (autopackage with multifile)</xsl:text>
  </xsl:variable>

  <xsl:output method="text"/>
  <xsl:output method="text" name="textFormat"/>

  <xsl:include href="db2bibtex.xsl"/>
  <xsl:include href="db2plaintext.xsl"/>

  <!-- path to the XSLT processor (eg Saxon) -->
  <xsl:param name="processor"/>
  <!-- path to the classpack directory -->
  <xsl:param name="cpdir"/>
  <!-- path to the project's app dev directory -->
  <xsl:param name="appdir"/>

  <xsl:variable name="prepost" 
    select="document(concat($cpdir,'/prepost.xml'))/db:refsection"/>
  <xsl:variable name="langs" 
    select="document(concat($cpdir,'/languages.xml'))/languages"/>
  <xsl:variable name="readme" 
    select="document(concat($cpdir,'/readme.xml'))/db:chapter"/>
  <xsl:variable name="licence" 
    select="document(concat($appdir,'/',/db:book/@audience,'.xml'))/db:chapter"/>
  <xsl:variable name="thisdoc" select="/"/>

  <xsl:variable name="maxcodelen">
    <xsl:text>40</xsl:text>
  </xsl:variable>

  <xsl:variable name="personaltree">
    <xsl:text>~/texmf</xsl:text>
  </xsl:variable>

  <xsl:variable name="name" select="/db:book/@xml:id"/>
  <xsl:variable name="doctype" select="/db:book/@arch"/>
  <xsl:variable name="version" select="/db:book/@version"/>
  <xsl:variable name="revision" select="/db:book/@revision"/>
  <xsl:variable name="filetype" select="/db:book/@userlevel"/>

  <xsl:variable name="latestrevhist" 
    select="/db:book/db:info/db:revhistory/db:revision
            [not(../db:revision/@version > @version)]/@version"/>

  <xsl:template match="/">
    <xsl:message>
      <xsl:text>This is DB2DTX, Version </xsl:text>
      <xsl:value-of select="$thisversion"/>
      <xsl:text>.</xsl:text>
    </xsl:message>
    <!-- don't do anything if the version numbers don't accord -->
    <xsl:choose>
      <xsl:when test="concat($version,'.',$revision) != $latestrevhist">
        <xsl:message>
          <xsl:text>! Declared version </xsl:text>
          <xsl:value-of select="$version"/>
          <xsl:text>.</xsl:text>
          <xsl:value-of select="$revision"/>
          <xsl:text> does not match latest revision history </xsl:text>
          <xsl:value-of select="$latestrevhist"/>
          <xsl:text>&#xa;  I'm sorry, I can't go on until you fix this.</xsl:text>
        </xsl:message>
      </xsl:when>
      <xsl:otherwise>
        <!-- output the .ins file first -->
        <xsl:apply-templates select="/db:book/db:info" mode="ins"/>
        <!-- then the build file -->
        <xsl:call-template name="build"/>
        <!-- then the README -->
        <xsl:call-template name="readme"/>
        <!-- and then the MANIFEST -->
        <xsl:call-template name="manifest"/>
        <!-- and finally start creating the .dtx file -->
        <xsl:text>% \iffalse meta-comment
%
</xsl:text>
        <xsl:call-template name="copyright-statement">
          <xsl:with-param name="ftype">
            <xsl:text>dtx</xsl:text>
          </xsl:with-param>
        </xsl:call-template>
        <xsl:text>%
% \fi
% \iffalse&#xa;</xsl:text>
        <!-- special exception for classes: needs \ProvidesFile -->
        <xsl:if test="$doctype='class'">
          <xsl:text>%&lt;*driver>
\ProvidesFile{</xsl:text>
          <xsl:value-of select="$name"/>
          <xsl:text>.dtx}
%&lt;/driver>
</xsl:text>
        </xsl:if>
        <!-- prefix with <class> or <package> as appropriate -->
        <xsl:text>%&lt;</xsl:text>
        <xsl:value-of select="$doctype"/>
        <xsl:text>>\NeedsTeXFormat{</xsl:text>
        <xsl:value-of select="/db:book/@conformance"/>
        <xsl:text>}[</xsl:text>
        <xsl:value-of select="translate(/db:book/@condition,'-','/')"/>
        <xsl:text>]
%&lt;</xsl:text>
        <xsl:value-of select="$doctype"/>
        <xsl:text>>\Provides</xsl:text>
        <xsl:value-of select="translate(substring($doctype,1,1),
                              'abcdefghijklmn0pqrstuvwxyz',
                              'ABCDEFGHIJKLMN0PQRSTUVWXYZ')"/>
        <xsl:value-of select="substring($doctype,2)"/>
        <xsl:text>{</xsl:text>
        <xsl:value-of select="$name"/>
        <xsl:text>}</xsl:text>
        <!-- used to be a newline and repeat tag here for classes -->
        <xsl:text>[</xsl:text>
        <!-- use the latest revision date as the distro date -->
        <xsl:for-each select="//db:info/db:revhistory/db:revision">
          <xsl:sort select="@version" order="ascending"/>
          <xsl:if test="position()=last()">
            <xsl:value-of 
              select="translate(db:date/@conformance,'-','/')"/>
          </xsl:if>
        </xsl:for-each>
        <xsl:text> v</xsl:text>
        <xsl:value-of select="/db:book/@version"/>
        <xsl:text>.</xsl:text>
        <xsl:value-of select="/db:book/@revision"/>
        <xsl:text>&#xa;%&lt;</xsl:text>
        <xsl:value-of select="$doctype"/>
        <xsl:text>> </xsl:text>
        <xsl:variable name="title">
          <xsl:choose>
            <xsl:when test="//db:info/db:subtitle">
              <xsl:value-of select="normalize-space(//db:info/db:subtitle)"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="normalize-space(//db:info/db:title)"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:call-template name="delogify">
          <xsl:with-param name="string" select="$title"/>
        </xsl:call-template>
        <!--
        <xsl:text> </xsl:text>
        <xsl:value-of select="$doctype"/>
        -->
        <xsl:text>]&#xa;</xsl:text>
        <!-- now add any packages needed for the class/package (only)
             unless they are to be deferred to a later 
             section identified by an ID (in linkend)
             This is done to allow declarations to wait until after options.
             -->
        <xsl:if test="/db:book/db:info/db:cover
                    /db:constraintdef[@xml:id=concat($filetype,'packages')]
                    [not(@linkend)]
                    /db:segmentedlist/db:seglistitem[db:seg!='']">
          <xsl:text>%%
%% Packages that need to be invoked at the start
%%&#xa;</xsl:text>
          <xsl:for-each 
            select="/db:book/db:info/db:cover
                    /db:constraintdef[@xml:id=concat($filetype,'packages')]
                    [not(@linkend)]
                    /db:segmentedlist/db:seglistitem[db:seg!='']">
            <xsl:call-template name="packages">
              <xsl:with-param name="pkg" select="."/>
              <xsl:with-param name="dest" select="$filetype"/>
            </xsl:call-template>
          </xsl:for-each>
        </xsl:if>
        <!-- then start on the documentation -->
        <xsl:text>%&lt;*driver>&#xa;</xsl:text>
        <!-- special action to preload xcolor options -->
        <!-- \PassOptionsToPackage{svgnames}{xcolor} -->
        <xsl:text>\PassOptionsToPackage{svgnames}{xcolor}&#xa;</xsl:text>
        <xsl:text>\documentclass</xsl:text>
        <xsl:if test="/db:book/@remap">
          <xsl:text>[</xsl:text>
          <xsl:value-of select="/db:book/@remap"/>
          <xsl:text>]</xsl:text>
        </xsl:if>
        <xsl:text>{ltxdoc}&#xa;</xsl:text>
        <!--
             PACKAGES FOR DOCUMENTATION

             Ensure we use all the required packages for documentation 
             (this applies in both package and class cases). This invokes
             the pre- and post-commands from prepost.xml -->
        <!-- AUTOPACKAGE: construct a node-set of packages needed -->
        <xsl:variable name="packages">
          <!-- go through every step (package) in the PREPACKAGE spec
               which has a constructorsynopsis element type -->
          <xsl:for-each 
            select="$prepost/db:procedure/
                    db:step/db:constructorsynopsis">
            <!-- build a node-list of elements in the 
                 USER DOCUMENTATION, METADATA, or LICENCE
                 which match the @condition on the constructorsynopsis -->
            <xsl:variable name="elements" 
              select="$thisdoc/db:book/db:part[@xml:id='doc'
                      and current()/@condition='']
                      |
                      $thisdoc/db:book/db:part[@xml:id='doc']/
                      descendant::*[name()=current()/@condition] 
                      |
                      $thisdoc/db:book/db:info/
                      (db:title|db:author|db:abstract|db:annotation)/
                      descendant::*[name()=current()/@condition]
                      |
                      $licence//descendant::*[name()=current()/@condition]"/>
            <!--
            <xsl:if test="count($elements)>0">
              <xsl:message>
                <xsl:text>Checking for package </xsl:text>
                <xsl:value-of select="parent::db:step/@remap"/>
                <xsl:text>: &#x2329;</xsl:text>
                <xsl:value-of select="@condition"/>
                <xsl:text>&#x232a; has </xsl:text>
                <xsl:value-of select="count($elements)"/>
                <xsl:text> occurrences</xsl:text>
              </xsl:message>
            </xsl:if>
            -->
            <!-- if there are some elements matching, and the package is 
                 not already explicitly requested or is not blocked -->
            <xsl:if test="count($elements)>0 and 
              not($thisdoc//db:constraintdef[@xml:id='docpackages']
              /db:segmentedlist/db:seglistitem
              [db:seg=current()/parent::db:step/@remap]
              [not(@condition='off')])">
              <xsl:choose>
                <!-- if the constructorsynopsis element is empty
                     then the package is required unconditionally 
                     but may be excluded later if another package already
                     loads it (specified in @conformance) -->
                <xsl:when test="count(db:methodparam)=0">
                  <db:seglistitem role="{@condition} was detected."
                    conformance="{@conformance}">
                    <db:seg>
                      <xsl:if test="parent::db:step/@role">
                        <xsl:attribute name="role">
                          <xsl:value-of select="parent::db:step/@role"/>
                        </xsl:attribute>
                      </xsl:if>
                      <xsl:value-of select="parent::db:step/@remap"/>
                    </db:seg>
                  </db:seglistitem>
                </xsl:when>
                <!-- otherwise there are two ways to match: -->
                <xsl:otherwise>
                  <xsl:for-each select="db:methodparam">
                    <xsl:choose>
                      <!-- 1. a parameter giving the attribute, 
                              with an optional modifier giving a value -->
                      <xsl:when 
                        test="db:parameter and
                              $elements[@*[name()=current()/db:parameter]]">
                        <xsl:choose>
                          <xsl:when test="count(db:modifier)=0">
                            <db:seglistitem role="{parent::db:constructorsynopsis/@condition}/@{db:parameter} was detected."
                    conformance="{@conformance}">
                              <db:seg>
                                <xsl:if test="ancestor::db:step/@role">
                                  <xsl:attribute name="role">
                                    <xsl:value-of select="ancestor::db:step/@role"/>
                                  </xsl:attribute>
                                </xsl:if>
                                <xsl:value-of select="ancestor::db:step/@remap"/>
                              </db:seg>
                            </db:seglistitem>
                          </xsl:when>
                          <xsl:otherwise>
                            <xsl:if 
                              test="$elements[@*[name()=current()/db:parameter]
                                    =current()/db:modifier]">
                              <db:seglistitem role="{parent::db:constructorsynopsis/@condition}/@{db:parameter}='{db:modifier}' was detected."
                    conformance="{@conformance}">
                                <db:seg>
                                  <xsl:if test="ancestor::db:step/@role">
                                    <xsl:attribute name="role">
                                      <xsl:value-of select="ancestor::db:step/@role"/>
                                    </xsl:attribute>
                                  </xsl:if>
                                  <xsl:value-of select="ancestor::db:step/@remap"/>
                                </db:seg>
                              </db:seglistitem>
                            </xsl:if>
                          </xsl:otherwise>
                        </xsl:choose>
                      </xsl:when>
                      <!-- 2. a funcparams giving the IDREF attribute
                              with a modifier giving the name of the 
                              element type that the IDREF points at -->
                      <xsl:when
                        test="db:funcparams and
                              $elements[@*[name()=current()/db:funcparams]]">
                        <xsl:variable name="modval" select="db:modifier"/>
                        <xsl:variable name="prepstep" 
                          select="ancestor::db:step"/>
                        <xsl:variable name="prepmeth"
                          select="."/>
                        <!-- enter the document context -->
                        <xsl:for-each
                          select="$elements/@*[name()=current()/db:funcparams]">
                          <xsl:if test="name($thisdoc//*[@xml:id=current()/.])=
                                        $modval">
                            <db:seglistitem role="{$prepstep/db:constructorsynopsis/@condition}/@{$prepmeth/db:funcparams}='{$prepmeth/db:modifier}' was detected."
                    conformance="{$prepstep/db:constructorsynopsis/@conformance}">
                              <db:seg>
                                <xsl:if test="$prepstep/@role">
                                  <xsl:attribute name="role">
                                    <xsl:value-of select="$prepstep/@role"/>
                                  </xsl:attribute>
                                </xsl:if>
                                <xsl:value-of select="$prepstep/@remap"/>
                              </db:seg>
                            </db:seglistitem>
                          </xsl:if>
                        </xsl:for-each>
                      </xsl:when>
                      <!--
                      <xsl:otherwise>
                        <db:seglistitem 
                          role="parameter:{db:parameter};funcparams={db:funcparams};modifier={db:modifier}"
                    conformance="{@conformance}">
                          <db:seg>unmatched</db:seg>
                        </db:seglistitem>
                      </xsl:otherwise>
                      -->
                      <!-- there is no otherwise -->
                    </xsl:choose>
                  </xsl:for-each>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:if>
          </xsl:for-each>
        </xsl:variable>
        <!--
        <xsl:message>
          <xsl:value-of select="count($packages/*)"/>
          <xsl:text> packages detected </xsl:text>
          <xsl:text> times: names and values are:&#xa;</xsl:text>
          <xsl:for-each select="$packages/*">
            <xsl:value-of select="name()"/>
            <xsl:text> : </xsl:text>
            <xsl:value-of select="child::*[1]"/>
            <xsl:text>&#xa;</xsl:text>
          </xsl:for-each>
        </xsl:message>
        -->
        <xsl:if test="count($packages/db:seglistitem)>0">
          <!--
          <xsl:message>
            <xsl:text>AUTOPACKAGE</xsl:text>
          </xsl:message>
          -->
          <xsl:text>%%
%% Packages added automatically
%%&#xa;</xsl:text>
          <xsl:for-each-group select="$packages/db:seglistitem" 
            group-by="db:seg">
            <xsl:choose>
              <xsl:when 
                test="$packages/db:seglistitem[db:seg=current()/@conformance]">
                <!--
                <xsl:message>
                  <xsl:text>Omitting </xsl:text>
                  <xsl:value-of select="db:seg"/>
                  <xsl:text> automagically</xsl:text>
                </xsl:message>
                -->
              </xsl:when>
              <xsl:otherwise>
                <!--
                <xsl:message>
                  <xsl:text>Adding </xsl:text>
                  <xsl:value-of select="db:seg"/>
                  <xsl:text> automagically</xsl:text>
                </xsl:message>
                -->
                <xsl:call-template name="packages">
                  <xsl:with-param name="pkg" select="."/>
                  <xsl:with-param name="dest" select="'doc'"/>
                </xsl:call-template>                
              </xsl:otherwise>
            </xsl:choose>
          </xsl:for-each-group>
        </xsl:if>
        <!-- EXTRAS that AUTOPACKAGE can't handle -->
        <!-- 1. Special for babel, needs languages -->
        <xsl:variable name="baselang" select="/db:book/@xml:lang"/>
        <xsl:if test="/db:book/db:part[@xml:id='doc']/
                      descendant::*[@xml:lang][@xml:lang!=$baselang]">
          <xsl:text>% added babel automatically&#xa;\usepackage[</xsl:text>
          <xsl:for-each-group group-by="@xml:lang"
            select="/db:book/db:part[@xml:id='doc']/
                    descendant::*[@xml:lang][@xml:lang!=$baselang]">
            <xsl:value-of 
              select="tokenize($langs/language[@iso=current()/@xml:lang]/@babel,
                      ' ')[1]"/>
            <xsl:text>,</xsl:text>
          </xsl:for-each-group>
          <xsl:value-of select="tokenize($langs/language[@iso=$baselang]/@babel,
                      ' ')[1]"/>
          <xsl:text>]{babel}&#xa;</xsl:text>
          <xsl:message>
            <xsl:text>Adding babel automatically for </xsl:text>
            <xsl:for-each-group group-by="@xml:lang"
              select="/db:book/db:part[@xml:id='doc']/
                      descendant::*[@xml:lang][@xml:lang!=$baselang]
                      [not(local-name()='cmdsynopsis' or
                           local-name()='command' or
                           local-name()='literal' or
                           local-name()='methodsynopsis')]">
              <xsl:value-of 
                select="tokenize($langs/language[@iso=current()/@xml:lang]/@babel,
                        ' ')[1]"/>
              <xsl:text>,</xsl:text>
            </xsl:for-each-group>
            <xsl:value-of 
              select="tokenize($langs/language[@iso=$baselang]/@babel,
                      ' ')[1]"/>
          </xsl:message>
        </xsl:if>
        <!-- 2. any extra package required by the documentation
                bibliography style. TODO: check prepost.xml -->
        <xsl:if test="/db:book/db:part
                      //db:bibliography[@xreflabel]">
          <xsl:text>\usepackage{</xsl:text>
          <xsl:value-of select="/db:book/db:part
                                //db:bibliography/@xreflabel"/>
          <xsl:text>}&#xa;</xsl:text>
        </xsl:if>
        <!-- 3. url needed for metadata or abstract? 
        <xsl:if test="/db:book/db:info//db:author/db:email |
                      /db:book/db:info//db:author/db:uri |
                      /db:book/db:info/db:abstract//db:ulink |
                      /db:book/db:info/db:abstract//db:uri |
                      /db:book/db:info/db:abstract//db:email">
          <xsl:text>\usepackage{url}&#xa;</xsl:text>
        </xsl:if>
        -->
        <!-- 4. load THIS package for use in the documentation? -->
        <xsl:if test="$doctype='package' and /db:book/@xlink:role">
          <xsl:message>
            <xsl:text>Adding </xsl:text>
            <xsl:value-of select="$name"/>
            <xsl:text> as specified</xsl:text>
          </xsl:message>
          <xsl:text>\usepackage</xsl:text>
          <xsl:if test="/db:book/@xlink:role!=''">
            <xsl:text>[</xsl:text>
            <xsl:value-of select="/db:book/@xlink:role"/>
            <xsl:text>]</xsl:text>
          </xsl:if>
          <xsl:text>{</xsl:text>
          <xsl:value-of select="$name"/>
          <xsl:text>}[</xsl:text>
          <!-- use the latest revision date as the distro date -->
          <xsl:for-each select="//db:info/db:revhistory/db:revision">
            <xsl:sort select="@version" order="ascending"/>
            <xsl:if test="position()=last()">
              <xsl:value-of 
                select="translate(db:date/@conformance,'-','/')"/>
            </xsl:if>
          </xsl:for-each>
          <xsl:text>]% added by specification&#xa;</xsl:text>
        </xsl:if>
        <!-- 5. Process all the requested packages last!
             optionally use segtitle? -->
          <xsl:text>%%
%% Packages added by author
%%&#xa;</xsl:text>
        <xsl:for-each 
          select="/db:book/db:info/db:cover
                  /db:constraintdef[@xml:id='docpackages']
                  /db:segmentedlist/db:seglistitem
                  [db:seg!=''][not(db:seg/@condition='off')]">
          <xsl:call-template name="packages">
            <xsl:with-param name="pkg" select="."/>
            <xsl:with-param name="dest" select="'doc'"/>
          </xsl:call-template>
        </xsl:for-each>
        <!-- additional settings or documentation (again, applies to both) -->
        <xsl:apply-templates select="/db:book/db:info/db:cover
                                     /db:constraintdef[@xml:id='docpackages']
                                     /db:cmdsynopsis[.!='']"/>
        <!-- 6. Finally add classpack.sty for bells and whistles -->
        <xsl:text>\usepackage{classpack}
%%
%% Settings for docstrip and latexdoc 
%%
\EnableCrossrefs
\CodelineIndex
\RecordChanges
\newlength{\revmarg}
\setlength{\revmarg}{1in}&#xa;</xsl:text>
        <!-- struts only used in tabular setting -->
        <xsl:if test="/db:book/db:part[@xml:id='doc']/
                      descendant::db:tgroup">
          <xsl:text>\newcommand{\vstrut}{\vrule height1.2em depth.6667ex width0pt}
\newcommand{\prestrut}{\vrule height1em width0pt}
\newcommand{\poststrut}{\vrule depth.5ex width0pt}&#xa;</xsl:text>
        </xsl:if>
        <xsl:text>\begin{document}</xsl:text>
        <xsl:value-of select="normalize-space(db:book/@annotations)"/>
        <xsl:text>&#xa;  \DocInput{</xsl:text>
        <xsl:value-of select="$name"/>
        <xsl:text>.dtx}
\end{document}
%&lt;/driver>
% \fi
%
% \CheckSum{</xsl:text>
        <xsl:value-of select="/db:book/@security"/>
        <xsl:text>}
%
% \CharacterTable
%  {Upper-case    \A\B\C\D\E\F\G\H\I\J\K\L\M\N\O\P\Q\R\S\T\U\V\W\X\Y\Z
%   Lower-case    \a\b\c\d\e\f\g\h\i\j\k\l\m\n\o\p\q\r\s\t\u\v\w\x\y\z
%   Digits        \0\1\2\3\4\5\6\7\8\9
%   Exclamation   \!     Double quote  \"     Hash (number) \#
%   Dollar        \$     Percent       \%     Ampersand     \&amp;
%   Acute accent  \'     Left paren    \(     Right paren   \)
%   Asterisk      \*     Plus          \+     Comma         \,
%   Minus         \-     Point         \.     Solidus       \/
%   Colon         \:     Semicolon     \;     Less than     \&lt;
%   Equals        \=     Greater than  \>     Question mark \?
%   Commercial at \@     Left bracket  \[     Backslash     \\
%   Right bracket \]     Circumflex    \^     Underscore    \_
%   Grave accent  \`     Left brace    \{     Vertical bar  \|
%   Right brace   \}     Tilde         \~}
% &#xa;</xsl:text>
        <xsl:for-each select="/db:book/db:info/db:revhistory/db:revision">
          <xsl:text>% \changes{v</xsl:text>
          <xsl:value-of select="@version"/>
          <xsl:text>}{</xsl:text>
          <xsl:value-of select="translate(db:date/@conformance,'-','/')"/>
          <xsl:text>}{</xsl:text>
          <xsl:value-of 
            select="normalize-space(
                    db:revdescription/db:itemizedlist/db:title)"/>
          <xsl:text>: </xsl:text>
          <xsl:choose>
            <xsl:when 
              test="count(db:revdescription/db:itemizedlist/db:listitem)=1">
              <xsl:value-of 
                select="normalize-space(
                        db:revdescription/db:itemizedlist/db:listitem)"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:for-each 
                select="db:revdescription/db:itemizedlist/db:listitem">
                <xsl:number/>
                <xsl:text>) </xsl:text>
                <xsl:value-of select="normalize-space(.)"/>
                <xsl:if test="position()!=last()">
                  <xsl:text>; </xsl:text>
                </xsl:if>
              </xsl:for-each>
            </xsl:otherwise>
          </xsl:choose>
          <xsl:text>.}&#xa;</xsl:text>
        </xsl:for-each>
        <xsl:text>%
% \GetFileInfo{</xsl:text>
        <xsl:value-of select="$name"/>
        <xsl:text>.dtx}&#xa;</xsl:text>
        <xsl:text>%
% \DoNotIndex{\@,\@@par,\@beginparpenalty,\@empty}
% \DoNotIndex{\@flushglue,\@gobble,\@input}
% \DoNotIndex{\@makefnmark,\@makeother,\@maketitle}
% \DoNotIndex{\@namedef,\@ne,\@spaces,\@tempa}
% \DoNotIndex{\@tempb,\@tempswafalse,\@tempswatrue}
% \DoNotIndex{\@thanks,\@thefnmark,\@topnum}
% \DoNotIndex{\@@,\@elt,\@forloop,\@fortmp,\@gtempa,\@totalleftmargin}
% \DoNotIndex{\",\/,\@ifundefined,\@nil,\@verbatim,\@vobeyspaces}
% \DoNotIndex{\|,\~,\ ,\active,\advance,\aftergroup,\begingroup,\bgroup}
% \DoNotIndex{\mathcal,\csname,\def,\documentstyle,\dospecials,\edef}
% \DoNotIndex{\egroup}
% \DoNotIndex{\else,\endcsname,\endgroup,\endinput,\endtrivlist}
% \DoNotIndex{\expandafter,\fi,\fnsymbol,\futurelet,\gdef,\global}
% \DoNotIndex{\hbox,\hss,\if,\if@inlabel,\if@tempswa,\if@twocolumn}
% \DoNotIndex{\ifcase}
% \DoNotIndex{\ifcat,\iffalse,\ifx,\ignorespaces,\index,\input,\item}
% \DoNotIndex{\jobname,\kern,\leavevmode,\leftskip,\let,\llap,\lower}
% \DoNotIndex{\m@ne,\next,\newpage,\nobreak,\noexpand,\nonfrenchspacing}
% \DoNotIndex{\obeylines,\or,\protect,\raggedleft,\rightskip,\rm,\sc}
% \DoNotIndex{\setbox,\setcounter,\small,\space,\string,\strut}
% \DoNotIndex{\strutbox}
% \DoNotIndex{\thefootnote,\thispagestyle,\topmargin,\trivlist,\tt}
% \DoNotIndex{\twocolumn,\typeout,\vss,\vtop,\xdef,\z@}
% \DoNotIndex{\,,\@bsphack,\@esphack,\@noligs,\@vobeyspaces,\@xverbatim}
% \DoNotIndex{\`,\catcode,\end,\escapechar,\frenchspacing,\glossary}
% \DoNotIndex{\hangindent,\hfil,\hfill,\hskip,\hspace,\ht,\it,\langle}
% \DoNotIndex{\leaders,\long,\makelabel,\marginpar,\markboth,\mathcode}
% \DoNotIndex{\mathsurround,\mbox,\newcount,\newdimen,\newskip}
% \DoNotIndex{\nopagebreak}
% \DoNotIndex{\parfillskip,\parindent,\parskip,\penalty,\raise,\rangle}
% \DoNotIndex{\section,\setlength,\TeX,\topsep,\underline,\unskip,\verb}
% \DoNotIndex{\vskip,\vspace,\widetilde,\\,\%,\@date,\@defpar}
% \DoNotIndex{\[,\{,\},\]}
% \DoNotIndex{\count@,\ifnum,\loop,\today,\uppercase,\uccode}
% \DoNotIndex{\baselineskip,\begin,\tw@}
% \DoNotIndex{\a,\b,\c,\d,\e,\f,\g,\h,\i,\j,\k,\l,\m,\n,\o,\p,\q}
% \DoNotIndex{\r,\s,\t,\u,\v,\w,\x,\y,\z,\A,\B,\C,\D,\E,\F,\G,\H}
% \DoNotIndex{\I,\J,\K,\L,\M,\N,\O,\P,\Q,\R,\S,\T,\U,\V,\W,\X,\Y,\Z}
% \DoNotIndex{\1,\2,\3,\4,\5,\6,\7,\8,\9,\0}
% \DoNotIndex{\!,\#,\$,\&amp;,\',\(,\),\+,\.,\:,\;,\&lt;,\=,\>,\?,\_}
% \DoNotIndex{\discretionary,\immediate,\makeatletter,\makeatother}
% \DoNotIndex{\meaning,\newenvironment,\par,\relax,\renewenvironment}
% \DoNotIndex{\repeat,\scriptsize,\selectfont,\the,\undefined}
% \DoNotIndex{\arabic,\do,\makeindex,\null,\number,\show,\write,\@ehc}
% \DoNotIndex{\@author,\@ehc,\@ifstar,\@sanitize,\@title,\everypar}
% \DoNotIndex{\if@minipage,\if@restonecol,\ifeof,\ifmmode}
% \DoNotIndex{\lccode,\newtoks,\onecolumn,\openin,\p@,\SelfDocumenting}
% \DoNotIndex{\settowidth,\@resetonecoltrue,\@resetonecolfalse,\bf}
% \DoNotIndex{\clearpage,\closein,\lowercase,\@inlabelfalse}
% \DoNotIndex{\selectfont,\mathcode,\newmathalphabet,\rmdefault}
% \DoNotIndex{\bfdefault,\DeclareRobustCommand}
</xsl:text>
        <!-- add an entry for examples except those with spaces -->
        <xsl:for-each-group select="//db:command
                              [not(@role)]
                              [not(contains(.,' ') or contains(.,'{'))]" 
                            group-by="normalize-space(.)">
          <xsl:text>% \DoNotIndex{\</xsl:text>
          <xsl:value-of select="current-grouping-key()"/>
          <xsl:text>}&#xa;</xsl:text>
        </xsl:for-each-group>
        <xsl:for-each 
          select="/db:book/db:info/db:cover/db:constraintdef[@xml:id='startdoc']
                  /db:procedure/db:step[normalize-space(.)!='']
                  /db:cmdsynopsis/db:command">
          <xsl:if test="contains(.,'@')">
            <xsl:text>% \makeatletter&#xa;</xsl:text>
          </xsl:if>
          <xsl:text>% </xsl:text>
          <xsl:value-of select="normalize-space(.)"/>
          <xsl:text>&#xa;</xsl:text>
          <xsl:if test="contains(.,'@')">
            <xsl:text>% \makeatother&#xa;</xsl:text>
          </xsl:if>
        </xsl:for-each>
        <xsl:text>%&#xa;</xsl:text>
        <!-- now the fun starts -->
        <xsl:apply-templates 
          select="db:book/db:info | 
                  db:book/db:part[@xml:id='doc'] |
                  db:book/db:part[@xml:id='code'] |
                  db:book/db:part[@xml:id='files']"/>
        <xsl:text>&#xa;</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="db:info/db:abstract">
    <xsl:if test="db:title">
      <xsl:text>% \renewcommand{\abstractname}{</xsl:text>
      <xsl:apply-templates select="db:title/node()"/>
      <xsl:text>}\thispagestyle{empty}&#xa;</xsl:text>
    </xsl:if>
    <xsl:text>% \begin{abstract}&#xa;</xsl:text>
    <!-- fix broken abstract when parskip is used 
         parskip is a default, so only do this when 
         it has been manually disabled -->
    <xsl:if test="not(//db:constraintdef[@xml:id='docpackages']//
                  db:seglistitem/db:seg[.='parskip'][@condition='off'])">
      <xsl:text>% \parskip=0.5\baselineskip
% \advance\parskip by 0pt plus 2pt
% \parindent=0pt</xsl:text>
    </xsl:if>
    <xsl:text>% \noindent&#xa;</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>% \end{abstract}
% \clearpage
% \tableofcontents&#xa;</xsl:text>
  </xsl:template>

  <xsl:template name="readme">
    <xsl:variable name="file">
      <xsl:text>README</xsl:text>
    </xsl:variable>
    <xsl:result-document format="textFormat" href="{$file}">
      <xsl:apply-templates select="$readme/*" mode="readme"/>
    </xsl:result-document>
  </xsl:template>

  <xsl:template name="manifest">
    <xsl:variable name="file">
      <xsl:text>MANIFEST</xsl:text>
    </xsl:variable>
    <xsl:result-document format="textFormat" href="{$file}">
      <!-- these two files are always there -->
      <xsl:text>README
MANIFEST
</xsl:text>
      <!-- most of the rest: the .dtx and .ins files, the .pdf 
           documentation, and any ancillary files -->
      <xsl:value-of select="$name"/>
      <xsl:text>.dtx&#xa;</xsl:text>
      <xsl:value-of select="$name"/>
      <xsl:text>.ins&#xa;</xsl:text>
      <xsl:value-of select="$name"/>
      <xsl:text>.pdf&#xa;</xsl:text>
      <xsl:value-of select="$name"/>
      <xsl:text>.</xsl:text>
      <xsl:value-of select="$filetype"/>
      <xsl:text>&#xa;</xsl:text>
      <!-- add any extra files extracted from the .dtx file -->
      <xsl:for-each select="/db:book/db:part[@xml:id='code']
                            /db:appendix[@xml:id and @xlink:href]
                            |
                            /db:book/db:part[@xml:id='files']
                            /db:chapter/db:programlisting">
        <xsl:value-of select="@xlink:href"/>
        <xsl:text>&#xa;</xsl:text>
      </xsl:for-each>
      <!-- add any extra files listed in the .xml file -->
      <xsl:for-each select="/db:book/db:info/db:cover
                            /db:constraintdef[@xml:id='manifest']
                            /db:simplelist/db:member[.!='']">
        <xsl:value-of select="normalize-space(.)"/>
        <xsl:text>&#xa;</xsl:text>
        <!-- add any secondary files generated -->
        <!-- TODO -->
      </xsl:for-each>
    </xsl:result-document>
  </xsl:template>

  <!-- seglistitems containing the packages needed are passed here -->

  <xsl:template name="packages">
    <!-- packages are given as seglistitems -->
    <xsl:param name="pkg"/>
    <!-- documentation (dest=doc) or class/package (dest=cls/pkg) -->
    <xsl:param name="dest"/>
    <!-- know whether this is operating in deferred mode or not -->
    <xsl:param name="mode">
      <xsl:text></xsl:text>
    </xsl:param>
    <!--[DEFERRED] start the package documentation block-->
    <xsl:if test="$mode='deferred'">
      <xsl:text>% \begin{package}{</xsl:text>
      <xsl:value-of select="$pkg/db:seg"/>
      <xsl:text>}&#xa;</xsl:text>
      <!-- doc for cls/sty output to .dtx -->
      <xsl:apply-templates
        select="$prepost/db:procedure[@xml:id='prepackage']
                /db:step[contains(@condition,$dest)]
                [@remap=$pkg/db:seg]/db:para"/>
      <xsl:if 
        test="count($prepost/db:procedure[@xml:id='prepackage']
              /db:step[contains(@condition,$dest)]
              [@remap=$pkg/db:seg]/db:para)=0">
        <xsl:message>
          <xsl:text>ADVISORY: Package </xsl:text>
          <xsl:value-of select="$pkg/db:seg"/>
          <xsl:text> for </xsl:text>
          <xsl:value-of select="$filetype"/>
          <xsl:text> has no documentation in prepost.xml</xsl:text>
        </xsl:message>
      </xsl:if>
      <!-- additional per-sty/cls documentation from the 
           maintained document (or if generated by autopackage) -->
      <xsl:if test="@role">
        <xsl:text>% </xsl:text>
        <xsl:value-of select="normalize-space(@role)"/>
        <xsl:text>&#xa;</xsl:text>        
      </xsl:if>
      <!-- repeat for embedded comment doc -->
      <xsl:if test="count($prepost/db:procedure[@xml:id='prepackage']
              /db:step[contains(@condition,$dest)]
              [@remap=$pkg/db:seg]/db:para)>0">
        <xsl:text>% \iffalse&#xa;%% &#xa;</xsl:text>
        <xsl:apply-templates 
          select="$prepost/db:procedure[@xml:id='prepackage']
                  /db:step[contains(@condition,$dest)]
                  [@remap=$pkg/db:seg]/db:para" mode="readme"/>
        <xsl:text>% \fi&#xa;</xsl:text>
      </xsl:if>
      <xsl:text>%    \begin{macrocode}&#xa;</xsl:text>
    </xsl:if>
    <!-- check if any special preprocessing is needed 
         for documentation packages out of prepost.xml 
         in the constraintdef element type -->
    <xsl:for-each 
      select="$prepost/db:procedure[@xml:id='prepackage']
              /db:step[contains(@condition,$dest)]
              [@remap=$pkg/db:seg]
              /db:constraintdef/db:cmdsynopsis/db:command">
      <!-- checks for escaping internals only needed in doc mode -->
      <xsl:if test="contains(.,'@') and $mode=''">
        <xsl:text>\makeatletter&#xa;</xsl:text>
      </xsl:if>
      <!-- output any predefined commands -->
      <xsl:value-of select="normalize-space(.)"/>
      <xsl:text>&#xa;</xsl:text>
      <!-- [DEFERRED] add any comment from seg here 
           non-deferred comments get output *as* comments later 
           <xsl:if test="$pkg/db:seg/@role">
        <xsl:text> (</xsl:text>
        <xsl:value-of select="normalize-space($pkg/db:seg/@role)"/>
        <xsl:text>)</xsl:text>
      </xsl:if>
      -->
      <!-- checks for escaping internals only needed in doc mode -->
      <xsl:if test="contains(.,'@') and $mode=''">
        <xsl:text>\makeatother&#xa;</xsl:text>
      </xsl:if>
    </xsl:for-each>
    <!-- decide on \usepackage (doc) or \RequirePackage (cls/sty) -->
    <xsl:choose>
      <!-- [DEFERRED] just needs RequirePackage -->
      <xsl:when test="$mode='deferred'">
        <xsl:text>\RequirePackage</xsl:text>
      </xsl:when>
      <!-- stypackages or clspackages in non-deferred mode
           need armour and RequirePackage -->
      <xsl:when test="$dest=$filetype">
        <xsl:text>%&lt;</xsl:text>
        <xsl:value-of select="$doctype"/>
        <xsl:text>>\RequirePackage</xsl:text>
      </xsl:when>
      <!-- otherwise it's plain \usepackage (for documentation) -->
      <xsl:otherwise>
        <xsl:text>\usepackage</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
    <!-- output package options in either case -->
    <xsl:if test="$pkg/db:seg/@role 
                  or
                  $prepost/db:procedure[@xml:id='prepackage']/
                  db:step[contains(@condition,$dest)]
                         [@remap=$pkg/db:seg]/@role">
      <xsl:choose>
        <!-- omit if role="" was specified -->
        <xsl:when test="$pkg/db:seg/@role and $pkg/db:seg/@role=''">
          <xsl:text></xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>[</xsl:text>
          <!-- try to deduplicate -->
          <xsl:variable name="reqs">
            <xsl:value-of select="$pkg/db:seg/@role"/>
            <xsl:text>,</xsl:text>
            <xsl:value-of select="$prepost/db:procedure[@xml:id='prepackage']/
                                  db:step[contains(@condition,$dest)]
                                  [@remap=$pkg/db:seg]/@role"/>
          </xsl:variable>
          <xsl:variable name="args">
            <xsl:for-each select="tokenize(normalize-space($reqs),',')">
              <arg>
                <xsl:value-of select="normalize-space(.)"/>
              </arg>
            </xsl:for-each>
          </xsl:variable>
          <xsl:call-template name="rewrap">
            <xsl:with-param name="text">
              <xsl:for-each 
                select="$args/arg[.!=''][not(preceding-sibling::arg=.)]">
                <xsl:if test="position()>1">
                  <xsl:text>,</xsl:text>
                </xsl:if>
                <xsl:value-of select="."/>
              </xsl:for-each>
            </xsl:with-param>
          </xsl:call-template>
          <xsl:text>]</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
    <!-- then the package name -->
    <xsl:text>{</xsl:text>
    <xsl:value-of select="$pkg/db:seg"/>
    <xsl:text>}</xsl:text>
    <!-- and the version check, if any -->
    <xsl:if test="$pkg/db:seg/@version">
      <xsl:text>[</xsl:text>
      <xsl:value-of 
        select="translate(substring($pkg/db:seg/@version,1,10),'-','/')"/>
      <xsl:text>]</xsl:text>
    </xsl:if>
    <!-- only append comment in non-deferred mode 
         [DEFERRED] ones were added earlier as text -->
    <xsl:if test="$pkg/@role and $mode=''">
      <xsl:text>% </xsl:text>
      <xsl:value-of select="normalize-space($pkg/@role)"/>
    </xsl:if>
    <xsl:text>&#xa;</xsl:text>
    <!-- check if any corresponding postprocessing is needed -->
    <xsl:for-each
      select="$prepost/db:procedure[@xml:id='postpackage']
              /db:step[contains(@condition,$dest)]
                [@remap=$pkg/db:seg]
              /db:constraintdef/db:cmdsynopsis/db:command">
      <xsl:if test="contains(.,'@') and $mode=''">
        <xsl:text>\makeatletter&#xa;</xsl:text>
      </xsl:if>
      <xsl:value-of select="normalize-space(.)"/>
      <xsl:text>&#xa;</xsl:text>
      <xsl:if test="contains(.,'@') and $mode=''">
        <xsl:text>\makeatother&#xa;</xsl:text>
      </xsl:if>
    </xsl:for-each>
    <!-- [DEFERRED] terminate the code and output any postpackage
         documentation -->
    <xsl:if test="$mode='deferred'">
      <xsl:text>%    \end{macrocode}&#xa;</xsl:text>
      <xsl:apply-templates
        select="$prepost/db:procedure[@xml:id='postpackage']
                /db:step[contains(@condition,$dest)]
                [@remap=current()/db:seg]/para"/>
      <xsl:text>%  \end{package}&#xa;</xsl:text>
    </xsl:if>
    <!-- now see if the package we are documenting needs itself
         loading for the documentation (eg for examples) 
         (only applies in non-deferred mode) -->
    <xsl:if test="$mode='' and
                  $dest='doc' and $doctype='package' and /db:book/@role">
      <xsl:text>% \usepackage</xsl:text>
      <xsl:if test="/db:book/@role!=''">
        <xsl:text>[</xsl:text>
        <xsl:value-of select="/db:book/@role"/>
        <xsl:text>]</xsl:text>
      </xsl:if>
      <xsl:text>{</xsl:text>
      <xsl:value-of select="$name"/>
      <xsl:text>}% added by specification&#xa;</xsl:text>
    </xsl:if>
  </xsl:template>

  <!-- rewrap designed for long options list in
       \RequirePackage -->

  <xsl:template name="rewrap">
    <!-- text is a comma-separated vector or arguments -->
    <xsl:param name="text"/>
    <!-- maxlen is the max line length to output -->
    <xsl:param name="maxlen">
      <xsl:text>32</xsl:text>
      <!-- maxlen becomes 50 after the first line -->
    </xsl:param>
    <xsl:choose>
      <!-- if text is an overlong string but contains a comma -->
      <xsl:when test="string-length($text)>$maxlen and
                      contains($text,',')">
        <!-- see if there is a comma within the first $maxlen chars -->
        <xsl:variable name="prelastcomma">
          <xsl:choose>
            <xsl:when test="contains(substring($text,1,$maxlen),',')">
              <xsl:analyze-string select="substring($text,1,$maxlen)"
                regex="^(.*)(,)([^,]*)$">
                <xsl:matching-substring>
                  <xsl:value-of select="concat(regex-group(1),',')"/>
                </xsl:matching-substring>
                <xsl:non-matching-substring>
                  <xsl:text>ERROR FINDING COMMA IN SUBSTRING</xsl:text>
                </xsl:non-matching-substring>
              </xsl:analyze-string>
            </xsl:when>
            <!-- No comma in range, test whole string -->
            <xsl:otherwise>
              <xsl:analyze-string select="$text"
                regex="^(.*)(,)([^,]*)$">
                <xsl:matching-substring>
                  <xsl:value-of select="concat(regex-group(1),',')"/>
                </xsl:matching-substring>
                <xsl:non-matching-substring>
                  <xsl:text>ERROR FINDING COMMA IN WHOLE STRING</xsl:text>
                </xsl:non-matching-substring>
              </xsl:analyze-string>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:value-of select="$prelastcomma"/>
        <xsl:choose>
          <!-- seems not to be needed -->
          <xsl:when test="ancestor::db:constraintdef
                      [@xml:id=concat($filetype,'packages')]">
            <!--
            <xsl:text>&#xa;%&lt;</xsl:text>
            <xsl:value-of select="$doctype"/>
            <xsl:text>>  </xsl:text>
            -->
            <xsl:text>&#xa;  </xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>&#xa;  </xsl:text>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:call-template name="rewrap">
          <xsl:with-param name="text" 
            select="normalize-space(substring-after($text,$prelastcomma))"/>
          <xsl:with-param name="maxlen">
            <xsl:text>50</xsl:text>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$text"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <!-- cmdsynopses contain special defs for documentation -->

  <xsl:template match="db:cmdsynopsis">
    <xsl:if test="position()=1 and ../db:cmdsynopsis[contains(.,'@')]">
      <xsl:text>\makeatletter&#xa;</xsl:text>
    </xsl:if>
    <xsl:choose>
      <!-- new \write files: new: no arg -->
      <xsl:when test="db:command/@remap='newwrite'">
        <xsl:text>\newwrite\</xsl:text>
        <xsl:value-of select="db:command"/>
        <xsl:text>&#xa;</xsl:text>
      </xsl:when>
      <!-- new counters -->
      <xsl:when test="db:command/@remap='counter'">
        <xsl:text>\newcounter{</xsl:text>
        <xsl:value-of select="db:command"/>
        <xsl:text>}</xsl:text>
        <xsl:if test="db:arg">
          <xsl:text>\setcounter{</xsl:text>
          <xsl:value-of select="db:command"/>
          <xsl:text>}{</xsl:text>
          <xsl:value-of select="db:arg"/>
          <xsl:text>}</xsl:text>
        </xsl:if>
        <xsl:text>&#xa;</xsl:text>
      </xsl:when>
      <!-- new lengths -->
      <xsl:when test="db:command/@remap='length'">
        <xsl:text>\newlength{\</xsl:text>
        <xsl:value-of select="db:command"/>
        <xsl:text>}</xsl:text>
        <xsl:if test="db:arg">
          <xsl:text>\setlength{\</xsl:text>
          <xsl:value-of select="db:command"/>
          <xsl:text>}{</xsl:text>
          <xsl:value-of select="db:arg"/>
          <xsl:text>}</xsl:text>
        </xsl:if>
        <xsl:text>&#xa;</xsl:text>
      </xsl:when>
      <!-- plain TeX commands -->
      <xsl:when test="@xml:lang='TeX'">
        <xsl:if test="@role='long'">
          <xsl:text>\long</xsl:text>
        </xsl:if>
        <xsl:text>\def\</xsl:text>
        <xsl:value-of select="db:command"/>
        <xsl:if test="db:arg/@wordsize">
          <xsl:call-template name="repeatarg">
            <xsl:with-param name="limit" select="db:arg/@wordsize"/>
            <xsl:with-param name="prefix" 
              select="substring(db:arg/@annotations,1,
                      (string-length(db:arg/@annotations) div 2))"/>
            <xsl:with-param name="suffix" 
              select="substring(db:arg/@annotations,
                      (string-length(db:arg/@annotations) div 2)+1)"/>
          </xsl:call-template>
        </xsl:if>
        <xsl:choose>
          <xsl:when test="db:arg/@remap">
            <xsl:text>{</xsl:text>
            <xsl:value-of 
              select="/db:book/@*[name()=current()/db:arg/@remap]"/>
            <xsl:text>}&#xa;</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>{%&#xa;&#9;</xsl:text>
            <xsl:value-of select="db:arg"/>
            <xsl:text>}&#xa;</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:when test="db:command/@remap='environment'
                      and count(db:command/db:arg)=2">
        <xsl:choose>
          <xsl:when test="db:command/@role='renew'">
            <xsl:text>\renewenvironment{</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>\newenvironment{</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:value-of select="db:command"/>
        <xsl:text>}</xsl:text>
        <!-- number of arguments, if any -->
        <xsl:if test="db:arg[1]/@wordsize">
          <xsl:text>[</xsl:text>
          <xsl:value-of select="db:arg[1]/@wordsize"/>
          <xsl:text>]</xsl:text>
        </xsl:if>
        <xsl:text>{%&#xa;&#9;</xsl:text>
        <xsl:value-of select="db:arg[1]"/>
        <xsl:text>}&#xa;</xsl:text>
        <xsl:text>{%&#xa;&#9;</xsl:text>
        <xsl:value-of select="db:arg[2]"/>
        <xsl:text>}&#xa;</xsl:text>
      </xsl:when>
      <!-- LaTeX commands -->
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="db:command/@role='renew'">
            <xsl:text>\renewcommand{\</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>\newcommand{\</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:value-of select="db:command"/>
        <xsl:text>}</xsl:text>
        <!-- number of arguments, if any -->
        <xsl:if test="db:arg/@wordsize">
          <xsl:text>[</xsl:text>
          <xsl:value-of select="db:arg/@wordsize"/>
          <xsl:text>]</xsl:text>
          <xsl:if test="db:arg/@condition">
          <xsl:text>[</xsl:text>
          <xsl:value-of select="db:arg/@condition"/>
          <xsl:text>]</xsl:text>            
          </xsl:if>
        </xsl:if>
        <xsl:choose>
          <!-- remap is a reference to an attribute of the root
               element, eg arch means use @arch -->
          <xsl:when test="db:arg/@remap">
            <xsl:text>{</xsl:text>
            <xsl:value-of 
              select="/db:book/@*[name()=current()/db:arg/@remap]"/>
            <xsl:text>}&#xa;</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>{%&#xa;&#9;</xsl:text>
            <xsl:value-of select="db:arg"/>
            <xsl:text>}&#xa;</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:if test="position()=last() and ../db:cmdsynopsis[contains(.,'@')]">
      <xsl:text>\makeatother&#xa;</xsl:text>
    </xsl:if>
  </xsl:template>

  <!-- for info, we omit the cover settings (done earlier)-->

  <xsl:template match="db:info">
    <xsl:message>
      <!--
      <xsl:text> on </xsl:text>
      <xsl:value-of select="$host"/>
      -->
      <xsl:text>Creating </xsl:text>
      <xsl:value-of select="$doctype"/>
      <xsl:text> '</xsl:text>
      <xsl:value-of select="$name"/>
      <xsl:text>' (v</xsl:text>
      <xsl:value-of select="$version"/>
      <xsl:text>.</xsl:text>
      <xsl:value-of select="$revision"/>
      <xsl:text>) with checksum </xsl:text>
      <xsl:value-of select="/db:book/@security"/>
      <xsl:text>.</xsl:text>
    </xsl:message>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="db:cover"/>

  <xsl:template match="db:info/db:title">
    <!-- if this is a class, or a package which has not been 
         loaded in the documentation, ensure the \fileversion
         and \filedate values are made available -->
    <xsl:if test="/db:book/@arch='package' or
                  not(/db:book/@xlink:role)">
      <xsl:text>% \def\fileversion{</xsl:text>
      <xsl:value-of select="/db:book/@version"/>
      <xsl:text>.</xsl:text>
      <xsl:value-of select="/db:book/@revision"/>
      <xsl:text>}&#xa;% \def\filedate{</xsl:text>
      <xsl:for-each select="//db:info/db:revhistory/db:revision">
        <xsl:sort select="@version" order="ascending"/>
        <xsl:if test="position()=last()">
          <xsl:value-of 
            select="translate(db:date/@conformance,'-','/')"/>
        </xsl:if>
      </xsl:for-each>
      <xsl:text>}&#xa;</xsl:text>
    </xsl:if>
    <xsl:text>% \title{The </xsl:text>
    <xsl:text> \textsf{</xsl:text>
    <xsl:value-of select="$name"/>
    <xsl:text>} \LaTeXe\ </xsl:text>
    <xsl:choose>
      <xsl:when test="$doctype='class'">
        <xsl:text>document class</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$doctype"/>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:text>\thanks{%&#xa;% This document corresponds to \textsf{</xsl:text>
    <xsl:value-of select="$name"/>
    <xsl:text>}&#xa;% \textit{v.}\ \fileversion, dated \filedate.}</xsl:text>
    <xsl:if test="ancestor::db:info/descendant::db:author/
                  db:contrib[@role='sponsor']">
      <xsl:text>\enspace\thanks{%&#xa;% Development has been supported by </xsl:text>
      <xsl:for-each 
        select="ancestor::db:info/descendant::db:author/
                db:contrib[@role='sponsor']">
        <xsl:if test="position()>1">
          <xsl:text>, </xsl:text>
          <xsl:if test="position()=last()">
            <xsl:text>and </xsl:text>
          </xsl:if>
        </xsl:if>
        <xsl:apply-templates/>
      </xsl:for-each>
      <xsl:text>.}</xsl:text>
    </xsl:if>
    <xsl:text>&#xa;% \\[1em]\Large &#xa;% </xsl:text>
    <xsl:apply-templates/>
    <xsl:if test="following-sibling::db:subtitle[not(@role='labelonly')]">
      <xsl:text>&#xa;% \\[1ex]\large &#xa;% </xsl:text>
      <xsl:apply-templates select="following-sibling::db:subtitle/node()"/>
    </xsl:if>
    <xsl:text>}&#xa;</xsl:text>
  </xsl:template>

  <xsl:template match="db:info/db:subtitle"/>

  <xsl:template match="db:info//db:author">
    <xsl:if test="count(preceding-sibling::db:author)=0">
      <xsl:text>% \author{</xsl:text>
    </xsl:if>
    <xsl:for-each select="db:personname/db:*">
      <xsl:apply-templates/>
      <xsl:if test="position()!=last()">
        <xsl:text> </xsl:text>
      </xsl:if>
    </xsl:for-each>
    <xsl:apply-templates select="db:honorific | db:affiliation"/>
    <xsl:if test="db:email">
      <xsl:text>\\\normalsize(\url{</xsl:text>
      <xsl:value-of select="db:email"/>
      <xsl:text>})</xsl:text>
    </xsl:if>
    <xsl:choose>
      <xsl:when test="following-sibling::db:author">
        <xsl:text>&#xa;% \and&#xa;% </xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>}&#xa;% \maketitle&#xa;</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="db:honorific">
    <xsl:text> \textsc{</xsl:text>
    <xsl:value-of select="translate(.,
                          'ABCDEFGHIJKLMN0PQRSTUVWXYZ',
                          'abcdefghijklmn0pqrstuvwxyz')"/>
    <xsl:text>}</xsl:text>
  </xsl:template>

  <xsl:template match="db:affiliation">
    <xsl:text>\\\normalsize </xsl:text>
    <xsl:for-each select="db:*">
      <xsl:value-of select="normalize-space(.)"/>
      <!-- encapitalisation for Centre, Hospital, Unit, and Project -->
      <xsl:if test="@remap">
        <xsl:text> </xsl:text>
        <xsl:value-of 
          select="translate(substring(@remap,1,1),'cuhp','CUHP')"/>
        <xsl:value-of select="substring(@remap,2)"/>
      </xsl:if>
      <xsl:if test="position()!=last()">
        <xsl:text>\\[-.25ex]\normalsize </xsl:text>
      </xsl:if>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="db:info/db:releaseinfo | 
                       db:info/db:annotation |
                       db:info/db:revhistory |
                       db:info/db:copyright"/>

  <!-- normal text -->
    
  <xsl:template match="db:para">
    <!-- include percent-space for the fake steps in prepost.xml -->
    <xsl:choose>
      <xsl:when test="ancestor::db:procedure[@xml:id='prepackage' or 
                                             @xml:id='postpackage']">
        <xsl:text>% </xsl:text>
      </xsl:when>
      <!-- omit for the first para in a list item -->
      <xsl:when test="(parent::db:listitem or parent::db:step)
                       and count(preceding-sibling::db:para)=0">
        <xsl:text></xsl:text>
      </xsl:when>
      <!-- omit for the first para in a table cell -->
      <xsl:when test="parent::db:entry and position()=1">
        <xsl:text></xsl:text>
      </xsl:when>
      <!-- otherwise include -->
      <xsl:otherwise>
        <xsl:text>% </xsl:text>
      </xsl:otherwise>
    </xsl:choose>
    <!-- label it if necessary -->
    <xsl:if test="@xml:id">
      <xsl:text>\label{</xsl:text>
      <xsl:value-of select="@xml:id"/>
      <xsl:text>}</xsl:text>
    </xsl:if>
    <!-- remap allows the bodging of (eg) font controls
         to apply just to this paragraph -->
    <xsl:if test="@remap">
      <xsl:text>{</xsl:text>
      <xsl:value-of select="@remap"/>
    </xsl:if>
    <!-- do it -->
    <xsl:apply-templates/>
    <!-- if this is in a list item, note, footnote, or blockquote
         AND there are no more paragraphs to come,
         THEN DO NOT OUTPUT ANYTHING because the container will
         handle the closing syntax -->
    <xsl:choose>
      <!-- no \par after sole or last para, just a CR -->
      <xsl:when test="(parent::db:listitem or 
                       parent::db:note or
                       parent::db:footnote or
                       parent::db:blockquote) and 
                      not(following-sibling::db:para)">
        <xsl:text></xsl:text>
      </xsl:when>
      <!-- OR, if this is the last or sole paragraph in an
           auto-included documentation chunk in prepost.xml,
           omit the \par -->
      <xsl:when 
        test="(parent::db:step/parent::db:procedure[@xml:id='prepackage'] or
               parent::db:step/parent::db:procedure[@xml:id='postpackage'])
              and not(following-sibling::db:para)">
        <xsl:text></xsl:text>
      </xsl:when>
      <!-- otherwise it's the end of a paragraph, which we
           make explicit, rather than rely on newlines -->
      <xsl:otherwise>
        <xsl:text>\par</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
    <!-- add punctuation if the sole or last in a list item, 
         only when needed,
         ie if this para does NOT end with its own punctuation 
         and is not IMMEDIATELY followed by punctuation -->
    <xsl:if test="parent::db:listitem 
                  and
                  not(contains(',.;:!?',substring(normalize-space(.),
                      string-length(normalize-space(.))))) 
                  and
                  not(contains(',.;:!?',substring(normalize-space((
                      ancestor::db:itemizedlist[1] | 
                      ancestor::db:orderedlist[1] |
                      ancestor::db:variablelist[1])[1]/
                      following-sibling::node()[1]),1,1)))">
      <!-- only add punct to last para in item -->
      <xsl:if test="not(following-sibling::db:para)">
        <xsl:choose>
          <!-- add semicolon to all but last -->
          <xsl:when test="parent::db:listitem/following-sibling::db:listitem">
            <xsl:text>;</xsl:text>
          </xsl:when>
          <!-- add fullpoint to last except inline -->
          <xsl:otherwise>
            <xsl:text>.</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:if>
    </xsl:if>
    <!-- terminate any font bodges -->
    <xsl:if test="@remap">
      <xsl:text>}</xsl:text>
    </xsl:if>
    <!-- in the case of notes, footnotes, and cell content 
         we don't even want a newline -->
    <xsl:if test="not(parent::db:note or 
                      parent::db:footnote or 
                      parent::db:entry)">
      <xsl:text>&#xa;</xsl:text>
      <!-- but we need a space after \par in the case of cell content -->
      <xsl:if test="parent::db:entry">
        <xsl:text> </xsl:text>
      </xsl:if>
    </xsl:if>
    <!-- inline documentation echo, except for footnotes, which
         get done inline in db2plaintext.xsl -->
    <xsl:if test="ancestor::db:part[@xml:id='code'] and
                  not(parent::db:footnote)">
      <xsl:text>% \iffalse&#xa;%% &#xa;</xsl:text>
      <xsl:apply-templates select="." mode="readme"/>
      <xsl:text>% \fi&#xa;</xsl:text>
    </xsl:if>
  </xsl:template>

  <xsl:template match="db:literal[not(@xml:lang='LaTeX')]">
    <xsl:call-template name="avoidverb"/>
  </xsl:template>

  <xsl:template match="db:literal[@xml:lang='LaTeX']">
    <xsl:value-of select="."/>
  </xsl:template>

  <xsl:template match="db:preface">
    <xsl:choose>
      <!-- formal prefaces get a title and a ToC entry -->
      <xsl:when test="db:title">
        <xsl:text>% \clearpage\section*{</xsl:text>
        <xsl:apply-templates select="db:title/node()"/>
        <xsl:text>}\addcontentsline{toc}{subsection}{</xsl:text>
        <xsl:apply-templates select="db:title/node()"/>
        <xsl:text>}</xsl:text>
      </xsl:when>
      <!-- untitled ones don't -->
      <xsl:otherwise>
        <xsl:text>% \clearpage\null\vfill\begingroup\centering</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
    <!-- and a label if they have an ID -->
    <xsl:if test="@xml:id">
      <xsl:text>\label{</xsl:text>
      <xsl:value-of select="@xml:id"/>
      <xsl:text>}</xsl:text>
    </xsl:if>
    <xsl:text>&#xa;</xsl:text>
    <xsl:apply-templates/>
    <!-- terminate the centering group for untitled prefaces -->
    <xsl:if test="not(db:title)">
      <xsl:text>% \par\endgroup\vfill&#xa;</xsl:text>
    </xsl:if>
  </xsl:template>

  <xsl:template match="db:info/db:abstract/db:title | 
                       db:preface/db:title |
                       db:preface/db:section/db:title |
                       db:chapter/db:title | db:chapter/db:subtitle |
                       db:chapter/db:sect1/db:title |
                       db:chapter//db:sect2/db:title |
                       db:chapter//db:sect3/db:title |
                       db:chapter//db:sect4/db:title |
                       db:appendix/db:title |
                       db:appendix/db:sect1/db:title |
                       db:appendix//db:sect2/db:title |
                       db:appendix//db:sect3/db:title |
                       db:appendix//db:sect4/db:title |
                       db:bibliography/db:title"/>

  <xsl:template match="db:part">
    <!-- there are three possible parts: doc, code, and files -->
    <xsl:choose>
      <!-- documentation -->
      <xsl:when test="@xml:id='doc'">
        <!-- iterate through commands and environment variables 
             to be referenced, in order of length, longest first -->
        <xsl:for-each-group group-by="normalize-space(.)"
          select="descendant::db:command
                  [@role and not(@xml:lang or 
                   contains(.,'[') or contains(.,'{'))]
                  | 
                  descendant::db:envar
                  [@role and not(@xml:lang or 
                   contains(.,'[') or contains(.,'{'))]
                  |
                  descendant::db:tag[@role]
                  |
                  descendant::db:varname[@role]
                  |
                  descendant::db:classname[@role]
                  |
                  descendant::db:package[@role]
                  |
                  descendant::db:annotation/@xreflabel">
          <!-- varname? -->
          <xsl:sort select="string-length(current-grouping-key())" 
            data-type="number" order="descending"/>
          <!-- only use the first one -->
          <xsl:if test="position()=1">
            <xsl:text>% \addtolength{\revmarg}{\widthof{\LabelFont{</xsl:text>
            <xsl:value-of select="current-grouping-key()"/>
            <xsl:text>}}}
% \newgeometry{left=\revmarg}&#xa;</xsl:text>
          </xsl:if>
        </xsl:for-each-group>
        <xsl:apply-templates/>
      </xsl:when>
      <!-- for the code part, start by terminating the userdoc -->
      <xsl:when test="@xml:id='code'">
        <xsl:text>% \StopEventually{\label{endcode}
%   \clearpage
%   \newgeometry{left=3cm}
%   \addcontentsline{toc}{section}{Change History}
%   \label{</xsl:text>
        <xsl:value-of select="/db:book/db:info/db:revhistory/@xml:id"/>
        <xsl:text>}
%   \PrintChanges
%   \clearpage
%   \label{codeindex}
%   \addcontentsline{toc}{section}{Index}
%   \PrintIndex}&#xa;</xsl:text>
        <!-- iterate through commands and environment variables 
             to be referenced, in order of length, longest first -->
        <xsl:for-each-group group-by="normalize-space(.)"
          select="descendant::db:command
                  [@role and not(@xml:lang or 
                   contains(.,'[') or contains(.,'{'))]
                  | 
                  descendant::db:envar
                  [@role and not(@xml:lang or 
                   contains(.,'[') or contains(.,'{'))]
                  |
                  descendant::db:tag[@role]
                  |
                  descendant::db:varname[@role]
                  |
                  descendant::db:classname[@role]
                  |
                  descendant::db:package[@role]
                  |
                  descendant::db:annotation/@xreflabel">
          <!-- varname? -->
          <xsl:sort select="string-length(current-grouping-key())" 
            data-type="number" order="descending"/>
          <!-- only use the first one -->
          <xsl:if test="position()=1">
            <xsl:text>% \setlength{\revmarg}{1in}
% \addtolength{\revmarg}{\widthof{\MacroFont{</xsl:text>
            <xsl:value-of select="current-grouping-key()"/>
            <xsl:text>}}}
% \newgeometry{left=\revmarg}&#xa;</xsl:text>
          </xsl:if>
        </xsl:for-each-group>
        <!-- The code part could be a monolith (no chapters) 
             so it would all be one <package> or <class> 
             But if (usually) it has chapters, the tags for the 
             primary output need to be set round the chapters,
             and any appendices may be ancillary files -->
        <xsl:if test="count(db:chapter)=0">
          <!-- no chapters, so output start-tag now -->
          <xsl:text>% \label{</xsl:text>
          <xsl:value-of select="@xml:id"/>
          <xsl:text>}
% \iffalse
%&lt;*</xsl:text>
          <xsl:value-of select="$doctype"/>
          <xsl:text>>
% \fi&#xa;</xsl:text>
        </xsl:if>
        <xsl:apply-templates/>
        <xsl:if test="count(db:chapter)=0">
          <!-- no chapters, so output end-tag now -->
          <xsl:text>% \iffalse
%&lt;/</xsl:text>
          <xsl:value-of select="$doctype"/>
          <xsl:text>>
% \fi&#xa;</xsl:text>
        </xsl:if>
        <!-- once the code has been done, and before any
             standalone ancillary files are done,
             output the Licence as an appendix -->
        <xsl:if test="not(//db:appendix)">
          <xsl:text>% \appendix&#xa;</xsl:text>
        </xsl:if>
        <xsl:text>% \newgeometry{left=3cm}&#xa;</xsl:text>
        <xsl:apply-templates select="$licence"/>
        <!-- finally, do any delayed-output extractable files from 
             the code part (these need no accompanying text as 
             they're just re-given here for extraction) -->
        <xsl:for-each select="descendant::db:programlisting
                              [@xml:id and @xlink:show='new' and @xlink:href]">
          <xsl:text>% \iffalse&#xa;%&lt;*</xsl:text>
          <xsl:value-of select="@xml:id"/>
          <xsl:text>>&#xa;</xsl:text>
          <xsl:call-template name="lrtrim">
            <xsl:with-param name="text" select="."/>
          </xsl:call-template>
          <xsl:text>&#xa;%&lt;/</xsl:text>
          <xsl:value-of select="@xml:id"/>
          <xsl:text>>&#xa;% \fi&#xa;</xsl:text>
        </xsl:for-each>
      </xsl:when>
      <!-- Part I page is generated by first chapter in part/@xml:id='doc'-->
      <xsl:when test="@xml:id='files'">
        <!-- output files that do not require pre/postamble here -->
        <xsl:apply-templates mode="files"/>
      </xsl:when>
      <!-- what other kind of part can there be? -->
      <xsl:otherwise>
        <xsl:apply-templates/>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:if test="count(following-sibling::db:part)=0">
      <xsl:text>% \Finale&#xa;</xsl:text>
    </xsl:if>
  </xsl:template>

  <!-- TEXT -->
  
  <xsl:template match="db:acknowledgements">
    <xsl:text>% \subsection*{Acknowledgments}</xsl:text>
    <xsl:if test="@xml:id">
      <xsl:text>\label{</xsl:text>
      <xsl:value-of select="@xml:id"/>
      <xsl:text>}</xsl:text>
    </xsl:if>
    <xsl:text>&#xa;</xsl:text>
    <xsl:apply-templates/>
    <xsl:call-template name="checkpackages">
      <xsl:with-param name="pos" select="'after'"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="db:chapter[not(@condition='draft')]">
    <!-- only if it contains something -->
    <xsl:if test="normalize-space(.)!=''">
      <!-- output the start-tag if this is the first chapter -->
      <xsl:if test="parent::db:part[@xml:id='code'] and
                    count(preceding-sibling::db:chapter)=0">
        <xsl:text>% \iffalse
%&lt;*</xsl:text>
          <xsl:value-of select="$doctype"/>
          <xsl:text>>
% \fi&#xa;</xsl:text>
      </xsl:if>
      <xsl:call-template name="checkpackages">
        <xsl:with-param name="pos" select="'before'"/>
      </xsl:call-template>
      <xsl:text>% \clearpage&#xa;</xsl:text>
      <xsl:text>% \section</xsl:text>
      <xsl:if test="db:subtitle">
        <xsl:text>[</xsl:text>
        <xsl:apply-templates select="db:title/node()"/>
        <xsl:text>]</xsl:text>
      </xsl:if>
      <xsl:text>{</xsl:text>
      <xsl:apply-templates select="db:title/node()"/>
      <xsl:if test="db:subtitle">
        <xsl:text>~--- </xsl:text>
        <xsl:apply-templates select="db:subtitle/node()"/>
      </xsl:if>
      <xsl:text>}</xsl:text>
      <xsl:if test="@xml:id">
        <xsl:text>\label{</xsl:text>
        <xsl:value-of select="@xml:id"/>
        <xsl:text>}</xsl:text>
      </xsl:if>
      <xsl:text>&#xa;</xsl:text>
      <xsl:if test="ancestor::db:part[@xml:id='code']">
        <xsl:text>% \iffalse&#xa;%% &#xa;</xsl:text>
        <xsl:apply-templates select="db:title|db:subtitle" mode="readme"/>
        <xsl:text>% \fi&#xa;</xsl:text>
      </xsl:if>
      <xsl:apply-templates/>
      <xsl:call-template name="checkpackages">
        <xsl:with-param name="pos" select="'after'"/>
      </xsl:call-template>
    </xsl:if>
    <!-- output the end-tag if this is the last chapter -->
    <xsl:if test="parent::db:part[@xml:id='code'] and
                  count(following-sibling::db:chapter)=0">
      <xsl:text>% \iffalse
%&lt;/</xsl:text>
      <xsl:value-of select="$doctype"/>
      <xsl:text>>
% \fi&#xa;</xsl:text>
    </xsl:if>
  </xsl:template>

  <xsl:template match="db:appendix">
    <!-- only do appendices with content, and do not output any
         programlisting code *as* code, only as documentation -->
    <xsl:if test="normalize-space(.)!=''">
      <!-- if this is the first appendix, issue the \appendix switch -->
      <xsl:if test="count(preceding-sibling::db:appendix)=0">
        <xsl:text>% \appendix&#xa;</xsl:text>
      </xsl:if>
      <!-- if this is a documented extractable *file*, tag it -->
      <xsl:if test="parent::db:part[@xml:id='code'] 
                    and @xlink:href and @xml:id">
        <xsl:text>% \iffalse
%&lt;*</xsl:text>
        <xsl:value-of select="@xml:id"/>
        <xsl:text>>
% \fi&#xa;</xsl:text>
      </xsl:if>
      <!-- normal titling -->
      <xsl:text>% \clearpage
% \section{</xsl:text>
      <xsl:apply-templates select="db:title/node()"/>
      <xsl:text>}</xsl:text>
      <xsl:if test="@xml:id">
        <xsl:text>\label{</xsl:text>
        <xsl:value-of select="@xml:id"/>
        <xsl:text>}</xsl:text>
      </xsl:if>
      <xsl:text>&#xa;</xsl:text>
      <xsl:if test="ancestor::db:part[@xml:id='code']">
        <xsl:text>% \iffalse&#xa;%% &#xa;</xsl:text>
        <xsl:apply-templates select="db:title|db:subtitle" mode="readme"/>
        <xsl:text>% \fi&#xa;</xsl:text>
      </xsl:if>
      <!-- if this is documented extractable file, output an
           identity -->
      <xsl:if test="parent::db:part[@xml:id='code'] 
                    and @xlink:href and @xml:id">
        <xsl:variable name="ext" select="substring-after(@xlink:href,'.')"/>
        <xsl:if test="($ext='cls' or $ext='sty') 
                      and not(@conformance='nointro')">
          <xsl:text>%    \begin{macrocode}&#xa;\NeedsTeXFormat{</xsl:text>
          <xsl:value-of select="/db:book/@conformance"/>
          <xsl:text>}[</xsl:text>
          <xsl:value-of select="translate(/db:book/@condition,'-','/')"/>
          <xsl:text>]&#xa;\Provides</xsl:text>
          <xsl:choose>
            <xsl:when test="$ext='sty'">
              <xsl:text>Package</xsl:text>
            </xsl:when>
            <xsl:when test="$ext='cls'">
              <xsl:text>Class</xsl:text>
            </xsl:when>
          </xsl:choose>
          <xsl:text>{</xsl:text>
          <xsl:value-of select="substring-before(@xlink:href,'.')"/>
          <xsl:text>}[</xsl:text>
          <!-- use the latest revision date as the distro date -->
          <xsl:for-each select="/db:book/db:info/db:revhistory/db:revision">
            <xsl:sort select="@version" order="ascending"/>
            <xsl:if test="position()=last()">
              <xsl:value-of 
                select="translate(db:date/@conformance,'-','/')"/>
            </xsl:if>
          </xsl:for-each>
          <xsl:text> v</xsl:text>
          <xsl:value-of select="/db:book/@version"/>
          <xsl:text>.</xsl:text>
          <xsl:value-of select="/db:book/@revision"/>
          <xsl:text>&#xa; </xsl:text>
          <xsl:variable name="title">
            <xsl:value-of select="normalize-space(db:title)"/>
            <xsl:if test="db:subtitle">
              <xsl:text>: </xsl:text>
              <xsl:value-of select="normalize-space(db:subtitle)"/>
            </xsl:if>
          </xsl:variable>
          <xsl:choose>
            <xsl:when test="contains($title,'\LaTeXe{}')">
              <xsl:value-of select="substring-before($title,'\LaTeXe{}')"/>
              <xsl:text>LaTeX2e</xsl:text>
              <xsl:value-of select="substring-after($title,'\LaTeXe{}')"/>
            </xsl:when>
            <xsl:when test="contains($title,'\LaTeX{}')">
              <xsl:value-of select="substring-before($title,'\LaTeX{}')"/>
              <xsl:text>LaTeX</xsl:text>
              <xsl:value-of select="substring-after($title,'\LaTeX{}')"/>
            </xsl:when>
            <xsl:when test="contains($title,'\TeX{}')">
              <xsl:value-of select="substring-before($title,'\TeX{}')"/>
              <xsl:text>TeX</xsl:text>
              <xsl:value-of select="substring-after($title,'\TeX{}')"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="$title"/>
            </xsl:otherwise>
          </xsl:choose>
          <xsl:text>]&#xa;%    \end{macrocode}&#xa;</xsl:text>
        </xsl:if>
      </xsl:if>
      <xsl:apply-templates/>
      <xsl:if test="@xlink:href and @xml:id">
        <xsl:text>% \iffalse
%&lt;/</xsl:text>
        <xsl:value-of select="@xml:id"/>
        <xsl:text>>
% \fi&#xa;</xsl:text>
      </xsl:if>
    </xsl:if>
  </xsl:template>

  <xsl:template match="db:sect1">
    <xsl:if test="normalize-space(.)!=''">
      <xsl:call-template name="checkpackages">
        <xsl:with-param name="pos" select="'before'"/>
      </xsl:call-template>
      <xsl:if test="@condition='newpage'">
        <xsl:text>% \clearpage&#xa;</xsl:text>
      </xsl:if>
      <xsl:text>% \subsection{</xsl:text>
      <xsl:apply-templates select="db:title/node()"/>
      <xsl:text>}</xsl:text>
      <xsl:if test="@xml:id">
        <xsl:text>\label{</xsl:text>
        <xsl:value-of select="@xml:id"/>
        <xsl:text>}</xsl:text>
      </xsl:if>
      <xsl:text>&#xa;</xsl:text>
      <xsl:if test="ancestor::db:part[@xml:id='code']">
        <xsl:text>% \iffalse&#xa;%% &#xa;</xsl:text>
        <xsl:apply-templates select="db:title|db:subtitle" mode="readme"/>
        <xsl:text>% \fi&#xa;</xsl:text>
      </xsl:if>
      <xsl:apply-templates/>
      <xsl:call-template name="checkpackages">
        <xsl:with-param name="pos" select="'after'"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <xsl:template match="db:sect2">
    <xsl:if test="normalize-space(.)!=''">
      <xsl:call-template name="checkpackages">
        <xsl:with-param name="pos" select="'before'"/>
      </xsl:call-template>
      <xsl:text>% \subsubsection{</xsl:text>
      <xsl:apply-templates select="db:title/node()"/>
      <xsl:text>}</xsl:text>
      <xsl:if test="@xml:id">
        <xsl:text>\label{</xsl:text>
        <xsl:value-of select="@xml:id"/>
        <xsl:text>}</xsl:text>
      </xsl:if>
      <xsl:text>&#xa;</xsl:text>
      <xsl:if test="ancestor::db:part[@xml:id='code']">
        <xsl:text>% \iffalse&#xa;%% &#xa;</xsl:text>
        <xsl:apply-templates select="db:title|db:subtitle" mode="readme"/>
        <xsl:text>% \fi&#xa;</xsl:text>
      </xsl:if>
      <xsl:apply-templates/>
      <xsl:call-template name="checkpackages">
        <xsl:with-param name="pos" select="'after'"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <xsl:template match="db:sect3">
    <xsl:if test="normalize-space(.)!=''">
      <xsl:call-template name="checkpackages">
        <xsl:with-param name="pos" select="'before'"/>
      </xsl:call-template>
      <xsl:text>% \paragraph{</xsl:text>
      <xsl:apply-templates select="db:title/node()"/>
      <!--
      <xsl:if test="not(contains(':–-—',substring(normalize-space(db:title),string-length(normalize-space(db:title)))))">
        <xsl:text>&mdash;</xsl:text>
      </xsl:if>
      -->
      <xsl:text>}</xsl:text>
      <xsl:if test="@xml:id">
        <xsl:text>\label{</xsl:text>
        <xsl:value-of select="@xml:id"/>
        <xsl:text>}</xsl:text>
      </xsl:if>
      <xsl:text>&#xa;</xsl:text>
      <xsl:apply-templates/>
      <xsl:call-template name="checkpackages">
        <xsl:with-param name="pos" select="'after'"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <xsl:template match="db:sect4">
    <xsl:if test="normalize-space(.)!=''">
      <xsl:call-template name="checkpackages">
        <xsl:with-param name="pos" select="'before'"/>
      </xsl:call-template>
      <xsl:text>% \subparagraph{</xsl:text>
      <xsl:apply-templates select="db:title/node()"/>
      <xsl:if test="not(contains(':–-—',substring(normalize-space(db:title),string-length(normalize-space(db:title)))))">
        <xsl:text>\thinspace:</xsl:text>
      </xsl:if>
      <xsl:text>}</xsl:text>
      <xsl:if test="@xml:id">
        <xsl:text>\label{</xsl:text>
        <xsl:value-of select="@xml:id"/>
        <xsl:text>}</xsl:text>
      </xsl:if>
      <xsl:text>&#xa;</xsl:text>
      <xsl:apply-templates/>
      <xsl:call-template name="checkpackages">
        <xsl:with-param name="pos" select="'after'"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <xsl:template name="checkpackages">
    <xsl:param name="pos"/>
    <xsl:if test="/db:book/db:info/db:cover/db:constraintdef
                  [@xml:id='clspackages' or @xml:id='stypackages']
                  [@linkend=current()/@xml:id]
                  [@role=$pos or not(@role)]">
      <xsl:variable name="gi" select="local-name()"/>
      <xsl:text>%\iffalse
%%
%% Packages required
%% 
% \fi
% \</xsl:text>
      <xsl:choose>
        <xsl:when test="$gi='chapter' or $gi='appendix'">
          <xsl:text>clearpage&#xa;% \section</xsl:text>
        </xsl:when>
        <xsl:when test="$gi='sect1'">
          <xsl:text>subsection</xsl:text>
        </xsl:when>
        <xsl:when test="$gi='sect2'">
          <xsl:text>subsubsection</xsl:text>
        </xsl:when>
        <xsl:when test="$gi='sect3'">
          <xsl:text>paragraph</xsl:text>
        </xsl:when>
        <xsl:when test="$gi='sect4'">
          <xsl:text>subparagraph</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:message>
            <xsl:text>WARNING: </xsl:text>
            <xsl:value-of select="$gi"/>
            <xsl:text> is an unidentifiable place to declare packages</xsl:text>
          </xsl:message>
          <xsl:text>message{Unidentifiable place to declare packages}</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:text>{</xsl:text>
      <xsl:choose>
        <xsl:when test="/db:book/db:info/db:cover
                        /db:constraintdef[@linkend=current()/@xml:id]
                        /db:segmentedlist/db:segtitle">
          <xsl:apply-templates 
            select="/db:book/db:info/db:cover
                    /db:constraintdef[@linkend=current()/@xml:id]
                    /db:segmentedlist/db:segtitle/node()"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>Packages loaded</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:text>}\label{</xsl:text>
      <xsl:value-of 
        select="/db:book/db:info/db:cover
                /db:constraintdef[@linkend=current()/@xml:id]
                /@xml:id"/>
      <xsl:text>}&#xa;</xsl:text>
      <xsl:for-each 
        select="/db:book/db:info/db:cover
                /db:constraintdef[@linkend=current()/@xml:id]
                /db:segmentedlist/db:seglistitem[db:seg!='']">
        <xsl:call-template name="packages">
          <xsl:with-param name="pkg" select="."/>
          <xsl:with-param name="dest" select="$filetype"/>
          <xsl:with-param name="mode" select="'deferred'"/>
        </xsl:call-template>
      </xsl:for-each>
      <xsl:text>% &#xa;</xsl:text>
      <xsl:if test="/db:book/db:info/db:cover
                    /db:constraintdef[@linkend=current()/@xml:id]
                    /@xml:id!='stypackages' 
                    and 
                    /db:book/db:info/db:cover
                    /db:constraintdef[@linkend=current()/@xml:id]
                    /@xml:id!='clspackages'">
        <xsl:message>
          <xsl:text>WARNING: these packages were listed in a </xsl:text>
          <xsl:value-of select="$gi"/>
          <xsl:text> element of the master document that was not flagged as belonging to this </xsl:text>
          <xsl:value-of select="$doctype"/>
          <xsl:text> (xml:id="</xsl:text>
          <xsl:value-of select="@xml:id"/>
          <xsl:text>").</xsl:text>
        </xsl:message>
        <xsl:text>% WARNING: these packages were listed in 
% a \verb`</xsl:text>
        <xsl:value-of select="$gi"/>
        <xsl:text>` of the master document that was not flagged 
% as belonging to this </xsl:text>
        <xsl:value-of select="$doctype"/>
        <xsl:text> (\verb`xml:id="</xsl:text>
        <xsl:value-of select="@xml:id"/>
        <xsl:text>"`).&#xa;</xsl:text>
      </xsl:if>
    </xsl:if>
  </xsl:template>

  <!-- section in prelims needs to be done as subsection -->
 
  <xsl:template match="db:section">
    <xsl:text>% \subsection*{</xsl:text>
    <xsl:apply-templates select="db:title/node()"/>
    <xsl:text>}</xsl:text>
    <xsl:if test="@xml:id">
      <xsl:text>\label{</xsl:text>
      <xsl:value-of select="@xml:id"/>
      <xsl:text>}</xsl:text>
    </xsl:if>
    <xsl:text>&#xa;</xsl:text>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="db:blockquote">
    <xsl:text>% \begin{quotation}</xsl:text>
    <xsl:text>\small\noindent&#xa;</xsl:text>
    <xsl:apply-templates/>
    <xsl:if test="@linkend">
      <xsl:text>% \hfill\begingroup</xsl:text>
      <xsl:call-template name="makeref"/>
      <xsl:text>\parfillskip=0pt\par\endgroup&#xa;</xsl:text>
    </xsl:if>
    <xsl:text>% \end{quotation}&#xa;</xsl:text>
  </xsl:template>

  <xsl:template match="db:warning | db:sidebar">
    <xsl:text>% \par\begingroup\fboxsep1em\centering&#xa;%   \</xsl:text>
    <xsl:choose>
      <xsl:when test="name()='sidebar'">
        <xsl:text>shadowbox</xsl:text>
      </xsl:when>
      <xsl:when test="name()='warning'">
        <xsl:text>fbox</xsl:text>
      </xsl:when>
    </xsl:choose>
    <xsl:text>{\begin{minipage}{</xsl:text>
    <xsl:choose>
      <xsl:when test="@wordsize">
        <xsl:value-of 
          select="number(substring-before(@wordsize,'%')) div 100"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>0.8</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:text>\columnwidth}\sffamily
%  \raggedright\parindent0pt\parskip=.5\baselineskip&#xa;</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>% \end{minipage}}\par\endgroup&#xa;</xsl:text>
  </xsl:template>

  <xsl:template match="db:warning/db:title | db:sidebar/db:title">
    <xsl:text>% \subsubsection*{\sffamily </xsl:text>
    <xsl:apply-templates/>
    <xsl:text>}&#xa;</xsl:text>
  </xsl:template>

  <xsl:template match="db:sidebar/db:address">
    <xsl:text>% \par\raggedleft </xsl:text>
    <xsl:apply-templates/>
    <xsl:text>\par&#xa;</xsl:text>
  </xsl:template>

  <!-- main element for code fragment markup -->

  <xsl:template match="db:annotation[@role and @role!='' and @xreflabel]
                       [not(@annotations)]">
    <xsl:variable name="role" select="@role"/>
    <xsl:text>% \begin{</xsl:text>
    <xsl:value-of select="$role"/>
    <xsl:text>}{</xsl:text>
    <xsl:if test="$role='macro' or $role='variable' or
                  $prepost//db:command[starts-with(.,'\doxitem')]
                  [contains(.,concat('{',$role,'}'))]
                  [contains(.,'macrolike')]">
      <xsl:text>\</xsl:text>
    </xsl:if>
    <xsl:value-of select="@xreflabel"/>
    <xsl:text>}&#xa;</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>% \end{</xsl:text>
    <xsl:value-of select="$role"/>
    <xsl:text>}&#xa;</xsl:text>
  </xsl:template>

  <!-- pull option declaration data from spec tree -->

  <xsl:template match="db:annotation[@annotations]">
    <xsl:apply-templates/>
    <xsl:variable name="college" select="tokenize(@audience,' ')"/>
    <xsl:variable name="canopy" 
      select="//db:part[@xml:id='data']
              //db:constraintdef[@xml:id=current()/@annotations]"/>
    <xsl:for-each select="$college">
      <xsl:variable name="item" select="."/>
      <xsl:text>% \subsubsection{</xsl:text>
      <xsl:value-of select="translate(.,
                            'abcdefghijklmnopqrstuvwxyz',
                            'ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/>
      <xsl:text>}&#xa;</xsl:text>
      <xsl:apply-templates mode="declareoption"
        select="$canopy
                //db:methodsynopsis[tokenize(@arch,' ')=$item]">
      </xsl:apply-templates>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="db:annotation/db:title">
    <xsl:text>% \subsection{</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>}&#xa;</xsl:text>
  </xsl:template>

  <xsl:template match="db:methodsynopsis" mode="declareoption">
    <!-- make a low-level title -->
    <xsl:text>% \paragraph{</xsl:text>
    <xsl:value-of 
      select="normalize-space(db:methodparam[last()]/db:parameter)"/>
    <!-- start a Code block for the option -->
    <xsl:text>}&#xa;% \begin{option}{</xsl:text>
    <xsl:value-of select="@xml:id"/>
    <xsl:text>}&#xa;% </xsl:text>
    <!-- now the descriptive text as a paragraph -->
    <!-- multiple parameters only for divisions, not degrees -->
    <!-- in document order, which is hierarchical top-down -->
    <xsl:for-each select="db:methodparam/db:parameter">
      <xsl:sort select="position()" order="descending"/>
      <xsl:if test="position()>1">
        <xsl:text> in </xsl:text>
      </xsl:if>
      <xsl:value-of select="normalize-space(.)"/>
      <xsl:if test="not(@role='degree')">
        <xsl:text> (</xsl:text>
        <xsl:value-of select="@role"/>
        <xsl:text>)</xsl:text>
      </xsl:if>
    </xsl:for-each>
    <xsl:text>; </xsl:text>
    <xsl:if test="not(db:methodparam/db:parameter/@role='degree')">
      <xsl:text>&#xa;% using the </xsl:text>
      <!-- langs in methodsynopsis/@xml:lang for babel -->
      <xsl:value-of select="normalize-space(db:methodname)"/>
      <xsl:text> citation format&#xa;% from the \verb`</xsl:text>
      <xsl:value-of select="db:methodparam[1]/db:initializer"/>
      <xsl:text>.bst` \BibTeX\ style</xsl:text>
      <xsl:if test="db:methodparam[1]/db:modifier">
        <xsl:text> with the </xsl:text>
        <xsl:for-each select="db:methodparam[1]/db:modifier">
          <xsl:if test="preceding-sibling::db:modifier">
            <xsl:text> and </xsl:text>
          </xsl:if>
          <xsl:text>\textsf{</xsl:text>
          <xsl:value-of select="."/>
          <xsl:text>}</xsl:text>
        </xsl:for-each>
        <xsl:text> package</xsl:text>
        <xsl:if test="count(db:methodparam[1]/db:modifier)>1">
          <xsl:text>s</xsl:text>
        </xsl:if>
      </xsl:if>
      <xsl:choose>
        <xsl:when test="contains(@xlink:href,'@')">
          <xsl:text> (confirmed by \url{</xsl:text>
          <xsl:value-of select="@xlink:href"/>
          <xsl:text>})</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text> (unconfirmed)</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
    <!-- followed by the actual code for the declared option -->
    <xsl:text>.&#xa;%    \begin{macrocode}&#xa;\DeclareOption{</xsl:text>
    <xsl:value-of select="@xml:id"/>
    <xsl:text>}{%&#xa;</xsl:text>
    <!-- order doesn't matter here, but the line length does (maxcodelen) -->
    <xsl:for-each select="db:methodparam/db:parameter">
      <xsl:text>  \</xsl:text>
      <xsl:value-of select="@role"/>
      <xsl:if test="@remap=''">
        <xsl:text>[]</xsl:text>
      </xsl:if>
      <xsl:text>{</xsl:text>
      <!-- no more test for length to break if needed: too complex
      <xsl:call-template name="breakline">
        <xsl:with-param name="string" select="normalize-space(.)"/>
      </xsl:call-template> -->
      <xsl:value-of select="normalize-space(.)"/>
      <xsl:text>}&#xa;</xsl:text>
    </xsl:for-each>
    <xsl:if test="db:methodparam[1]/db:modifier or
                  db:methodparam[1]/db:initializer">
      <xsl:text>  \@usebib</xsl:text>
      <xsl:if test="db:methodparam[1]/db:modifier">
        <xsl:text>[</xsl:text>
        <xsl:for-each select="db:methodparam[1]/db:modifier">
          <xsl:if test="position()>1">
            <xsl:text>,</xsl:text>
          </xsl:if>
          <xsl:value-of select="."/>
        </xsl:for-each>
        <xsl:text>]</xsl:text>
      </xsl:if>
      <xsl:text>{</xsl:text>
      <xsl:value-of select="db:methodparam[1]/db:initializer"/>
      <xsl:text>}{</xsl:text>
      <xsl:value-of select="db:methodname"/>
      <xsl:text>}{}&#xa;</xsl:text>
    </xsl:if>
    <!-- dept-specific languages one day 
    <xsl:if test="@xml:lang">
      <xsl:text>  \use@babel[</xsl:text>
      <xsl:value-of select="translate(normalize-space(@xml:lang),' ',',')"/>
      <xsl:text>]{</xsl:text>
      <xsl:text>english</xsl:text>
      <xsl:text>}&#xa;</xsl:text>
      <xsl:variable name="langsused">
        <xsl:value-of select="normalize-space(@xml:lang)"/>
      </xsl:variable>
      <xsl:if test="@audience">
        <xsl:for-each select="tokenize(@audience,' ')">
          <xsl:variable name="curtok" select="position()"/>
          <xsl:text>  \def\</xsl:text>
          <xsl:value-of select="upper-case(.)"/>
          <xsl:text>{\foreignlanguage{</xsl:text>
          <xsl:value-of select="tokenize($langsused,' ')[position()=$curtok]"/>
          <xsl:text>}}&#xa;</xsl:text>
        </xsl:for-each>
      </xsl:if>
    </xsl:if>
-->
    <xsl:text>}&#xa;</xsl:text>
    <xsl:text>%    \end{macrocode}
% \end{option}&#xa;</xsl:text>
  </xsl:template>

  <xsl:template name="breakline">
    <xsl:param name="string"/>
    <xsl:param name="max">
      <xsl:value-of select="$maxcodelen"/>
    </xsl:param>
    <xsl:choose>
      <xsl:when test="string-length($string)>$max">
        <!-- see if there is a substring that will fit -->
        <xsl:choose>
          <!-- if there are no spaces, we're stuck, so use it as-is -->
          <xsl:when test="not(contains($string,' '))">
            <xsl:value-of select="$string"/>
          </xsl:when>
          <!-- if the first substring will fit, output it and try again -->
          <xsl:when 
            test="string-length(substring-before($string,' '))&lt;=$max">
            <xsl:value-of select="$max"/>
            <xsl:text>/</xsl:text>
            <xsl:value-of select="string-length(substring-before($string,' '))"/>
            <xsl:value-of select="substring-before($string,' ')"/>
            <xsl:text> </xsl:text>
            <!-- see how much we have left -->
            <xsl:choose>
              <xsl:when 
                test="($max - 1 -
                      string-length(substring-before($string,' ')))
                      &lt; 
                      string-length(substring-before(
                                    substring-after($string,' '), ' '))">
                <xsl:text>&#xa;   </xsl:text>
                <xsl:call-template name="breakline">
                  <xsl:with-param name="string" 
                    select="substring-after($string,' ')"/>
                </xsl:call-template>
              </xsl:when>
              <xsl:otherwise>
                <xsl:call-template name="breakline">
                  <xsl:with-param name="string" 
                    select="substring-after($string,' ')"/>
                  <xsl:with-param name="max" 
                    select="$max - 1 -
                            string-length(substring-before($string,' '))"/>
                </xsl:call-template>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:when>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$string"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="db:remark">
    <xsl:text>% \iffalse
%% v</xsl:text>
    <xsl:value-of select="@version"/>
    <xsl:text> </xsl:text>
    <xsl:choose>
      <xsl:when test="@revision">
        <xsl:value-of select="translate(@revision,'-','/')"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of 
          select="translate(
                  //db:revhistory/db:revision[@version=current()/@version]
                  /db:date/@conformance,'-','/')"/>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:text> </xsl:text>
    <xsl:value-of select="normalize-space(.)"/>
    <xsl:text>&#xa;% \fi&#xa;</xsl:text>
    <xsl:text>% \changes{v</xsl:text>
    <xsl:value-of select="@version"/>
    <xsl:text>}{</xsl:text>
    <xsl:choose>
      <xsl:when test="@revision">
        <xsl:value-of select="translate(@revision,'-','/')"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of 
          select="translate(
                  //db:revhistory/db:revision[@version=current()/@version]
                  /db:date/@conformance,'-','/')"/>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:text>}{</xsl:text>
    <xsl:value-of select="normalize-space(.)"/>
    <xsl:text>}&#xa;</xsl:text>
  </xsl:template>

  <!-- programlisting is what produces nicely-typeset code -->

  <xsl:template match="db:programlisting">
    <!-- this references @remap, @xreflabel, @xml:id, @condition,
         @xlink:href, @startinglinenumber, @continuation, @wordsize,
         @language, @arch, @annotations, @role, xlink:show -->
    <xsl:choose>
      <!-- 1. SPECIAL USE IN GENERATING DTX MACROCODE: 
           this occurs only in the "code" section of a 
           classpack document where the code is unadorned -->
      <xsl:when test="(parent::annotation[@xreflabel]
                       or ancestor::db:part[@xml:id='code'])
                      and not(@condition='ignore')">
        <xsl:text>%    \begin{macrocode}&#xa;</xsl:text>
        <!-- note any fragments required as external files
             specified in the 'code' part get output as extractables
             at the end of the dtx file, as separate tagging can't
             be nested inside class or package tags -->
        <xsl:call-template name="lrtrim">
          <xsl:with-param name="text" select="."/>
        </xsl:call-template>
        <xsl:text>&#xa;%    \end{macrocode}&#xa;</xsl:text>
      </xsl:when>
      <!-- 2. INTERPRETABLE FORMATS IN DOCUMENTATION 
           (embedded markup) -->
      <xsl:when test="db:token or db:xref">
        <xsl:text>% \iffalse
%&lt;*ignore>
% \fi
% \begin{Verbatim}[frame=single,framesep=1em,fontsize=\small,commandchars=\\\{\}</xsl:text>
        <xsl:if test="@xml:id and @role">
          <xsl:text>,label=</xsl:text>
          <xsl:value-of select="@xml:id"/>
          <xsl:text>,title={</xsl:text>
          <xsl:value-of select="normalize-space(@role)"/>
          <xsl:text>}</xsl:text>
        </xsl:if>
        <xsl:text>]&#xa;</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>&#xa;% \end{Verbatim}
% \iffalse
%&lt;/ignore>
% \fi&#xa;</xsl:text>
      </xsl:when>
      <!-- 3. EXAMPLE USE IN CODE, 
           not for absorption into the package -->
      <xsl:when test="@condition='ignore'">
        <!--
        <xsl:call-template name="makelisting"/>
          -->
        <xsl:text>% \iffalse
%&lt;*ignore>
% \fi
% \begin{Verbatim}[frame=single,framesep=1em,fontsize=\small]&#xa;</xsl:text>
        <xsl:value-of select="."/>
        <xsl:text>
% \end{Verbatim}
% \iffalse
%&lt;/ignore>
% \fi&#xa;</xsl:text>
      </xsl:when>
      <!-- 4. OTHERWISE UNADORNED USE IN DOCUMENTATION,
           but allows use of userinput -->
      <xsl:otherwise>
        <xsl:call-template name="makelisting"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- named template to handle listings called at various points -->

  <xsl:template name="makelisting">
    <!-- context is a programlisting element type -->
    <xsl:choose>
      <!-- read lines from external file -->
      <xsl:when test="@xlink:href">
        <xsl:text>% \lstinputlisting[firstline=</xsl:text>
        <xsl:choose>
          <xsl:when test="@startinglinenumber">
            <xsl:value-of select="@startinglinenumber"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>1</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:if test="@endinglinenumber">
          <xsl:text>,lastline=</xsl:text>
          <xsl:value-of select="@endinglinenumber"/>
        </xsl:if>
        <!-- rest of settings are picked up after the begin/end type -->
      </xsl:when>
      <!-- otherwise do a begin and end -->
      <xsl:otherwise>
        <xsl:text>% \iffalse
%&lt;*ignore>
% \fi&#xa;</xsl:text>
        <xsl:text>\begin{lstlisting}[</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
    <!-- now pick the parameters needed:
         basicstyle=\footnotesize\color{Black}\ttfamily 
         and a lot else pre-set from prepost.xml configurations
         but the wordsize attribute can be used to change 
         the font size (either a size and baseline separated 
         by a slash, eg 12/14) or the whole basicstyle
         definition -->
    <xsl:if test="@xlink:href">
      <xsl:text>,</xsl:text>
    </xsl:if>
    <xsl:if test="@wordsize">
      <xsl:text>basicstyle=</xsl:text>
      <xsl:choose>
        <xsl:when test="contains(@wordsize,'/')">
          <xsl:text>\fontsize{</xsl:text>
          <xsl:value-of select="substring-before(@wordsize,'/')"/>
          <xsl:text>}{</xsl:text>
          <xsl:value-of select="substring-after(@wordsize,'/')"/>
          <xsl:text>}\selectfont</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="@wordsize"/>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:text>\color{Black}\ttfamily,</xsl:text>
    </xsl:if>
    <!-- set the language -->
    <xsl:text>language=</xsl:text>
    <xsl:choose>
      <xsl:when test="@language='LaTeX' or not(@language)">
        <xsl:text>{[LaTeX]TeX}</xsl:text>
      </xsl:when>
      <xsl:when test="@language='DocBook'">
        <xsl:text>{[DocBook]XML}</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="@language"/>
      </xsl:otherwise>
    </xsl:choose>
    <!-- default is unframed -->
    <xsl:if test="@arch='framed'">
      <xsl:text>,frame=single,framesep=1em</xsl:text>
    </xsl:if>
    <!-- remap for emphases and options -->
    <xsl:if test="@remap">
      <xsl:text>,emphstyle=</xsl:text>
      <xsl:value-of select="@remap"/>
    </xsl:if>
    <xsl:if test="@annotations or db:userinput">
      <xsl:text>,emph={</xsl:text>
      <xsl:value-of select="@annotations"/>
      <xsl:if test="db:userinput">
        <xsl:for-each select="db:userinput">
          <xsl:if 
            test="not(preceding-sibling::db:userinput[.=current()/.])">
            <xsl:if test="(position()=1 and ../@annotations) 
                          or position()&gt;1">
              <xsl:text>,</xsl:text>
            </xsl:if>
            <xsl:value-of select="."/>
          </xsl:if>
        </xsl:for-each>
      </xsl:if>
      <xsl:text>}</xsl:text>
    </xsl:if>
    <!-- label -->
    <xsl:if test="@xml:id">
      <xsl:text>,label=</xsl:text>
      <xsl:value-of select="@xml:id"/>
    </xsl:if>
    <xsl:text>]</xsl:text>
    <!-- end of settings -->
    <xsl:choose>
      <!-- for an included file, here's the filename -->
      <xsl:when test="@xlink:href">
        <xsl:text>{</xsl:text>
        <xsl:value-of select="@xlink:href"/>
        <xsl:text>}</xsl:text>
      </xsl:when>
      <!-- otherwise we need the newline -->
      <xsl:otherwise>
        <xsl:text>&#xa;</xsl:text>
        <!-- output the content -->
        <xsl:call-template name="lrtrim">
          <xsl:with-param name="text" select="."/>
          <xsl:with-param name="indent">
            <xsl:choose>
              <xsl:when test="contains(.,'\end{lstlisting}') or
                              contains(.,'\end{verbatim}') or
                              contains(.,'\end{Verbatim}')">
                <xsl:text>  </xsl:text>
              </xsl:when>
              <xsl:otherwise>
                <xsl:text></xsl:text>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:with-param>
        </xsl:call-template>
        <xsl:text>&#xa;\end{lstlisting}&#xa;</xsl:text>
        <xsl:text>% \iffalse
%&lt;/ignore>
% \fi&#xa;</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="db:userinput[not(parent::db:programlisting)]">
    <xsl:text>\emph{</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>}</xsl:text>
  </xsl:template>

  <xsl:template name="htrim">
    <xsl:param name="text"/>
    <xsl:variable name="TEXT" select="translate($text,'&#x9;',' ')"/>
    <xsl:choose>
      <xsl:when test="contains($TEXT,'  ')">
        <xsl:call-template name="htrim">
          <xsl:with-param name="text">
            <xsl:value-of select="substring-before($TEXT,'  ')"/>
            <xsl:text> </xsl:text>
            <xsl:value-of select="substring-after($TEXT,'  ')"/>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="contains($TEXT,'&#xa; ')">
        <xsl:call-template name="htrim">
          <xsl:with-param name="text">
            <xsl:value-of select="substring-before($TEXT,'&#xa; ')"/>
            <xsl:text>&#xa;</xsl:text>
            <xsl:value-of select="substring-after($TEXT,'&#xa; ')"/>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$TEXT"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="lrtrim">
    <xsl:param name="text"/>
    <xsl:param name="indent"/>
    <xsl:variable name="extent" select="string-length($text)"/>
    <xsl:choose>
      <!-- text in programlisting amost always begins with a newline,
           the one that comes right after <programlisting>, so remove
           it. This used to remove leading space and TAB characters,
           but that's wrong.
           substring($text,1,1)=' ' or  or
           substring($text,1,1)='&#x9;'
           -->
      <xsl:when test="substring($text,1,1)='&#xa;'">
        <xsl:call-template name="lrtrim">
          <xsl:with-param name="text" select="substring($text,2)"/>
          <xsl:with-param name="indent" select="$indent"/>
        </xsl:call-template>
      </xsl:when>
      <!-- then trim trailing white-space. This is right -->
      <xsl:when test="substring($text,$extent)=' ' or
                      substring($text,$extent)='&#xa;' or
                      substring($text,$extent)='&#x9;'">
        <xsl:call-template name="lrtrim">
          <xsl:with-param name="text" 
            select="substring($text,1,($extent - 1))"/>
          <xsl:with-param name="indent" select="$indent"/>
        </xsl:call-template>
      </xsl:when>
      <!-- now we're clean, but we need to paste on any indent
           passed by the calling routine, usually to avoid trouble
           with documentation the references \end{lstlisting} or
           \end{verbatim} within the text of the verbatim block -->
      <xsl:when test="$indent!=''">
        <xsl:call-template name="addindent">
          <xsl:with-param name="text" select="$text"/>
          <xsl:with-param name="indent" select="$indent"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$text"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="addindent">
    <xsl:param name="text"/>
    <xsl:param name="indent"/>
    <xsl:value-of select="$indent"/>
    <xsl:choose>
      <xsl:when test="contains($text,'&#xa;')">
        <xsl:value-of select="substring-before($text,'&#xa;')"/>
        <xsl:text>&#xa;</xsl:text>
        <xsl:call-template name="addindent">
          <xsl:with-param name="text" select="substring-after($text,'&#xa;')"/>
          <xsl:with-param name="indent" select="$indent"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$text"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- tables and figures -->

  <xsl:template match="db:table">
    <xsl:text>% \begin{table}</xsl:text>
    <xsl:if test="@floatstyle">
      <xsl:text>[</xsl:text>
      <xsl:value-of select="@floatstyle"/>
      <xsl:text>]</xsl:text>
    </xsl:if>
    <xsl:text>\small\sffamily&#xa;</xsl:text>
    <xsl:apply-templates/>
    <xsl:if test="db:textobject[@role='footer']">
      <xsl:text>% \par\bigskip\footnotesize&#xa;</xsl:text>
      <xsl:apply-templates select="db:textobject[@role='footer']/*"/>
    </xsl:if>
    <xsl:text>% \end{table}&#xa;</xsl:text>
  </xsl:template>

  <xsl:template match="db:table/db:textobject[@role='footer']"/>

  <xsl:template match="db:table/db:title | db:figure/db:title">
    <xsl:text>% \caption{</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>}</xsl:text>
    <xsl:if test="../@xml:id">
      <xsl:text>\label{</xsl:text>
      <xsl:value-of select="../@xml:id"/>
      <xsl:text>}</xsl:text>
    </xsl:if>
    <xsl:text>\medskip&#xa;</xsl:text>
  </xsl:template>

  <xsl:template match="db:informaltable">
    <xsl:text>% \par\medskip{\sffamily\small</xsl:text>
    <xsl:if test="@xml:id">
      <xsl:text>\label{</xsl:text>
      <xsl:value-of select="@xml:id"/>
      <xsl:text>}</xsl:text>
    </xsl:if>
    <xsl:text>&#xa;</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>% }&#xa;</xsl:text>
  </xsl:template>

  <xsl:template match="db:tgroup">
    <xsl:text>% \begingroup</xsl:text>
    <xsl:value-of select="parent::db:table/@remap"/>
    <xsl:text>&#xa;% \centering&#xa;% \begin{tabular}{</xsl:text>
    <xsl:choose>
      <xsl:when test="@tgroupstyle='overhang'">
        <xsl:text></xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>@{}</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:text>%&#xa;% &#x9;</xsl:text>
    <xsl:for-each select="db:colspec">
      <xsl:call-template name="colprefix"/>
      <xsl:call-template name="colsettings"/>
      <xsl:call-template name="colsuffix"/>
      <xsl:text>%&#xa;% &#x9;</xsl:text>
    </xsl:for-each>
    <xsl:choose>
      <xsl:when test="@tgroupstyle='overhang'">
        <xsl:text></xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>@{}</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:text>}&#xa;</xsl:text>
    <xsl:apply-templates select="db:thead"/>
    <xsl:if test="not(db:thead)">
      <xsl:text>% \hline&#xa;</xsl:text>
    </xsl:if>
    <xsl:apply-templates select="db:tbody"/>
    <xsl:apply-templates select="db:tfoot"/>
    <xsl:text>% \end{tabular}&#xa;</xsl:text>
    <!-- fake footnotes -->
    <xsl:if test="starts-with(db:tbody/@xlink:href,'affil') and
                  count(//db:part[@xml:id='data']
                  //db:constraintdef[@xml:id=
                  concat(substring-before(current()/db:tbody/@xlink:href,'-'),'options')]
                  /db:methodsynopsis[tokenize(@arch,' ')=
                  substring-after(current()/db:tbody/@xlink:href,'-')]
                  [db:modifier])>0">
      <xsl:text>% \scriptsize
% \renewcommand{\labelenumi}{\itshape\alph{enumi}\upshape)}
% \begin{enumerate}[noitemsep]&#xa;</xsl:text>
      <xsl:for-each 
        select="//db:part[@xml:id='data']
                //db:constraintdef[@xml:id=
                concat(substring-before(current()/db:tbody/@xlink:href,'-'),'options')]
                /db:methodsynopsis[tokenize(@arch,' ')=
                substring-after(current()/db:tbody/@xlink:href,'-')]
                /db:modifier">
        <xsl:text>%   \item The \texttt{</xsl:text>
        <xsl:value-of select="../@xml:id"/>
        <xsl:text>} option </xsl:text>
        <xsl:apply-templates/>
        <xsl:text>&#xa;</xsl:text>
      </xsl:for-each>
      <xsl:text>% \end{enumerate}
% \setcounter{fnote}{0}&#xa;</xsl:text>
    </xsl:if>
    <xsl:text>% \par\endgroup&#xa;</xsl:text>
  </xsl:template>

  <xsl:template match="db:colspec"/>

  <xsl:template name="colprefix">
    <!-- @colwidth in <colspec>
         @wordsize in <entry>, here and below -->
    <xsl:if test="@condition or @colwidth or @wordsize">
      <xsl:text>>{</xsl:text>
      <xsl:choose>
        <xsl:when test="@align='left' and (@colwidth or @wordsize)">
          <xsl:text>\raggedright{}</xsl:text>
        </xsl:when>
        <xsl:when test="@align='right' and (@colwidth or @wordsize)">
          <xsl:text>\raggedleft{}</xsl:text>
        </xsl:when>
        <xsl:when test="@align='center'">
          <xsl:text>\centering{}</xsl:text>
        </xsl:when>
        <!-- default is justified anyway, and char is inapplicable -->
      </xsl:choose>
      <!-- condition is for typographic changes -->
      <xsl:value-of select="@condition"/>
      <xsl:text>\prestrut</xsl:text>
      <xsl:if test="@align and (@colwidth or @wordsize or @condition)">
        <xsl:text>\arraybackslash</xsl:text>
      </xsl:if>
      <xsl:text>}</xsl:text>
    </xsl:if>
  </xsl:template>

  <xsl:template name="colsettings">
    <!-- this is the type of column (p|m|b) and width -->
    <xsl:choose>
      <xsl:when test="@colwidth or @wordsize">
        <xsl:choose>
          <xsl:when test="@char='m' or @char='b'">
            <xsl:value-of select="@char"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>p</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:text>{</xsl:text>
        <xsl:variable name="width" select="@colwidth | @wordsize"/>
        <xsl:choose>
          <xsl:when test="contains($width,'%')">
            <xsl:value-of 
              select="number(substring-before($width,'%')) div 100"/>
            <xsl:text>\columnwidth</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$width"/>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:text>}</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="@align='left' or @align='right' or @align='center'">
            <xsl:value-of select="substring(@align,1,1)"/>
          </xsl:when>
          <xsl:when test="@align='char'">
            <xsl:text>d</xsl:text>
          </xsl:when>
          <!-- justified is implied by @colwidth or @wordsize above -->
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="colsuffix">
    <xsl:text>&lt;{</xsl:text>
    <xsl:value-of select="normalize-space(@conformance)"/>
    <xsl:text>\poststrut\arraybackslash}</xsl:text>
  </xsl:template>

  <xsl:template match="db:thead">
    <xsl:apply-templates/>
    <xsl:text>[2pt]\hline&#xa;</xsl:text>
  </xsl:template>

  <xsl:template match="db:tbody">
    <xsl:text>% </xsl:text>
    <xsl:if test="not(db:row[1]/db:entry[1]/@spanname)">
      <xsl:text>\vstrut</xsl:text>
    </xsl:if>
    <xsl:text>&#xa;</xsl:text>
    <xsl:choose>
      <!-- eg, xlink:href='deg-acsss' --> 
      <xsl:when test="@xlink:href and @xlink:show='embed'">
        <xsl:apply-templates 
          select="//db:part[@xml:id='data']
                  //db:constraintdef[@xml:id=
                  concat(substring-before(current()/@xlink:href,'-'),'options')]
                  /db:methodsynopsis
                  [tokenize(@arch,' ')=substring-after(current()/@xlink:href,'-')]" mode="row">
          <xsl:sort select="@xml:id"/>
        </xsl:apply-templates>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="db:methodsynopsis" mode="row">
    <!-- each of these produces one row of the table -->
    <xsl:text>% </xsl:text>
    <!-- signal a footnote if needed -->
    <xsl:if test="db:modifier">
      <xsl:text>\fnote{}</xsl:text>
    </xsl:if>
    <!-- col 1: token for option -->
    <xsl:value-of select="@xml:id"/>
    <xsl:text>&amp;%&#xa;</xsl:text>
    <!-- col 2: division[s], may be multiple methodparam elements -->
    <xsl:for-each select="db:methodparam/db:parameter">
      <xsl:text>%&#x9;</xsl:text>
      <!-- @remap is a prefix except for institutes and centres -->
      <xsl:if test="not(@remap='') and @role!='institute' and @role!='centre'">
        <xsl:value-of select="normalize-space(@remap)"/>
        <xsl:text> </xsl:text>
      </xsl:if>
      <!-- the name -->
      <xsl:apply-templates/>
      <!-- @remap is a suffix for institutes and centres -->
      <xsl:if test="not(@remap='') and (@role='institute' or @role='centre')">
        <xsl:text> </xsl:text>
        <xsl:value-of select="normalize-space(@remap)"/>
      </xsl:if>
      <!-- any following divisions involved (only for affiliations) -->
      <xsl:choose>
        <xsl:when test="position()!=last()">
          <xsl:text>; </xsl:text>
        </xsl:when>
        <!-- dummy to terminate degree options cleanly -->
        <xsl:when test="@role='degree'">
          <xsl:text></xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>&amp;%&#xa;</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
    <!-- citation format -->
    <xsl:if test="not(db:methodparam/db:parameter/@role='degree')">
      <xsl:text>%&#x9;</xsl:text>
      <xsl:value-of select="db:methodname"/>
    </xsl:if>
    <xsl:text>\\\hline[.1pt]%&#xa;</xsl:text>
  </xsl:template>

  <xsl:template match="db:row">
    <xsl:text>% </xsl:text>
    <xsl:if test="@role='header'">
      <xsl:if test="position()>1">
        <xsl:text>[2pt]\hline&#xa;% </xsl:text>
      </xsl:if>
    </xsl:if>
    <xsl:apply-templates/>
    <xsl:text>\\</xsl:text>
    <!--
    <xsl:if test="position()=last()">
      <xsl:text>[2pt]</xsl:text>
    </xsl:if>
    -->
    <xsl:if test="@role='header'">
      <xsl:text>[2pt]\hline\vstrut</xsl:text>
    </xsl:if>
    <xsl:if test="(ancestor::db:tbody or ancestor::db:tfoot) 
                  and position()=last()">
      <xsl:text>[2pt]\hline</xsl:text>
    </xsl:if>
    <xsl:if test="not(ancestor::db:thead)">
      <xsl:text>&#xa;</xsl:text>
    </xsl:if>
  </xsl:template>

  <xsl:template match="db:entry[ancestor::db:thead or ancestor::db:tfoot]">
    <xsl:if test="preceding-sibling::db:entry">
      <xsl:text>&amp;</xsl:text>
    </xsl:if>
    <!-- always make headers paragraphic, which means \multicolumn{1}...
         because we don't know how they need to be formatted -->
    <xsl:text>\multicolumn{</xsl:text>
    <xsl:choose>
      <xsl:when test="@spanname">
        <xsl:value-of select="@spanname"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>1</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:text>}{</xsl:text>
    <!-- omit LH shoulder on first column -->
    <xsl:if test="count(preceding-sibling::db:entry)=0">
      <xsl:text>@{}</xsl:text>
    </xsl:if>
    <xsl:choose>
      <!-- if alignment or width is specified in the heading cell, 
           use local settings, honouring local prefix/suffix -->
      <xsl:when test="@align or @colwidth">
        <xsl:call-template name="colprefix"/>
        <xsl:call-template name="colsettings"/>
        <xsl:call-template name="colsuffix"/>
      </xsl:when>
      <!-- otherwise use the column default, 
           but use local prefix/suffix by preference -->
      <xsl:otherwise>
        <!-- identify the column number -->
        <xsl:variable name="colpos"
          select="count(preceding-sibling::db:entry) + 1"/>
        <!-- test for the prefix -->
        <xsl:choose>
          <xsl:when 
            test="ancestor::db:tgroup/db:colspec[position()=$colpos]/@condition
                  or 
                  ancestor::db:tgroup/db:colspec[position()=$colpos]/@colwidth
                  or 
                  ancestor::db:tgroup/db:colspec[position()=$colpos]/@wordsize">
            <xsl:for-each 
              select="ancestor::db:tgroup/db:colspec[position()=$colpos]">
              <xsl:call-template name="colprefix"/>
            </xsl:for-each>
          </xsl:when>
          <xsl:otherwise>
            <xsl:call-template name="colprefix"/>
          </xsl:otherwise>
        </xsl:choose>
        <!-- switch context to the colspec to get the settings -->
        <xsl:for-each 
          select="ancestor::db:tgroup/db:colspec[position()=$colpos]">
          <xsl:call-template name="colsettings"/>
        </xsl:for-each>
        <!-- test for the suffix -->
        <xsl:choose>
          <xsl:when 
            test="ancestor::db:tgroup/db:colspec[position()=$colpos]/@condition
                  or 
                  ancestor::db:tgroup/db:colspec[position()=$colpos]/@colwidth
                  or 
                  ancestor::db:tgroup/db:colspec[position()=$colpos]/@wordsize">
            <xsl:for-each 
              select="ancestor::db:tgroup/db:colspec[position()=$colpos]">
              <xsl:call-template name="colsuffix"/>
            </xsl:for-each>
          </xsl:when>
          <xsl:otherwise>
            <xsl:call-template name="colsuffix"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:if test="count(following-sibling::db:entry)=0">
      <xsl:text>@{}</xsl:text>
    </xsl:if>
    <xsl:text>}{\sffamily\bfseries </xsl:text>
    <xsl:apply-templates/>
    <xsl:text>}</xsl:text>
  </xsl:template>

  <xsl:template match="db:entry[ancestor::db:tbody]">
    <xsl:if test="preceding-sibling::db:entry">
      <xsl:text>&amp;</xsl:text>
    </xsl:if>
    <xsl:if test="@spanname">
      <xsl:text>\multicolumn{</xsl:text>
      <xsl:value-of select="@spanname"/>
      <xsl:text>}{</xsl:text>
      <xsl:if test="count(preceding-sibling::db:entry)=0">
        <xsl:text>@{}</xsl:text>
      </xsl:if>
      <xsl:choose>
        <!-- if alignment or width is specified, 
             use local settings -->
        <xsl:when test="@align or @wordsize">
          <xsl:call-template name="colprefix"/>
          <xsl:call-template name="colsettings"/>
          <xsl:call-template name="colsuffix"/>
        </xsl:when>
        <!-- otherwise use default, 
             but check local pre and post -->
        <xsl:otherwise>
          <xsl:call-template name="colprefix"/>
          <xsl:variable name="colpos"
            select="count(preceding-sibling::db:entry) + 1"/>
          <xsl:for-each 
            select="ancestor::db:tbody/db:colspec[position()=$colpos]">
            <xsl:call-template name="colsettings"/>
          </xsl:for-each>
          <xsl:call-template name="colsuffix"/>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:if test="count(following-sibling::db:entry)=0">
        <xsl:text>@{}</xsl:text>
      </xsl:if>
      <xsl:text>}{</xsl:text>
    </xsl:if>
    <!-- check for hangouts -->
    <xsl:if test="@annotations">
      <xsl:text>\llap{\normalfont </xsl:text>
      <xsl:value-of select="@annotations"/>
      <xsl:text>}</xsl:text>
    </xsl:if>
    <!-- text for headers is in bold -->
    <xsl:if test="../@role='header'">
      <xsl:text>\vstrut\bfseries </xsl:text>
    </xsl:if>
    <!-- check for row-spanned brace-collected -->
    <xsl:if test="@morerows">
      <xsl:if test="@charoff and @char">
        <xsl:text>\llap{</xsl:text>
        <xsl:value-of select="@char"/>
        <xsl:value-of select="@morerows"/>
        <xsl:text>{</xsl:text>
        <xsl:value-of select="@charoff"/>
        <xsl:text>}</xsl:text>
        <xsl:text>}%&#xa;% &#x9;</xsl:text>
      </xsl:if>
      <xsl:text>\multirow{</xsl:text>
      <xsl:value-of select="@morerows"/>
      <xsl:text>}{</xsl:text>
      <xsl:value-of select="@wordsize"/>
      <xsl:text>}{</xsl:text>
    </xsl:if>
    <!-- now we're in the content at last -->
    <xsl:if test="@condition">
      <xsl:value-of select="@condition"/>
      <xsl:text>{}</xsl:text>
    </xsl:if>
    <xsl:choose>
      <!-- mldr &#x2026; on its own (\dotfill) needs a \hbox -->
      <xsl:when test=".='\dotfill{}' and @wordsize">
        <xsl:text>\hbox to </xsl:text>
        <xsl:value-of select="@wordsize"/>
        <xsl:text>{</xsl:text>
        <xsl:value-of select="."/>
        <xsl:text>}</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates/>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:if test="@morerows">
      <xsl:text>}</xsl:text>
    </xsl:if>
    <xsl:if test="@spanname">
      <xsl:text>}</xsl:text>
    </xsl:if>
  </xsl:template>

  <xsl:template match="db:figure">
    <xsl:if test="@floatstyle='p' and
                  descendant::db:imagedata[@format='pdf' and @condition]">
      <xsl:text>% \clearpage&#xa;</xsl:text>
    </xsl:if>
    <xsl:text>% \begin{figure}</xsl:text>
    <xsl:if test="@floatstyle">
      <xsl:text>[</xsl:text>
      <xsl:value-of select="@floatstyle"/>
      <xsl:text>]</xsl:text>
    </xsl:if>
    <xsl:text>\small\sffamily\centering&#xa;</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>% \end{figure}&#xa;</xsl:text>
    <xsl:if test="@floatstyle='p' and
                  descendant::db:imagedata[@format='pdf' and @condition]">
      <xsl:text>% \clearpage&#xa;</xsl:text>
    </xsl:if>
  </xsl:template>

  <xsl:template match="db:informalfigure">
    <xsl:text>% \begin{center}&#xa;</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>% \end{center}&#xa;</xsl:text>
  </xsl:template>

  <xsl:template match="db:figure/db:mediaobject | 
                       db:informalfigure/db:mediaobject">
    <xsl:if test="@role='framed'">
      <xsl:text>% \fbox{\vbox{%
%   \advance\hsize by-2\fboxsep\advance\hsize by-2\fboxrule&#xa;</xsl:text>
    </xsl:if>
    <xsl:apply-templates/>
    <xsl:if test="@role='framed'">
      <xsl:text>% }}&#xa;</xsl:text>
    </xsl:if>
  </xsl:template>

  <xsl:template match="db:imageobject">
    <xsl:choose>
      <!-- detect a previous image -->
      <xsl:when test="preceding-sibling::*[1][local-name()='imageobject']">
        <xsl:choose>
          <xsl:when test="@dir='ltr'">
            <xsl:text>% \quad\vrule\quad&#xa;</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>% \\&#xa;</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text></xsl:text>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="db:imagedata">
    <xsl:choose>
      <xsl:when test="@align='center'">
        <xsl:text>% \centering&#xa;</xsl:text>
      </xsl:when>
      <xsl:when test="@align='right'">
        <xsl:text>% \flushright&#xa;</xsl:text>
      </xsl:when>
    </xsl:choose>
    <xsl:if test="@arch='framed'">
      <xsl:text>% \fbox{%&#xa;</xsl:text>
    </xsl:if>
    <xsl:choose>
      <xsl:when test="@fileref">
        <xsl:choose>
          <xsl:when test="@format='pdf' and @condition">
            <xsl:text>% \includepdf</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>% \includegraphics</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:text>[</xsl:text>
        <xsl:choose>
          <xsl:when test="@condition">
            <xsl:value-of select="normalize-space(@condition)"/>
          </xsl:when>
          <xsl:when test="@width">
            <xsl:text>width=</xsl:text>
            <xsl:choose>
              <xsl:when test="contains(@width,'%')">
                <xsl:value-of 
                  select="number(substring-before(@width,'%')) div 100"/>
                <xsl:text>\columnwidth</xsl:text>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="@width"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:when>
          <xsl:when test="@depth">
            <xsl:text>height=</xsl:text>
            <xsl:choose>
              <xsl:when test="contains(@depth,'%')">
                <xsl:value-of 
                  select="number(substring-before(@depth,'%')) div 100"/>
                <xsl:text>\textheight</xsl:text>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="@depth"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>width=\columnwidth</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:text>]</xsl:text>
        <xsl:text>{</xsl:text>
        <xsl:value-of select="@fileref"/>
        <xsl:text>}</xsl:text>
      </xsl:when>
      <xsl:when test="@remap">
        <xsl:text>% </xsl:text>
        <xsl:if test="@condition">
          <xsl:text>{</xsl:text>
          <xsl:value-of select="normalize-space(@condition)"/>
        </xsl:if>
        <xsl:value-of select="@remap"/>
        <xsl:if test="@condition">
          <xsl:text>}</xsl:text>
        </xsl:if>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>IMAGE</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:if test="@arch='framed'">
      <xsl:text>}</xsl:text>
    </xsl:if>
    <xsl:text>&#xa;</xsl:text>
  </xsl:template>

  <!-- lists -->

  <xsl:template match="db:itemizedlist">
    <xsl:text>% \begin{itemize}</xsl:text>
    <xsl:if test="@spacing='compact'">
      <xsl:text>[noitemsep]</xsl:text>
    </xsl:if>
    <xsl:text>&#xa;</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>% \end{itemize}&#xa;</xsl:text>
  </xsl:template>

  <xsl:template match="db:orderedlist/db:title | 
                       db:procedure/db:title |
                       db:simplelist[@arch='enumerate']/db:title"/>

  <xsl:template match="db:orderedlist | 
                       db:procedure |
                       db:simplelist[@arch='enumerate']">
    <xsl:variable name="armour">
      <xsl:choose>
        <xsl:when test="parent::db:para">
          <xsl:text></xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>%</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <!-- check format for twocol wrapper -->
    <xsl:if test="@role='twocol'">
      <xsl:value-of select="$armour"/>
      <xsl:text> \begin{multicols}{2}&#xa;</xsl:text>
    </xsl:if>
    <xsl:if test="db:title">
      <xsl:value-of select="$armour"/>
      <xsl:text> \noindent\textbf{</xsl:text>
      <xsl:apply-templates select="db:title/node()"/>
      <xsl:text>}&#xa;</xsl:text>
    </xsl:if>
    <xsl:if test="@xml:id">
      <xsl:value-of select="$armour"/>
      <xsl:text> \label{</xsl:text>
      <xsl:value-of select="@xml:id"/>
      <xsl:text>}&#xa;</xsl:text>
    </xsl:if>
    <xsl:value-of select="$armour"/>
    <xsl:text> \begin{enumerate</xsl:text>
    <!-- check spacing -->
    <xsl:if test="parent::db:para">
      <xsl:text>*</xsl:text>
    </xsl:if>
    <xsl:text>}</xsl:text>
    <xsl:if test="parent::db:para 
                  or
                  (@linkend and
                   preceding::db:orderedlist[@xml:id=current()/@linkend]) 
                  or
                  @spacing='compact' or local-name()='simplelist'
                  or
                  @startingnumber">
      <xsl:text>[</xsl:text>
      <!-- test inline -->
      <xsl:if test="parent::db:para">
        <xsl:text>label=\emph{\alph*})</xsl:text>
      </xsl:if>
      <!-- test resumption -->
      <xsl:if test="@linkend and
                    preceding::db:orderedlist[@xml:id=current()/@linkend]">
        <xsl:if test="parent::db:para">
          <xsl:text>,</xsl:text>
        </xsl:if>
        <xsl:text>resume</xsl:text>
      </xsl:if>
      <!-- check spacing -->
      <xsl:if test="@spacing='compact' or local-name()='simplelist'">
        <xsl:if test="parent::db:para or
                      (@linkend and
                       preceding::db:orderedlist[@xml:id=current()/@linkend])">
          <xsl:text>,</xsl:text>
        </xsl:if>
        <xsl:text>noitemsep</xsl:text>
      </xsl:if>
      <!-- check numbering -->
      <xsl:if test="@startingnumber">
        <xsl:if test="parent::db:para or
                      (@linkend and
                       preceding::db:orderedlist[@xml:id=current()/@linkend])
                      or @spacing='compact' or local-name()='simplelist'">
          <xsl:text>,</xsl:text>
        </xsl:if>
        <xsl:text>start=</xsl:text>
        <xsl:value-of select="@startingnumber"/>
      </xsl:if>
      <xsl:text>]</xsl:text>
    </xsl:if>
    <!-- do list -->
    <xsl:text>&#xa;</xsl:text>
    <xsl:apply-templates/>
    <!-- no withdrawal of armour needed for inline list termination
         because the end of a lit item para will have created a newline -->
    <xsl:text>% \end{enumerate</xsl:text>
    <!-- check spacing -->
    <xsl:if test="parent::db:para">
      <xsl:text>*</xsl:text>
    </xsl:if>
    <xsl:text>}</xsl:text>
    <xsl:if test="not(parent::db:para)">
      <xsl:text>&#xa;</xsl:text>
    </xsl:if>
    <!-- check format -->
    <xsl:if test="@role='twocol'">
      <xsl:text>% \end{multicols}&#xa;</xsl:text>
    </xsl:if>
  </xsl:template>

  <xsl:template match="db:variablelist">
    <xsl:text>% \begin{description}[style=unboxed</xsl:text>
    <xsl:if test="@spacing='compact'">
      <xsl:text>,noitemsep</xsl:text>
    </xsl:if>
    <xsl:text>]&#xa;</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>% \end{description}&#xa;</xsl:text>
  </xsl:template>

  <xsl:template match="db:simplelist[@role='twocol']">
    <xsl:text>% \begin{multicols}{2}</xsl:text>
    <xsl:if test="@xreflabel">
      <xsl:text>[\paragraph*{</xsl:text>
      <xsl:value-of select="normalize-space(@xreflabel)"/>
      <xsl:text>}]</xsl:text>
    </xsl:if>
    <xsl:text>\begin{itemize}[noitemsep]&#xa;</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>% \end{itemize}
% \end{multicols}&#xa;</xsl:text>
  </xsl:template>

  <xsl:template match="db:type[@role='font']">
    <xsl:text>{</xsl:text>
    <xsl:if test="@arch">
      <xsl:text>\fontencoding{</xsl:text>
      <xsl:value-of select="upper-case(@arch)"/>
      <xsl:text>}</xsl:text>
    </xsl:if>
    <xsl:if test="@remap">
      <!-- special cases -->
      <xsl:choose>
        <xsl:when test="@remap='sans'">
          <xsl:text>\sffamily</xsl:text>
        </xsl:when>
        <xsl:when test="@remap='serif'">
          <xsl:text>\rmfamily</xsl:text>
        </xsl:when>
        <xsl:when test="@remap='mono'">
          <xsl:text>\ttfamily</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>\fontfamily{</xsl:text>
          <xsl:value-of select="@remap"/>
          <xsl:text>}</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
    <xsl:if test="@condition">
      <!-- special cases -->
      <xsl:choose>
        <xsl:when test="@condition='italic'">
          <xsl:text>\itshape</xsl:text>
        </xsl:when>
        <xsl:when test="@condition='smallcaps'">
          <xsl:text>\scshape</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>\fontshape{</xsl:text>
          <xsl:value-of select="@condition"/>
          <xsl:text>}</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
    <xsl:if test="@annotations">
      <!-- special cases -->
      <xsl:choose>
        <xsl:when test="@annotations='bold'">
          <xsl:text>\bfseries</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>\fontseries{</xsl:text>
          <xsl:value-of select="@annotations"/>
          <xsl:text>}</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
    <xsl:text>\selectfont </xsl:text>
    <xsl:apply-templates/>
    <xsl:text>}</xsl:text>
  </xsl:template>

  <xsl:template match="db:property[@role]">
    <xsl:value-of select="@role"/>
    <xsl:text>{</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>}</xsl:text>
  </xsl:template>

  <!-- list items -->

  <xsl:template match="db:itemizedlist/db:listitem |
                       db:orderedlist/db:listitem |
                       db:procedure/db:step |
                       db:simplelist/db:member">
    <!-- add syntax to inline lists -->
    <xsl:if test="ancestor::db:para and 
                  not(following-sibling::db:listitem)">
      <xsl:choose>
        <xsl:when test="parent::db:orderedlist or parent::db:procedure">
          <xsl:text>% and &#xa;</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>% or &#xa;</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
    <xsl:text>% \item</xsl:text>
    <xsl:choose>
      <!-- remap a bullet or number -->
      <xsl:when test="@remap or parent::db:simplelist">
        <xsl:text>[</xsl:text>
        <xsl:value-of select="@remap"/>
        <xsl:text>]</xsl:text>
      </xsl:when>
      <!-- or prefix the number with a symbol (what was this for?!) -->
      <xsl:when test="@role">
        <xsl:text>\leavevmode\llap{</xsl:text>
        <xsl:value-of select="@role"/>
        <xsl:text>\thinspace}</xsl:text>
      </xsl:when>
      <!-- normally just a space -->
      <xsl:otherwise>
        <xsl:text> </xsl:text>
      </xsl:otherwise>
    </xsl:choose>
    <!-- label it if needed -->
    <xsl:if test="@xml:id">
      <xsl:text>\label{</xsl:text>
      <xsl:value-of select="@xml:id"/>
      <xsl:text>}</xsl:text>
    </xsl:if>
    <xsl:apply-templates/>
    <!-- syntactic punctuation now handled by db:para template 
         except for db:member, which needs terminating -->
    <xsl:if test="local-name()='member'">
      <xsl:text>&#xa;</xsl:text>
    </xsl:if>
  </xsl:template>

  <xsl:template match="db:term">
    <xsl:text>% \item[</xsl:text>
    <xsl:apply-templates/>
    <xsl:if test="not(db:command[@conformance or @condition])">
      <xsl:text>\thinspace:</xsl:text>
    </xsl:if>
    <xsl:text>]</xsl:text>
    <xsl:if test="../@xml:id">
      <xsl:text>\label{</xsl:text>
      <xsl:value-of select="../@xml:id"/>
      <xsl:text>}</xsl:text>
    </xsl:if>
  </xsl:template>

  <!-- inline -->

  <xsl:template match="db:token">
    <xsl:text>{\normalfont\itshape</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>}</xsl:text>
  </xsl:template>

  <xsl:template match="db:package">
    <xsl:if test="@role and
                  not(ancestor::db:title) and 
                  not(ancestor::db:abstract) and 
                  not(ancestor::db:acknowledgements) and 
                  not(ancestor::db:term) and 
                  not(ancestor::db:footnote) and 
                  not(ancestor::db:table) and 
                  not(ancestor::db:informaltable) and 
                  not(ancestor::db:figure)
                  and not(preceding-sibling::db:package[.=current()/.])">
      <xsl:text>\DescribePackage{</xsl:text>
      <xsl:choose>
      <xsl:when test=".=''">
        <xsl:value-of select="/*[1]/@xml:id"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="."/>
      </xsl:otherwise>
    </xsl:choose>
      <xsl:text>}</xsl:text>
    </xsl:if>
    <!-- in all cases, use sf -->
    <xsl:text>\textsf{</xsl:text>
    <xsl:choose>
      <xsl:when test=".=''">
        <xsl:value-of select="/*[1]/@xml:id"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates/>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:text>}</xsl:text>
  </xsl:template>

  <xsl:template match="db:modifier/db:alt">
    <xsl:text>\textsf{</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>}</xsl:text>
  </xsl:template>

  <xsl:template match="db:productname">
    <xsl:text>\emph{</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>}</xsl:text>
    <xsl:if test="@userlevel">
      <xsl:text>\thinspace(</xsl:text>
      <xsl:value-of select="@userlevel"/>
      <xsl:text>)</xsl:text>
    </xsl:if>
  </xsl:template>

  <xsl:template match="db:citetitle">
    <xsl:text>\emph{</xsl:text>
    <xsl:choose>
      <xsl:when test="@linkend">
        <xsl:apply-templates 
          select="//*[@xml:id=current()/@linkend]/db:title/node()"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates/>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:text>}</xsl:text>
    <xsl:if test="//db:biblioentry[@xml:id=current()/@linkend]">
      <xsl:text> \cite{</xsl:text>
      <xsl:value-of select="@linkend"/>
      <xsl:text>}</xsl:text>
    </xsl:if>
  </xsl:template>

  <xsl:template match="db:emphasis">
    <xsl:text>\emph{</xsl:text>
    <xsl:if test="@role='strong'">
      <xsl:text>\textbf{</xsl:text>
    </xsl:if>
    <xsl:apply-templates/>
    <xsl:if test="@role='strong'">
      <xsl:text>}</xsl:text>
    </xsl:if>
    <xsl:text>}</xsl:text>
  </xsl:template>

  <xsl:template match="db:tag">
    <!-- attribute attvalue element emptytag endtag genentity localname namespace numcharref paramentity pi prefix comment starttag xmlpi -->
    <xsl:if test="@role and
                  not(ancestor::db:title) and 
                  not(ancestor::db:term) and 
                  not(ancestor::db:footnote) and 
                  not(ancestor::db:table) and 
                  not(ancestor::db:informaltable) and 
                  not(ancestor::db:figure)
                  and not(preceding-sibling::db:tag[.=current()/.])">
      <xsl:text>\Describe</xsl:text>
      <xsl:choose>
        <xsl:when test="@class='element' or not(@class)">
          <xsl:text>Element</xsl:text>
        </xsl:when>
        <xsl:when test="@class='attribute'">
          <xsl:text>Attribute</xsl:text>
        </xsl:when>
        <xsl:when test="@class='attvalue'">
          <xsl:text>AttributeValue</xsl:text>
        </xsl:when>
        <xsl:when test="@class='genentity'">
          <xsl:text>Entity</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>Error</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:text>{</xsl:text>
      <xsl:apply-templates/>
      <xsl:text>}</xsl:text>
    </xsl:if>
    <xsl:text>\texttt{</xsl:text>
    <xsl:choose>
      <xsl:when test="@class='attvalue'">
        <xsl:text>"</xsl:text>
      </xsl:when>
      <xsl:when test="@class='genentity'">
        <xsl:text>\&amp;</xsl:text>
      </xsl:when>
    </xsl:choose>
    <xsl:value-of select="."/>
    <xsl:choose>
      <xsl:when test="@class='attvalue'">
        <xsl:text>"</xsl:text>
      </xsl:when>
      <xsl:when test="@class='genentity'">
        <xsl:text>;</xsl:text>
      </xsl:when>
    </xsl:choose>
    <xsl:text>}</xsl:text>
    <xsl:if test="name(following-sibling::node()[1])='' and
                  starts-with(following-sibling::node()[1],'s')">
      <xsl:text>\thinspace{}</xsl:text>
    </xsl:if>
  </xsl:template>

  <xsl:template match="db:function">
    <xsl:text>\DescribeFunction{</xsl:text>
    <xsl:value-of select="."/>
    <xsl:text>}\texttt{</xsl:text>
    <xsl:value-of select="."/>
    <xsl:text>}</xsl:text>
  </xsl:template>

  <xsl:template match="db:errortext">
    <xsl:text>\DescribeError{</xsl:text>
    <xsl:value-of select="."/>
    <xsl:text>}\textsf{</xsl:text>
    <xsl:value-of select="."/>
    <xsl:text>}</xsl:text>
  </xsl:template>

  <xsl:template match="db:type[@role='colour']">
    <xsl:text>\DescribeColour{</xsl:text>
    <xsl:value-of select="."/>
    <xsl:text>}\texttt{</xsl:text>
    <xsl:value-of select="."/>
    <xsl:text>}</xsl:text>
  </xsl:template>

  <xsl:template match="db:methodname">
    <xsl:text>\DescribeTemplate{</xsl:text>
    <xsl:value-of select="."/>
    <xsl:text>}\texttt{</xsl:text>
    <xsl:value-of select="."/>
    <xsl:text>}</xsl:text>
  </xsl:template>

  <xsl:template match="db:code">
    <xsl:text>\texttt{</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>}</xsl:text>
  </xsl:template>

  <xsl:template match="db:option">
    <xsl:if test="@role and
                  not(ancestor::db:title) and 
                  not(ancestor::db:term) and 
                  not(ancestor::db:footnote) and 
                  not(ancestor::db:table) and 
                  not(ancestor::db:informaltable) and 
                  not(ancestor::db:figure)
                  and not(preceding-sibling::db:option[.=current()/.])">
      <xsl:text>\DescribeOption{</xsl:text>
      <xsl:value-of select="."/>
      <xsl:text>}</xsl:text>
    </xsl:if>
    <xsl:choose>
      <xsl:when test="@condition">
        <xsl:text>\oarg{</xsl:text>
        <xsl:value-of select="."/>
        <xsl:text>}</xsl:text>
      </xsl:when>
      <xsl:when test="@conformance">
        <xsl:text>\marg{</xsl:text>
        <xsl:value-of select="."/>
        <xsl:text>}</xsl:text>
      </xsl:when>
      <!-- otherwise it's for a package or command -->
      <xsl:otherwise>
        <xsl:text>\textbf{\texttt{</xsl:text>
        <xsl:if test="@xml:lang='bash'">
          <xsl:text>-</xsl:text>
        </xsl:if>
        <xsl:apply-templates/>
        <xsl:if test="@xml:lang='bash' and not(@conformance='nocolon')">
          <xsl:text>:</xsl:text>
        </xsl:if>
        <xsl:text>}}</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="db:guiicon">
    <xsl:text>\includegraphics</xsl:text>
    <xsl:if test="@annotations">
      <xsl:text>[</xsl:text>
      <xsl:value-of select="@annotations"/>
      <xsl:text>]</xsl:text>
    </xsl:if>
    <xsl:text>{</xsl:text>
    <xsl:value-of select="@xlink:href"/>
    <xsl:text>}</xsl:text>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="db:personname">
    <xsl:apply-templates/>
    <xsl:text>\index{</xsl:text>
    <xsl:value-of select="normalize-space(db:surname)"/>
    <xsl:text>!</xsl:text>
    <xsl:value-of select="normalize-space(db:firstname)"/>
    <xsl:if test="db:othername">
      <xsl:text> </xsl:text>
      <xsl:value-of select="normalize-space(db:othername)"/>
    </xsl:if>
    <xsl:text>}</xsl:text>
  </xsl:template>

  <xsl:template match="db:personname/db:firstname">
    <xsl:value-of select="."/>
  </xsl:template>

  <xsl:template match="db:personname/db:othername">
    <xsl:if test="preceding-sibling::node()!=' '">
      <xsl:text> </xsl:text>
    </xsl:if>
    <xsl:value-of select="."/>
    <xsl:if test="string-length(normalize-space(.))=1 or 
                  (.=upper-case(.) and substring(.,string-length(.))!='.')">
      <xsl:text>.</xsl:text>
    </xsl:if>
  </xsl:template>

  <xsl:template match="db:personname/db:surname">
    <xsl:if test="preceding-sibling::node()!=' '">
      <xsl:text> </xsl:text>
    </xsl:if>
    <xsl:value-of select="."/>
  </xsl:template>

  <xsl:variable name="nosc">
    <xsl:for-each select="$prepost//db:step[@conformance='nosc']">
      <xsl:value-of select="$thisdoc//db:constraintdef
                            [@xml:id='docpackages']
                            //db:seg[.=current()/@remap]"/>
    </xsl:for-each>
  </xsl:variable>

  <xsl:template match="db:acronym">
    <xsl:choose>
      <!-- defining instance -->
      <xsl:when test="@xml:id">
        <xsl:apply-templates/>
        <xsl:text>~(</xsl:text>
        <xsl:call-template name="casestyle">
          <xsl:with-param name="text" select="@xml:id"/>
          <xsl:with-param name="style" select="'\textsc{'"/>
        </xsl:call-template>
        <xsl:text>)\index{</xsl:text>
        <xsl:value-of select="normalize-space(.)"/>
        <xsl:text>|see{</xsl:text>
        <xsl:value-of select="translate(@xml:id,
                              'abcdefghijklmnopqrstuvwxyz',
                              'ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/>
        <xsl:text>}}\index{</xsl:text>
        <xsl:value-of select="translate(@xml:id,
                              'abcdefghijklmnopqrstuvwxyz',
                              'ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/>
        <xsl:text>|textbf}</xsl:text>
      </xsl:when>
      <!-- no ID -->
      <xsl:otherwise>
        <!-- check for missing smallcaps in font -->
        <xsl:choose>
          <xsl:when test="$nosc=''">
            <xsl:call-template name="casestyle">
              <xsl:with-param name="text" select="normalize-space(.)"/>
              <xsl:with-param name="style" select="'\textsc{'"/>
            </xsl:call-template>
          </xsl:when>
          <xsl:otherwise>
            <xsl:call-template name="casestyle">
              <xsl:with-param name="text" select="normalize-space(.)"/>
              <xsl:with-param name="style" select="'{\small '"/>
            </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:if test="//db:acronym[@xml:id=current()/.]">
          <xsl:if test="ancestor::db:footnote">
            <xsl:text>\protect</xsl:text>
          </xsl:if>
          <xsl:text>\index{</xsl:text>
          <xsl:value-of select="normalize-space(.)"/>
          <xsl:text>}</xsl:text>
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="casestyle">
    <xsl:param name="text"/>
    <xsl:param name="style"/>
    <xsl:value-of select="$style"/>
    <xsl:choose>
      <xsl:when test="contains($style,'\textsc')">
        <xsl:value-of select="translate($text,
                              'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
                              'abcdefghijklmnopqrstuvwxyz')"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="translate($text,
                              'abcdefghijklmnopqrstuvwxyz',
                              'ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:text>}</xsl:text>
  </xsl:template>

  <xsl:template match="db:superscript">
    <xsl:text>\textsuperscript{</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>}</xsl:text>
  </xsl:template>

  <xsl:template match="db:exceptionname">
    <xsl:text>\textsc{</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>}</xsl:text>
  </xsl:template>

  <!-- tagging features for the doc and dox packages -->

  <xsl:template match="db:envar">
    <!-- role specifies the command does not belong to this package
         and is only mentioned incidentally -->
    <xsl:if test="@role and 
                  not(ancestor::db:term) and 
                  not(.=ancestor::db:annotation/@xreflabel) and
                  (@xml:lang='TeX' or @xml:lang='LaTeX' or not(@xml:lang))
                  and not(preceding-sibling::db:envar[.=current()/.])">
      <xsl:text>\DescribeEnv{</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>}</xsl:text>
    </xsl:if>
    <xsl:text>\texttt{</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>}</xsl:text>
    <xsl:if test="@condition">
      <xsl:text>\oarg{</xsl:text>
      <xsl:value-of select="normalize-space(@condition)"/>
      <xsl:text>}</xsl:text>
    </xsl:if>
    <xsl:if test="@conformance">
      <xsl:text>\marg{</xsl:text>
      <xsl:value-of select="normalize-space(@conformance)"/>
      <xsl:text>}</xsl:text>
    </xsl:if>
  </xsl:template>

  <xsl:template match="db:classname">
    <xsl:if test="@role and
                  not(ancestor::db:footnote) and
                  not(ancestor::db:title) and
                  not(ancestor::db:term) and 
                  not(.=ancestor::db:annotation/@xreflabel) and
                  (@xml:lang='TeX' or @xml:lang='LaTeX' or not(@xml:lang))
                  and not(preceding-sibling::db:classname[.=current()/.])">
      <xsl:text>\DescribeClass{</xsl:text>
      <xsl:value-of select="."/>
      <xsl:text>}</xsl:text>
    </xsl:if>
    <xsl:text>\textsf{</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>}</xsl:text>
    <xsl:if test="@condition">
      <xsl:text>\oarg{</xsl:text>
      <xsl:value-of select="normalize-space(@condition)"/>
      <xsl:text>}</xsl:text>
    </xsl:if>
    <xsl:if test="@conformance">
      <xsl:text>\marg{</xsl:text>
      <xsl:value-of select="normalize-space(@conformance)"/>
      <xsl:text>}</xsl:text>
    </xsl:if>
  </xsl:template>

  <!-- command occurring in documentation uses \DescribeMacro 
       or whatever class is given in @remap (eg counter, switch,
       length, etc) -->

  <xsl:template match="db:command">
    <!-- role specifies the command does not belong to this package
         and is only mentioned incidentally (a common value is 'kernel')
         and therefore requires no indexing -->
    <xsl:if test="@role and not(.='TeX') and not(.='LaTeX') and
                  not(ancestor::db:term) and 
                  not(.=ancestor::db:annotation/@xreflabel) and
                  (@xml:lang='TeX' or @xml:lang='LaTeX' or not(@xml:lang))
                  and not(preceding-sibling::db:command[.=current()/.])">
      <xsl:text>\DescribeMacro{\</xsl:text>
      <xsl:choose>
        <xsl:when 
          test="@xml:lang='TeX' or @xml:lang='LaTeX' or not(@xml:lang)
                and contains(.,'{')">
          <xsl:value-of select="substring-before(normalize-space(.),'{')"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="normalize-space(.)"/>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:text>}</xsl:text>
    </xsl:if>
    <xsl:choose>
      <!-- fake the backslash when in term (definition list) 
           or when being used as an example (not for indexing) -->
      <xsl:when test="(@xml:lang='TeX' or @xml:lang='LaTeX' or not(@xml:lang))
                      and (not(@role) or parent::db:term)">
        <xsl:if test="parent::db:term and @userlevel!='optional'">
          <xsl:text>\llap{$\star$\enspace}</xsl:text>
        </xsl:if>
        <xsl:choose>
          <xsl:when test="parent::db:term">
            <xsl:text>\texttt{\textbackslash{}</xsl:text>
            <xsl:apply-templates/>
            <xsl:text>}</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:call-template name="avoidverb"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <!-- otherwise use \verb for TeX commands only if needed -->
      <xsl:when test="@xml:lang='TeX' or @xml:lang='LaTeX' or not(@xml:lang)">
        <xsl:call-template name="avoidverb"/>
      </xsl:when>
      <!-- bash -->
      <xsl:when test="@xml:lang='bash'">
        <xsl:call-template name="avoidverb"/>
      </xsl:when>
      <!-- other language commands have no backslash -->
      <xsl:when test="@condition='nolit'">
        <xsl:call-template name="avoidverb"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="avoidverb"/>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:if test="@condition and @condition!='nolit'">
      <xsl:text>\oarg{</xsl:text>
      <xsl:value-of select="normalize-space(@condition)"/>
      <xsl:text>}</xsl:text>
    </xsl:if>
    <xsl:if test="@conformance">
      <xsl:text>\marg{</xsl:text>
      <xsl:value-of select="normalize-space(@conformance)"/>
      <xsl:text>}</xsl:text>
    </xsl:if>
  </xsl:template>

  <xsl:template name="avoidverb">
    <!-- try to output monospace filenames, URIs, etc while
         avoiding the use of \verb -->
    <xsl:variable name="delim">
      <!-- delimiter to use if we really do have to use \verb
           these are in order of preference -->
      <xsl:choose>
        <xsl:when test="not(contains(.,'|'))">
          <xsl:text>|</xsl:text>
        </xsl:when>
        <xsl:when test="not(contains(.,'+'))">
          <xsl:text>+</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>`</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:choose>
      <!-- if the contents contains any of TeX's special characters
           that are invalid or unconfortable in URIs (incl vis.space)
           \$^{}<|>␣ but not &_~#%
           we have to use \verb, reluctantly -->
      <xsl:when test="matches(.,'.*[\\\$\^{}&lt;\|&gt;␣].*')
                      and not(ancestor::db:title)
                      and not(ancestor::db:footnote)
                      and not(ancestor::db:term)">
        <xsl:choose>
          <!-- replaceable adds a ` to end the \verb, and a new \verb`
               after it has emitted its value -->
          <xsl:when test="db:replaceable or @condition='nolit'">
            <xsl:text>\verb</xsl:text>
            <xsl:value-of select="$delim"/>
            <xsl:if 
              test="name()='command' and
                    (@xml:lang='TeX' or @xml:lang='LaTeX' or not(@xml:lang))">
              <xsl:text>\</xsl:text>
            </xsl:if>
            <xsl:apply-templates/>
            <xsl:if test="@xlink:type">
              <xsl:text>.</xsl:text>
              <xsl:value-of select="@xlink:type"/>
            </xsl:if>
            <xsl:value-of select="$delim"/>
          </xsl:when>
          <!-- otherwise this is a plain \verb -->
          <xsl:otherwise>
            <xsl:text>\verb</xsl:text>
            <xsl:value-of select="$delim"/>
            <xsl:if 
              test="name()='command' and
                    (@xml:lang='TeX' or @xml:lang='LaTeX' or not(@xml:lang))">
              <xsl:text>\</xsl:text>
            </xsl:if>
            <xsl:value-of select="normalize-space(.)"/>
            <xsl:if test="@xlink:type">
              <xsl:text>.</xsl:text>
              <xsl:value-of select="@xlink:type"/>
            </xsl:if>
            <xsl:value-of select="$delim"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <!-- not ready for this yet -->
      <xsl:when test="matches(.,'.*[\\\$\^{}&lt;\|&gt;].*')
                      and 
                      (ancestor::db:title or 
                       ancestor::db:footnote or
                       ancestor::db:term)">
        <xsl:message>
          <xsl:text>Warning: verbatim in </xsl:text>
          <xsl:value-of select="name(ancestor::*[3])"/>
          <xsl:text>/</xsl:text>
          <xsl:value-of select="name(ancestor::*[2])"/>
          <xsl:text>/</xsl:text>
          <xsl:value-of select="name(ancestor::*[1])"/>
          <xsl:text> for "</xsl:text>
          <xsl:value-of select="normalize-space(.)"/>
          <xsl:text>"</xsl:text>
        </xsl:message>
        <xsl:text>\url{</xsl:text>
        <xsl:value-of select="normalize-space(.)"/>
        <xsl:text>}</xsl:text>
      </xsl:when>
      <!-- if it's in a , use \url 
      <xsl:when test="contains(normalize-space(.),' ')
                      and not(contains(.'{') or contains(.,'}'))">
        <xsl:text>\url{</xsl:text>
        ???
        <xsl:text>}</xsl:text>
      </xsl:when>
--> 
      <!-- otherwise we can get away with a monospace -->
      <xsl:otherwise>
        <xsl:choose>
          <!-- if it contains the acceptable characters for URIs 
               &_~#% -->
          <xsl:when test="matches(.,'.*[&amp;_~#%].*')
                          and not(db:replaceable or @condition='nolit')">
            <xsl:text>\url{</xsl:text>
            <xsl:value-of select="normalize-space(.)"/>
            <xsl:text>}</xsl:text>
          </xsl:when>
          <!-- replaceable adds a ` to end the \verb, and a new \verb`
               after it has emitted its value -->
          <xsl:when test="db:replaceable or @condition='nolit'">
            <xsl:text>{\ttfamily{}</xsl:text>
            <xsl:if 
              test="name()='command' and
                    (@xml:lang='TeX' or @xml:lang='LaTeX' or not(@xml:lang))">
              <xsl:text>\textbackslash{}</xsl:text>
            </xsl:if>
            <xsl:apply-templates/>
            <xsl:if test="@xlink:type">
              <xsl:text>.</xsl:text>
              <xsl:value-of select="@xlink:type"/>
            </xsl:if>
            <xsl:text>}</xsl:text>
          </xsl:when>
          <!-- otherwise this is a plain -->
          <xsl:otherwise>
            <xsl:text>{\ttfamily{}</xsl:text>
            <xsl:if 
              test="name()='command' and
                    (@xml:lang='TeX' or @xml:lang='LaTeX' or not(@xml:lang))">
              <xsl:text>\textbackslash{}</xsl:text>
            </xsl:if>
            <xsl:value-of select="normalize-space(.)"/>
            <xsl:if test="@xlink:type">
              <xsl:text>.</xsl:text>
              <xsl:value-of select="@xlink:type"/>
            </xsl:if>
            <xsl:text>}</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="db:footnote">
    <xsl:text>\footnote{%&#xa;</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>}</xsl:text>
  </xsl:template>

  <xsl:template match="db:uri">
    <xsl:choose>
      <xsl:when test="@xlink:href and .!=''">
        <xsl:apply-templates/>
        <xsl:text>\footnote{\url{</xsl:text>
        <xsl:value-of select="@xlink:href"/>
        <xsl:text>}}</xsl:text>
      </xsl:when>
      <xsl:when test="not(@xlink:href) and .!=''">
        <xsl:text>\url{</xsl:text>
        <xsl:if test="@type">
          <xsl:value-of select="@type"/>
          <xsl:text>:</xsl:text>
        </xsl:if>
        <xsl:apply-templates/>
        <xsl:text>}</xsl:text>
      </xsl:when>
    </xsl:choose>
    <xsl:if test="@xreflabel and @type='news'">
      <xsl:text> at \textlangle\verb`</xsl:text>
      <xsl:value-of select="@xreflabel"/>
      <xsl:text>`\textrangle{}</xsl:text>
    </xsl:if>
    <!--xsl:if test="following-sibling::node()[1][substring(.,1,1)=',']">
      <xsl:text>\thinspace </xsl:text>
    </xsl:if-->
  </xsl:template>

  <xsl:template match="db:link">
    <xsl:text>{\color{blue}\uline{</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>}}</xsl:text>
  </xsl:template>

  <xsl:template match="db:filename | db:systemitem">
    <xsl:call-template name="avoidverb"/>
  </xsl:template>

  <xsl:template match="db:firstterm">
    <xsl:text>\textbf{\emph{</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>}}\index{</xsl:text>
    <xsl:value-of select="normalize-space(.)"/>
    <xsl:text>|textbf}</xsl:text>
  </xsl:template>

  <xsl:template match="db:foreignphrase">
    <xsl:choose>
      <xsl:when test="@xml:lang='jp'">
        <xsl:text>\cjktext{</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>}</xsl:text>
      </xsl:when>
      <xsl:when test="@xml:lang='ga'">
        <!--        <xsl:text>\texteiad{</xsl:text>-->
        <xsl:text>{</xsl:text>
        <xsl:value-of select="@remap"/>
        <xsl:apply-templates/>
        <xsl:text>}</xsl:text>
      </xsl:when>
      <xsl:when test="@xml:lang!=/db:book/@xml:lang">
        <xsl:text>\foreignlanguage{</xsl:text>
        <xsl:value-of 
          select="tokenize($langs/language[@iso=current()/@xml:lang]/@babel,
                  ' ')[1]"/>
        <xsl:text>}{</xsl:text>
        <xsl:choose>
          <xsl:when 
            test="$langs/language[@iso=current()/@xml:lang]/@wsys='la'">
            <xsl:text>\emph{</xsl:text>
            <xsl:apply-templates/>
            <xsl:text>}</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:apply-templates/>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:text>}</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>\emph{</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>}</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="db:note[not(parent::db:para)]">
    <xsl:text>\begin{Sbox}\begin{minipage}{.9\columnwidth}\sffamily
</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>\end{minipage}\end{Sbox}{\fboxsep1em\centering\fbox{\TheSbox}\par}
</xsl:text>
  </xsl:template>

  <xsl:template match="db:note[parent::db:para]">
    <xsl:text>{\bfseries </xsl:text>
    <xsl:apply-templates/>
    <xsl:text>}</xsl:text>
  </xsl:template>

  <xsl:template match="db:quote | db:phrase | db:wordasword">
    <xsl:text>`</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>'</xsl:text>
    <xsl:if test="@linkend">
      <xsl:text>&#x0a;</xsl:text>
      <xsl:call-template name="makeref"/>
    </xsl:if>
  </xsl:template>

  <xsl:template match="db:email">
    <xsl:text>\url{</xsl:text>
    <xsl:value-of select="."/>
    <xsl:text>}</xsl:text>
  </xsl:template>

  <xsl:template match="db:replaceable">
    <!-- make sure we use the same delimiter as the parent element does -->
    <xsl:variable name="delim">
      <!-- in order of preference -->
      <xsl:choose>
        <xsl:when test="not(contains(.,'|'))">
          <xsl:text>|</xsl:text>
        </xsl:when>
        <xsl:when test="not(contains(.,'+'))">
          <xsl:text>+</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>`</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:choose>
      <!-- stop-start \verb when in a command or systemitem -->
      <xsl:when test="parent::db:command 
                      or parent::db:systemitem
                      or parent::db:filename">
        <xsl:value-of select="$delim"/>
        <xsl:text>{\ttfamily\itshape </xsl:text>
        <xsl:value-of select="normalize-space(.)"/>
        <xsl:text>}</xsl:text>
        <xsl:text>\verb</xsl:text>
        <xsl:value-of select="$delim"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>{\itshape </xsl:text>
        <xsl:value-of select="normalize-space(.)"/>
        <xsl:text>}</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- Counters and Lengths -->

  <xsl:template match="db:varname[not(ancestor::db:footnote)]
                       | db:parameter[not(ancestor::db:footnote)]">
    <xsl:if test="@role 
                  and not(preceding-sibling::db:varname[.=current()/.][@role=current()/@role])">
      <xsl:text>\Describe</xsl:text>
      <xsl:value-of select="translate(substring(@role,1,1),'cl','CL')"/>
      <xsl:value-of select="substring(@role,2)"/>
      <xsl:text>{</xsl:text>
      <xsl:value-of select="normalize-space(.)"/>
      <xsl:text>}</xsl:text>
    </xsl:if>
    <xsl:call-template name="avoidverb"/>
  </xsl:template>

  <xsl:template match="db:varname[ancestor::db:footnote]
                     | db:parameter[ancestor::db:footnote]">
    <xsl:call-template name="avoidverb"/>
  </xsl:template>

  <!-- special use of endterm xref for ref to ref 

  <xsl:template match="db:xref[@endterm]">
    <xsl:choose>
      <xsl:when 
        test="//db:constraintdef[@linkend=current()/@endterm][@remap]">
        <xsl:text>\vref{</xsl:text>
        <xsl:value-of 
          select="//db:constraintdef[@linkend=current()/@endterm]/@remap"/>
        <xsl:text>}</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>[unknown reference to `\texttt{</xsl:text>
        <xsl:value-of select="@endterm"/>
        <xsl:text>}']</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
-->

  <xsl:template match="db:xref[@linkend]">
    <xsl:variable name="target" 
      select="//*[@xml:id=current()/@linkend]"/>
    <!-- catch items in a labelled list before anything else, 
         and give them an ordinal number -->
    <xsl:choose>
      <!-- DESC LIST -->
      <xsl:when test="name($target)='varlistentry'">
        <xsl:text>`\textbf{</xsl:text>
        <xsl:apply-templates select="$target/db:term/node()"/>
        <xsl:text>}', the </xsl:text>
        <xsl:variable name="nth" 
          select="number(count($target/
                  preceding-sibling::db:varlistentry)+1)"/>
        <xsl:choose>
          <xsl:when test="$nth=1">
            <xsl:text>first </xsl:text>
          </xsl:when>
          <xsl:when test="$nth=count($target/
                          ancestor::db:variablelist[1]/db:varlistentry)">
            <xsl:text>last </xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>\ordinal</xsl:text>
            <xsl:if test="$nth &lt; 10">
              <xsl:text>string</xsl:text>
            </xsl:if>
            <xsl:text>num{</xsl:text>
            <xsl:value-of select="$nth"/>
            <xsl:text>} </xsl:text>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:text>item in the list </xsl:text>
        <xsl:if test="not(@xrefstyle='page')">
          <xsl:text>in </xsl:text>
        </xsl:if>
      </xsl:when>
      <!-- UNNUMBERED LIST ITEMS -->
      <xsl:when test="name($target)='listitem' and 
                      name($target/ancestor::*[1])='itemizedlist'">
        <xsl:text>the </xsl:text>
        <xsl:variable name="nth" 
          select="number(count($target/
                  preceding-sibling::db:listitem)+1)"/>
        <xsl:choose>
          <xsl:when test="$nth=1">
            <xsl:text>first </xsl:text>
          </xsl:when>
          <xsl:when test="$nth=count($target/
                          ancestor::db:itemizedlist[1]/db:listitem)">
            <xsl:text>last </xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>\ordinal</xsl:text>
            <xsl:if test="$nth &lt; 10">
              <xsl:text>string</xsl:text>
            </xsl:if>
            <xsl:text>num{</xsl:text>
            <xsl:value-of select="$nth"/>
            <xsl:text>} </xsl:text>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:text>item in the list </xsl:text>
        <xsl:if test="not(@xrefstyle='page')">
          <xsl:text>in </xsl:text>
        </xsl:if>
      </xsl:when>
      <!-- ORDERED LIST ITEMS or PROCEDURE STEPS -->
      <xsl:when test="(local-name($target)='listitem' and 
                      local-name($target/parent::*[1])='orderedlist') or
                      (local-name($target)='step' and 
                      local-name($target/parent::*[1])='procedure')">
        <xsl:choose>
          <xsl:when test="ancestor::procedure">
            <xsl:text>step</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>item</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:text>~\ref{</xsl:text>
        <xsl:value-of select="@linkend"/>
        <xsl:text>}</xsl:text>
        <xsl:choose>
          <xsl:when test="generate-id(ancestor::db:procedure)=
                          generate-id($target/parent::db:procedure)">
            <xsl:choose>
              <xsl:when 
                test="count(preceding::* | $target)=count(preceding::*)">
                <xsl:text> above</xsl:text>
              </xsl:when>
              <xsl:otherwise>
                <xsl:text> below</xsl:text>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text> in the list on p.\thinspace\pageref{</xsl:text>
            <xsl:value-of select="@linkend"/>
            <xsl:text>}</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when> 
      <!-- TITLED ORDERED LISTS -->
      <xsl:when test="local-name($target)='orderedlist' and $target/db:title">
        <xsl:text>the list `</xsl:text>
        <xsl:apply-templates select="$target/db:title/node()"/>
        <xsl:text>' in </xsl:text>
      </xsl:when>
      <!-- INFORMAL TABLES -->
      <xsl:when test="local-name($target)='informaltable'">
        <xsl:text>the table </xsl:text>
      </xsl:when>
      <!-- PROGRAMLISTING with condition="ignore" in package code -->
      <xsl:when test="local-name($target)='programlisting'">
        <xsl:text>the code example </xsl:text>
      </xsl:when>
    </xsl:choose>
    <!-- AUTOMATED -->
    <xsl:choose>
      <xsl:when test="@xrefstyle='page' 
                      or local-name($target)='informaltable'
                      or local-name($target)='programlisting'">
        <xsl:text>\vpageref</xsl:text>
      </xsl:when>
      <!-- omit numbered list items done manually above -->
      <xsl:when test="(local-name($target)='listitem' and 
                       local-name($target/ancestor::*[1])='orderedlist') 
                      or
                      (ancestor::db:procedure and
                       generate-id(ancestor::db:procedure)=
                       generate-id($target/parent::db:procedure))">
        <xsl:text></xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>\vref</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
    <!-- now the argument[s]: not wanted for list items done manually -->
    <xsl:if test="not(local-name($target)='listitem' and
                      local-name($target/ancestor::*[1])='orderedlist') 
                  and
                  not(ancestor::db:procedure and $target/parent::db:procedure)">
      <xsl:if test="@endterm">
        <xsl:text>range</xsl:text>
      </xsl:if>
      <xsl:text>{</xsl:text>
      <xsl:value-of select="@linkend"/>
      <xsl:text>}</xsl:text>
      <xsl:if test="@endterm">
        <xsl:text>{</xsl:text>
        <xsl:value-of select="@endterm"/>
        <xsl:text>}</xsl:text>
      </xsl:if>
    </xsl:if>
    <xsl:if test="@xreflabel">
      <xsl:text> (</xsl:text>
      <xsl:apply-templates 
        select="$target/child::*[local-name()=current()/@xreflabel][1]/node()"/>
      <xsl:text>)</xsl:text>
    </xsl:if>
  </xsl:template>

  <!-- gui menu stuff -->

  <xsl:template match="db:guimenu">
    <xsl:text>\textsf{\bfseries </xsl:text>
    <xsl:apply-templates/>
    <xsl:text>}</xsl:text>
  </xsl:template>

  <xsl:template match="db:guisubmenu">
    <xsl:if test="starts-with(local-name(preceding-sibling::*[1]),'gui')">
      <xsl:text>\menusep</xsl:text>
    </xsl:if>
    <xsl:text>\textsf{</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>}</xsl:text>
  </xsl:template>

  <xsl:template match="db:guimenuitem">
    <xsl:if test="starts-with(local-name(preceding-sibling::*[1]),'gui')">
      <xsl:text>\menusep</xsl:text>
    </xsl:if>
    <xsl:text>\textsf{\itshape </xsl:text>
    <xsl:apply-templates/>
    <xsl:text>}</xsl:text>
  </xsl:template>

  <xsl:template match="db:guilabel">
    <xsl:text>{\fboxsep2pt\fbox{\sffamily </xsl:text>
    <xsl:apply-templates/>
    <xsl:text>}}</xsl:text>
  </xsl:template>

  <xsl:template match="db:guibutton">
    <xsl:text>{\fboxsep2pt\ovalbox{\sffamily </xsl:text>
    <xsl:apply-templates/>
    <xsl:text>}}</xsl:text>
  </xsl:template>

  <!-- odds 'n' sods -->

  <xsl:template match="processing-instruction('LaTeX')">
    <xsl:value-of select="."/>
  </xsl:template>

  <xsl:template match="db:varlistentry | 
                       db:varlistentry/db:listitem | 
                       db:authorgroup">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="*">
    <xsl:message>
      <xsl:text>default: </xsl:text>
      <xsl:value-of select="local-name()"/>
      <xsl:text> ("</xsl:text>
      <xsl:value-of select="."/>
      <xsl:text>")</xsl:text>
    </xsl:message>
    <xsl:apply-templates/>
  </xsl:template>

  <!-- bib -->

  <xsl:template match="db:biblioref">
    <xsl:call-template name="makeref"/>
  </xsl:template>

  <xsl:template name="makeref">
    <xsl:variable name="target" 
      select="//db:bibliography/db:biblioentry[@xml:id=current()/@linkend]"/>
    <xsl:choose>
      <!-- title only -->
      <xsl:when test="@xrefstyle='title'">
        <xsl:choose>
          <xsl:when test="$target/@xreflabel='article' or 
                          $target/@xreflabel='inbook' or 
                          $target/@xreflabel='incollection'">
            <xsl:text>`</xsl:text>
            <xsl:apply-templates 
              select="($target/descendant::db:title)[1]/node()"/>
            <xsl:text>'</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>\emph{</xsl:text>
            <xsl:apply-templates 
              select="($target/descendant::db:title)[1]/node()"/>
            <xsl:text>}</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <!-- author only -->
      <xsl:when test="@xrefstyle='author'">
        <xsl:for-each select="$target//db:author[1]/db:personname">
          <xsl:value-of select="db:firstname"/>
          <xsl:if test="db:othername">
            <xsl:text>&#x0a;</xsl:text>
            <xsl:value-of select="db:othername"/>
          </xsl:if>
          <xsl:text> </xsl:text>
          <xsl:value-of select="db:surname"/>
        </xsl:for-each>
      </xsl:when>
      <!-- author only -->
      <xsl:when test="@xrefstyle='shortauthor'">
        <xsl:for-each select="$target//db:author[1]/db:personname">
          <xsl:value-of select="db:surname"/>
        </xsl:for-each>
      </xsl:when>
      <!-- all the rest -->
      <xsl:otherwise>
        <xsl:text>\cite</xsl:text>
        <xsl:if test="(@units and @begin) or @annotations">
          <xsl:text>[</xsl:text>
          <xsl:value-of select="@units"/>
          <xsl:if test="@units='p' and @end">
            <xsl:text>p</xsl:text>
          </xsl:if>
          <xsl:text>.\thinspace </xsl:text>
          <xsl:value-of select="@begin"/>
          <xsl:if test="@end">
            <xsl:text>--</xsl:text>
            <xsl:value-of select="@end"/>
          </xsl:if>
          <xsl:if test="@annotations">
            <xsl:if test="@units and @begin">
              <xsl:text>, </xsl:text>
            </xsl:if>
            <xsl:value-of select="normalize-space(@annotations)"/>
          </xsl:if>
          <xsl:text>]</xsl:text>
        </xsl:if>
        <xsl:text>{</xsl:text>
        <xsl:value-of select="@linkend"/>
        <xsl:text>}</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- utilities -->

  <xsl:template name="copyright-statement">
    <xsl:param name="ftype"/>
    <xsl:text>% Extracted from </xsl:text>
    <xsl:value-of select="$name"/>
    <xsl:text>.xml</xsl:text>
    <xsl:text>
% </xsl:text>
    <xsl:value-of select="$name"/>
    <xsl:text>.</xsl:text>
    <xsl:value-of select="$ftype"/>
    <xsl:text> is copyright © </xsl:text>
    <xsl:variable name="copyright-first">
      <xsl:for-each select="//db:info/db:revhistory/db:revision">
        <xsl:sort select="@version" order="descending"/>
        <xsl:if test="position()=last()">
          <xsl:value-of 
            select="substring(db:date/@conformance,1,4)"/>
        </xsl:if>
      </xsl:for-each>
    </xsl:variable>
    <xsl:value-of select="$copyright-first"/>
    <xsl:variable name="copyright-latest">
      <xsl:for-each select="//db:info/db:revhistory/db:revision">
        <xsl:sort select="@version" order="ascending"/>
        <xsl:if test="position()=last()">
          <xsl:value-of 
            select="substring(db:date/@conformance,1,4)"/>
        </xsl:if>
      </xsl:for-each>
    </xsl:variable>
    <xsl:if test="$copyright-latest > $copyright-first">
      <xsl:text>-</xsl:text>
      <xsl:value-of select="$copyright-latest"/>
    </xsl:if>
    <xsl:text> by </xsl:text>
    <!-- RIGHTS -->
    <xsl:choose>
      <xsl:when test="/db:book/@audience='lppl'">
        <xsl:value-of 
          select="normalize-space(//db:info//db:author[1]/
                  db:personname/db:firstname)"/>
        <xsl:text> </xsl:text>
        <xsl:value-of 
          select="normalize-space(//db:info//db:author[1]/
                  db:personname/db:surname)"/>
        <xsl:text> &lt;</xsl:text>
        <xsl:value-of select="//db:info//db:author[1]/db:email"/>
        <xsl:text>>&#xa;</xsl:text>
        <xsl:text>%
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, either
% version 1.3 of this license or (at your option) any later
% version. The latest version of this license is in:
%
%     http://www.latex-project.org/lppl.txt
%
% and version 1.3 or later is part of all distributions of
% LaTeX version 2005/12/01 or later.
%
% This work has the LPPL maintenance status `maintained'.
% &#xa;</xsl:text>        
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of 
          select="normalize-space(//db:info/db:copyright/db:holder)"/>
        <xsl:text> &lt;</xsl:text>
        <xsl:value-of 
          select="substring-after(//db:info/db:copyright/db:holder
                  /@xlink:href,'mailto:')"/>
        <xsl:text>>&#xa;</xsl:text>
        <xsl:text>%
% This work may not be copied or re-used without the express
% written permission of the copyright holder[s]. Access to this
% work is restricted to the copyright holder[s] and their
% authorised employees, contractors, or agents.
% &#xa;</xsl:text>        
      </xsl:otherwise>
    </xsl:choose>
    <xsl:text>% The current maintainer of this work is </xsl:text>
    <xsl:choose>
      <xsl:when test="//db:info//db:author[@role='maintainer']">
        <xsl:for-each select="//db:info//db:author[@role='maintainer']">
          <xsl:value-of 
            select="normalize-space(db:personname/db:firstname)"/>
          <xsl:text> </xsl:text>
          <xsl:value-of 
            select="normalize-space(db:personname/db:surname)"/>
          <xsl:text> &lt;</xsl:text>
          <xsl:value-of select="db:email"/>
        </xsl:for-each>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of 
          select="normalize-space(//db:info//db:author/db:personname/db:firstname)"/>
        <xsl:text> </xsl:text>
        <xsl:value-of 
          select="normalize-space(//db:info//db:author/db:personname/db:surname)"/>
        <xsl:text> &lt;</xsl:text>
        <xsl:value-of select="//db:info//db:author/db:email"/>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:text>>&#xa;</xsl:text>
    <xsl:text>%
% This work consists of the files </xsl:text>
    <xsl:value-of select="$name"/>
    <xsl:text>.dtx and </xsl:text>
    <xsl:value-of select="$name"/>
    <xsl:text>.ins,
% the derived file </xsl:text>
    <xsl:value-of select="$name"/>
    <xsl:text>.</xsl:text>
    <xsl:value-of select="$filetype"/>
    <xsl:text>, and any ancillary files listed
% in the MANIFEST.&#xa;</xsl:text>
  </xsl:template>

  <xsl:template name="repeatarg">
    <xsl:param name="limit"/>
    <xsl:param name="count">
      <xsl:text>0</xsl:text>
    </xsl:param>
    <xsl:param name="prefix"/>
    <xsl:param name="suffix"/>
    <xsl:if test="$count&lt;$limit">
      <xsl:value-of select="$prefix"/>
      <xsl:text>#</xsl:text>
      <xsl:value-of select="$count + 1"/>
      <xsl:value-of select="$suffix"/>
      <xsl:call-template name="repeatarg">
        <xsl:with-param name="limit" select="$limit"/>
        <xsl:with-param name="count" select="$count + 1"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <!-- special mode for outputting the .ins file -->

  <xsl:template match="db:info" mode="ins">
    <xsl:variable name="file">
      <xsl:value-of select="$name"/>
      <xsl:text>.ins</xsl:text>
    </xsl:variable>
    <xsl:result-document format="textFormat" href="{$file}">
      <xsl:text>%</xsl:text>
      <xsl:call-template name="copyright-statement">
        <xsl:with-param name="ftype">
          <xsl:text>ins</xsl:text>
        </xsl:with-param>
      </xsl:call-template>
      <xsl:text>%
\input docstrip.tex
\keepsilent
\usedir{tex/latex/</xsl:text>
        <xsl:value-of select="/db:book/@xml:base"/>
        <xsl:text>}
\preamble&#xa;</xsl:text>
        <xsl:call-template name="htrim">
          <xsl:with-param name="text">
            <xsl:call-template name="lrtrim">
              <xsl:with-param name="text" select="db:annotation/*"/>
            </xsl:call-template>
          </xsl:with-param>
        </xsl:call-template>
        <xsl:text>&#xa;\endpreamble&#xa;</xsl:text>
        <!-- this bit just doesn't seem to work right
        <xsl:for-each select="/db:book/db:part[@xml:id='files']
                              /db:chapter[db:programlisting]">
          <xsl:variable name="ext" 
            select="substring-after(db:programlisting/@xlink:href,'.')"/>
          <xsl:text>\declarepreamble\</xsl:text>
          <xsl:value-of select="@xml:id"/>
          <xsl:text>
\DoubleperCent\space This is file </xsl:text>
          <xsl:value-of select="db:programlisting/@xlink:href"/>
          <xsl:text>&#xa;\endpreamble&#xa;</xsl:text>
          <xsl:text>\declarepostamble\</xsl:text>
          <xsl:value-of select="@xml:id"/>
          <xsl:text>
\DoubleperCent\space End of file </xsl:text>
          <xsl:value-of select="db:programlisting/@xlink:href"/>
          <xsl:text>&#xa;\endpreamble&#xa;</xsl:text>
        </xsl:for-each>
        -->
        <xsl:text>\generate{</xsl:text>
        <!-- generate the main file first -->
        <xsl:text>\file{</xsl:text>
        <xsl:value-of select="$name"/>
        <xsl:text>.</xsl:text>
        <xsl:value-of select="$filetype"/>
        <xsl:text>}{\from{</xsl:text>
        <xsl:value-of select="$name"/>
        <xsl:text>.dtx}{</xsl:text>
        <xsl:value-of select="$doctype"/>
        <xsl:text>}}%&#xa;</xsl:text>
        <!-- add any fragments from the documentation 
             these are those with an ID, a href, *and* show='new' -->
        <xsl:for-each 
          select="//db:programlisting
                  [@xml:id and @xlink:show='new' and @xlink:href]">
          <xsl:variable name="ext" select="substring-after(@xlink:href,'.')"/>
          <xsl:choose>
            <xsl:when test="$ext='tex'">
              <xsl:text>          \usepreamble\</xsl:text>
              <xsl:value-of select="@xml:id"/>
              <xsl:text>preamble\usepostamble\</xsl:text>
              <xsl:value-of select="@xml:id"/>
              <xsl:text>postamble</xsl:text>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>          \usepreamble\empty\usepostamble\empty</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
          <xsl:text>&#xa;          \file{</xsl:text>
          <xsl:value-of select="@xlink:href"/>
          <xsl:text>}{\from{</xsl:text>
          <xsl:value-of select="$name"/>
          <xsl:text>.dtx}{</xsl:text>
          <xsl:value-of select="@xml:id"/>
          <xsl:text>}}%&#xa;</xsl:text>
        </xsl:for-each>
        <!-- add any documented ancillary files from appendixes
             in the code part -->
        <xsl:for-each select="/db:book/db:part[@xml:id='code']
                              /db:appendix[@xml:id and @xlink:href]">
          <xsl:variable name="ext" select="substring-after(@xlink:href,'.')"/>
          <xsl:choose>
            <xsl:when test="$ext='tex'">
              <xsl:text>          \usepreamble\</xsl:text>
              <xsl:value-of select="@xml:id"/>
              <xsl:text>preamble\usepostamble\</xsl:text>
              <xsl:value-of select="@xml:id"/>
              <xsl:text>postamble</xsl:text>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text></xsl:text>
            </xsl:otherwise>
          </xsl:choose>
          <xsl:text>          \file{</xsl:text>
          <xsl:value-of select="@xlink:href"/>
          <xsl:text>}{\from{</xsl:text>
          <xsl:value-of select="$name"/>
          <xsl:text>.dtx}{</xsl:text>
          <xsl:value-of select="@xml:id"/>
          <xsl:text>}}%&#xa;</xsl:text>
        </xsl:for-each>
        <!-- add any undocumented ancillary files -->
        <xsl:for-each select="/db:book/db:part[@xml:id='files']
                              /db:chapter[db:programlisting]">
          <xsl:variable name="ext" 
            select="substring-after(db:programlisting/@xlink:href,'.')"/>
          <xsl:choose>
            <xsl:when test="$ext='tex'">
              <xsl:text>          \usepreamble\</xsl:text>
              <xsl:value-of select="@xml:id"/>
              <xsl:text>preamble\usepostamble\</xsl:text>
              <xsl:value-of select="@xml:id"/>
              <xsl:text>postamble</xsl:text>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>          \usepreamble\empty\usepostamble\empty</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
          <xsl:text>&#xa;          \file{</xsl:text>
          <xsl:value-of select="db:programlisting/@xlink:href"/>
          <xsl:text>}{\from{</xsl:text>
          <xsl:value-of select="$name"/>
          <xsl:text>.dtx}{</xsl:text>
          <xsl:value-of select="@xml:id"/>
          <xsl:text>}}%&#xa;</xsl:text>
        </xsl:for-each>
        <xsl:text>}
\obeyspaces
\Msg{********************************************************}
\Msg{**                                                    **}
\Msg{** Read the documentation before using this </xsl:text>
        <xsl:value-of select="$doctype"/>
        <xsl:if test="$doctype='class'">
          <xsl:text>  </xsl:text>
        </xsl:if>
        <xsl:text>.  **}
\Msg{**                                                    **}
\Msg{********************************************************}
\endbatchfile
</xsl:text>
    </xsl:result-document>
  </xsl:template>

  <xsl:template match="text()">
    <xsl:choose>
      <!-- SPECIAL HANDLING FOR SHELL SCRIPTS -->
      <xsl:when test="ancestor::db:programlisting[@language='bash']">
        <xsl:choose>
          <!-- remove leading newlines from initial strings -->
          <xsl:when test="count(preceding-sibling::text())=0
                          and starts-with(.,'&#xa;')">
            <xsl:value-of select="substring(.,2)"/>
          </xsl:when>
          <!-- remove trailing space from terminals -->
          <xsl:when test="count(following-sibling::text())=0
                          and matches(.,'\n[\s]*$')">
            <xsl:value-of select="replace(.,'\n[\s]*$','')"/>
          </xsl:when>
          <!-- otherwise don't prefix or suffix -->
          <xsl:otherwise>
            <xsl:value-of select="."/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <!-- SIMILAR FOR TEXT OF INLINE COMMANDS (and bibliography entries
           being handled by db2bibtex.xsl): normalise spaces 
           but preserve one leading and one trailing space if given -->
      <xsl:when test="ancestor::db:command or ancestor::db:biblioentry">
        <!-- replace a single leading WS token with a space -->
        <xsl:if test="starts-with(.,' ') or 
                      starts-with(.,'&#x9;') or 
                      starts-with(.,'&#xa;')">
          <xsl:text> </xsl:text>
        </xsl:if>
        <xsl:value-of select="normalize-space(.)"/>
        <!-- replace a single trailing WS token with a space -->
        <xsl:if test="substring(.,string-length(.))=' ' or
                      substring(.,string-length(.))='&#x9;' or
                      substring(.,string-length(.))='&#xa;'">
          <xsl:text> </xsl:text>
        </xsl:if>
      </xsl:when>
      <!-- otherwise check for percent prefixes -->
      <xsl:otherwise>
        <xsl:call-template name="dtxtext">
          <xsl:with-param name="text" select="."/>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="dtxtext">
    <xsl:param name="text"/>
    <xsl:choose>
      <xsl:when test="normalize-space(.)=''">
        <xsl:text></xsl:text>
      </xsl:when>
      <!-- if the span starts with a TAB, remove it,
           and keep doing so until no more TABs -->
      <xsl:when test="starts-with($text,'&#x9;')">
        <xsl:call-template name="dtxtext">
          <xsl:with-param name="text" 
            select="substring($text,2)"/>
        </xsl:call-template>
      </xsl:when>
      <!-- if it starts with a newline AND it's in a <programlisting>
           element AND this is the first span of its type, prefix 
           a percent -->
      <xsl:when test="starts-with($text,'&#xa;') and 
                      parent::db:programlisting and 
                      count(preceding-sibling::text())=0">
        <xsl:text>% </xsl:text>
        <xsl:call-template name="dtxtext">
          <xsl:with-param name="text" 
            select="substring($text,2)"/>
        </xsl:call-template>
      </xsl:when>
      <!-- break strings containing newlines -->
      <xsl:when test="contains($text,'&#xa;')">
        <xsl:value-of select="substring-before($text,'&#xa;')"/>
        <xsl:choose>
          <xsl:when 
            test="normalize-space(substring-after($text,'&#xa;'))='' and
                  parent::db:programlisting and 
                  count(following-sibling::text())=0">
            <xsl:text></xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>&#xa;% </xsl:text>
            <xsl:call-template name="dtxtext">
              <xsl:with-param name="text" 
                select="substring-after($text,'&#xa;')"/>
            </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <!-- convert underscores in filenames -->
      <xsl:when test="ancestor::db:filename[db:replaceable] and
                      contains($text,'_')">
        <xsl:value-of select="substring-before($text,'_')"/>
        <xsl:text>\_</xsl:text>
        <xsl:call-template name="dtxtext">
          <xsl:with-param name="text" 
            select="substring-after($text,'_')"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$text"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="build">
    <xsl:result-document format="textFormat" href="build">
      <xsl:text>#! /bin/bash
#
# Bourne shell script to build the </xsl:text>
      <xsl:value-of select="$name"/>
      <xsl:text> </xsl:text>
      <xsl:value-of select="$doctype"/>
      <xsl:text> file and documentation
#
java -jar </xsl:text>
      <xsl:value-of select="$processor"/>
      <xsl:text> -o:</xsl:text>
      <xsl:value-of select="$name"/>
      <xsl:text>.dtx </xsl:text>
      <xsl:value-of select="$name"/>
      <xsl:text>.xml </xsl:text>
      <xsl:value-of select="$cpdir"/>
      <xsl:text>/db2dtx.xsl processor=</xsl:text>
      <xsl:value-of select="$processor"/>
      <xsl:text> cpdir=</xsl:text>
      <xsl:value-of select="$cpdir"/>
      <xsl:text> appdir=</xsl:text>
      <xsl:value-of select="$appdir"/>
      <xsl:text>
yes|pdflatex </xsl:text>
      <xsl:value-of select="$name"/>
      <xsl:text>.ins
pdflatex </xsl:text>
      <xsl:value-of select="$name"/>
      <xsl:text>.dtx&#xa;</xsl:text>
      <xsl:if test="//db:part[descendant::db:bibliography 
                    and descendant::db:biblioref]">
        <xsl:text>bibtex </xsl:text>
        <xsl:value-of select="$name"/>
        <xsl:text>&#xa;awk -f </xsl:text>
        <xsl:value-of select="$cpdir"/>
        <xsl:text>/decommentbbl.awk </xsl:text>
        <xsl:value-of select="$name"/>
        <xsl:text>.bbl ></xsl:text>
        <xsl:value-of select="$name"/>
        <xsl:text>.bdc&#xa;mv </xsl:text>
        <xsl:value-of select="$name"/>
        <xsl:text>.bdc </xsl:text>
        <xsl:value-of select="$name"/>
        <xsl:text>.bbl&#xa;pdflatex </xsl:text>
        <xsl:value-of select="$name"/>
        <xsl:text>.dtx&#xa;</xsl:text>
      </xsl:if>
      <xsl:text>makeindex -s gind.ist -o </xsl:text>
      <xsl:value-of select="$name"/>
      <xsl:text>.ind </xsl:text>
      <xsl:value-of select="$name"/>
      <xsl:text>.idx
makeindex -s gglo.ist -o </xsl:text>
      <xsl:value-of select="$name"/>
      <xsl:text>.gls </xsl:text>
      <xsl:value-of select="$name"/>
      <xsl:text>.glo
pdflatex </xsl:text>
      <xsl:value-of select="$name"/>
      <xsl:text>.dtx&#xa;</xsl:text>
      <!-- additional processing steps -->
      <xsl:for-each select="/db:book/db:info/db:cover
                            /db:constraintdef[@xml:id='builder']
                            /db:segmentedlist/db:seglistitem/db:seg">
        <!-- 1. Content is the command including any fixed parameters 
             which immediately follow it, but not usually arguments -->
        <xsl:value-of select="normalize-space(.)"/>
        <!-- 1a. alternative way for a -f argument -->
        <xsl:if test="@xlink:show='replace'">
          <xsl:text> -f</xsl:text>
        </xsl:if>
        <!-- 1b. output spec with a -o option -->
        <xsl:if test="@role">
          <xsl:text> -o </xsl:text>
          <xsl:choose>
            <xsl:when test="@audience">
              <xsl:value-of select="@audience"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="$name"/>
            </xsl:otherwise>
          </xsl:choose>
          <xsl:text>.</xsl:text>
          <xsl:value-of select="@role"/>
        </xsl:if>
        <!-- 2. space between command and args -->
        <xsl:text> </xsl:text>
        <!-- 3. input default file is the name of the current document -->
        <xsl:choose>
          <xsl:when test="@audience">
            <xsl:value-of select="@audience"/>
          </xsl:when>
          <xsl:when test="@xlink:actuate!='none'">
            <xsl:value-of select="$name"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text></xsl:text>
          </xsl:otherwise>
        </xsl:choose>
        <!-- filetype of the input file -->
        <xsl:choose>
          <!-- either with xlink:type -->
          <xsl:when test="@xlink:type">
            <xsl:text>.</xsl:text>
            <xsl:value-of select="@xlink:type"/>
          </xsl:when>
          <!-- default for the first one is the current (dtx) -->
          <xsl:when test="position()=1">
            <xsl:text>.dtx</xsl:text>
          </xsl:when>
          <!-- otherwise it's the @role of the preceding command -->
          <xsl:when test="parent::db:seglistitem
                          /preceding-sibling::db:seglistitem[1]
                          /db:seg[@role]">
            <xsl:text>.</xsl:text>
            <xsl:value-of 
              select="parent::db:seglistitem
                      /preceding-sibling::db:seglistitem[1]
                      /db:seg/@role"/>
          </xsl:when>
          <!-- otherwise nothing -->
        </xsl:choose>
        <!-- 4. Output: optionally a redirect -->
        <xsl:if test="@xlink:arcrole">
          <xsl:text> ></xsl:text>
          <xsl:value-of select="@xlink:arcrole"/>
        </xsl:if>
        <!-- 5. newline at end -->
        <xsl:text>&#xa;</xsl:text>
      </xsl:for-each>
      <xsl:text>echo Copying files into dev tree...&#xa;</xsl:text>
      <!-- copy all the files into the dev tree for zipping 
           doc/latex/name/MANIFEST|README|.pdf
           source/latex/name/.dtx|.ins
           tex/latex/name/.cls|.sty
           -->
      <xsl:text>mkdir -p doc/latex/</xsl:text>
      <xsl:value-of select="/db:book/@xml:base"/>
      <xsl:text>&#xa;</xsl:text>
      <xsl:text>mkdir -p source/latex/</xsl:text>
      <xsl:value-of select="/db:book/@xml:base"/>
      <xsl:text>&#xa;</xsl:text>
      <xsl:text>mkdir -p tex/latex/</xsl:text>
      <xsl:value-of select="/db:book/@xml:base"/>
      <xsl:text>&#xa;</xsl:text>
      <!-- first the documentation -->
      <xsl:text>cp README MANIFEST </xsl:text>
      <xsl:value-of select="$name"/>
      <xsl:text>.pdf </xsl:text>
      <xsl:text>doc/latex/</xsl:text>
      <xsl:value-of select="/db:book/@xml:base"/>
      <xsl:text>&#xa;</xsl:text>
      <!-- then the source code -->
      <xsl:text>cp </xsl:text>
      <xsl:value-of select="$name"/>
      <xsl:text>.dtx </xsl:text>
      <xsl:value-of select="$name"/>
      <xsl:text>.ins </xsl:text>
      <xsl:text>source/latex/</xsl:text>
      <xsl:value-of select="/db:book/@xml:base"/>
      <xsl:text>&#xa;</xsl:text>
      <!-- then this class or package -->
      <xsl:text>cp </xsl:text>
      <xsl:value-of select="$name"/>
      <xsl:text>.</xsl:text>
      <xsl:value-of select="$filetype"/>
      <xsl:text> </xsl:text>
      <xsl:text>tex/latex/</xsl:text>
      <xsl:value-of select="/db:book/@xml:base"/>
      <xsl:text>&#xa;</xsl:text>
      <!-- add any ancillary files extracted from the .dtx file -->
      <xsl:for-each select="/db:book/db:part[@xml:id='code']
                            /db:appendix[@xml:id and @xlink:href]
                            |
                            /db:book/db:part[@xml:id='files']
                            /db:chapter/db:programlisting">
        <xsl:text>cp </xsl:text>
        <xsl:value-of select="@xlink:href"/>
        <xsl:text> </xsl:text>
        <xsl:text>tex/latex/</xsl:text>
        <xsl:value-of select="/db:book/@xml:base"/>
        <xsl:text>&#xa;</xsl:text>
      </xsl:for-each>
      <!-- add any extra files listed in the .xml file -->
      <xsl:for-each select="/db:book/db:info/db:cover
                            /db:constraintdef[@xml:id='manifest']
                            /db:simplelist/db:member[.!='']">
        <xsl:text>cp </xsl:text>
        <xsl:value-of select="normalize-space(.)"/>
        <xsl:text> </xsl:text>
        <xsl:text>source/latex/</xsl:text>
        <xsl:value-of select="/db:book/@xml:base"/>
        <xsl:text>&#xa;</xsl:text>
      </xsl:for-each>
      <!-- ZIP 'EM UP from the dev directory -->
      <xsl:text>echo Zipping up files from dev tree...&#xa;</xsl:text>
      <xsl:text>zip -r --exclude=*.svn* --exclude=*.DS_Store* </xsl:text>
      <xsl:value-of select="$name"/>
      <xsl:text>-</xsl:text>
      <xsl:value-of select="/db:book/@version"/>
      <xsl:text>.</xsl:text>
      <xsl:value-of select="/db:book/@revision"/>
      <xsl:text>.tds.zip doc/latex/</xsl:text>
      <xsl:value-of select="/db:book/@xml:base"/>
      <xsl:text> source/latex/</xsl:text>
      <xsl:value-of select="/db:book/@xml:base"/>
      <xsl:text> tex/latex/</xsl:text>
      <xsl:value-of select="/db:book/@xml:base"/>
      <xsl:text>&#xa;</xsl:text>
      <xsl:text>echo Zipping up plain CTAN version...&#xa;</xsl:text>
      <xsl:text>zip </xsl:text>
      <xsl:value-of select="$name"/>
      <xsl:text>-</xsl:text>
      <xsl:value-of select="/db:book/@version"/>
      <xsl:text>.</xsl:text>
      <xsl:value-of select="/db:book/@revision"/>
      <xsl:text>.zip README MANIFEST </xsl:text>
      <xsl:value-of select="/db:book/@xml:id"/>
      <xsl:text>.dtx </xsl:text>
      <xsl:value-of select="/db:book/@xml:id"/>
      <xsl:text>.ins </xsl:text>
      <xsl:value-of select="/db:book/@xml:id"/>
      <xsl:text>.pdf </xsl:text>
      <xsl:value-of select="/db:book/@xml:id"/>
      <xsl:text>.</xsl:text>
      <xsl:value-of select="$filetype"/>
      <xsl:for-each select="/db:book/db:info/db:cover
                            /db:constraintdef[@xml:id='manifest']
                            /db:simplelist/db:member[.!='']">
        <xsl:text> </xsl:text>
        <xsl:value-of select="normalize-space(.)"/>
      </xsl:for-each>
      <xsl:text> </xsl:text>
      <xsl:value-of select="$name"/>
      <xsl:text>-</xsl:text>
      <xsl:value-of select="/db:book/@version"/>
      <xsl:text>.</xsl:text>
      <xsl:value-of select="/db:book/@revision"/>
      <xsl:text>.tds.zip&#xa;</xsl:text>
      <!-- INSTALL the package or class file into the live tree -->
      <xsl:text>echo Installing working copy...&#xa;</xsl:text>
      <xsl:text>unzip -o -d </xsl:text>
      <xsl:value-of select="$personaltree"/>
      <xsl:text> </xsl:text>
      <xsl:value-of select="$name"/>
      <xsl:text>-</xsl:text>
      <xsl:value-of select="/db:book/@version"/>
      <xsl:text>.</xsl:text>
      <xsl:value-of select="/db:book/@revision"/>
      <xsl:text>.tds.zip&#xa;</xsl:text>
    </xsl:result-document>
  </xsl:template>

  <xsl:template match="db:part/db:title | 
                       db:chapter/db:title |
                       db:chapter/db:para" mode="files"/>

  <xsl:template match="db:chapter" mode="files">
    <xsl:apply-templates mode="files"/>
  </xsl:template>

  <xsl:template match="db:programlisting" mode="files">
    <xsl:choose>
      <xsl:when test="ancestor::db:part[@xml:id='files']">
        <xsl:text>% \iffalse&#xa;</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>%    \begin{macrocode}&#xa;</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:text>%&lt;*</xsl:text>
    <xsl:value-of select="parent::db:chapter/@xml:id"/>
    <xsl:text>></xsl:text>
    <xsl:value-of select="."/>
    <xsl:text>&#xa;%&lt;/</xsl:text>
    <xsl:value-of select="parent::db:chapter/@xml:id"/>
    <xsl:text>>&#xa;</xsl:text>
    <xsl:choose>
      <xsl:when test="ancestor::db:part[@xml:id='files']">
        <xsl:text>% \fi&#xa;</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>%    \end{macrocode}&#xa;</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="delogify">
    <xsl:param name="string"/>
    <xsl:choose>
      <xsl:when test="contains($string,'\LaTeXe{}')">
        <xsl:call-template name="delogify">
          <xsl:with-param name="string">
            <xsl:value-of select="substring-before($string,'\LaTeXe{}')"/>
            <xsl:text>LaTeX2e</xsl:text>
            <xsl:value-of select="substring-after($string,'\LaTeXe{}')"/>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="contains($string,'\LaTeX{}')">
        <xsl:call-template name="delogify">
          <xsl:with-param name="string">
            <xsl:value-of select="substring-before($string,'\LaTeX{}')"/>
            <xsl:text>LaTeX</xsl:text>
            <xsl:value-of select="substring-after($string,'\LaTeX{}')"/>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="contains($string,'\TeX{}')">
        <xsl:call-template name="delogify">
          <xsl:with-param name="string">
            <xsl:value-of select="substring-before($string,'\TeX{}')"/>
            <xsl:text>TeX</xsl:text>
            <xsl:value-of select="substring-after($string,'\TeX{}')"/>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$string"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>

<!--
     Checksum is the number of backslash commands in the
     output code — approximately! 
     lxgrep "part[@xml:id='code']//programlisting" $1.xml |\
         grep '\\' |\
         sed -e "s+[^\\\\]++g" |\
         tr -d '\012' |\
         tr '\\' '\012' |\
         wc -l
-->
