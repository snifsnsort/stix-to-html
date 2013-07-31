<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fn="http://www.w3.org/2005/xpath-functions"

    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    
    xmlns:stix='http://stix.mitre.org/stix-1'
    xmlns:cybox='http://cybox.mitre.org/cybox-2'
    
    exclude-result-prefixes="xs xd"
    version="2.0"
    
    xmlns:saxon="http://saxon.sf.net/"
>

<xsl:output method="html" omit-xml-declaration="yes" indent="yes" media-type="text/html" version="4.0" />
<!-- <xsl:output indent="yes" saxon:indent-spaces="2" method="xml" /> -->

<!--
<xsl:template match="/">
    <root>
        <original>
            
        </original>
        <normalized>
            <xsl:apply-templates select="/stix:STIX_Package/*" mode="createNormalized">
            </xsl:apply-templates>
        </normalized>
        <!- -
        <reference-before-cleaning>
            <xsl:apply-templates select="/stix:STIX_Package//*[@id]" mode="verbatim"/>
        </reference-before-cleaning>
        - ->
        <reference>
            <xsl:apply-templates select="/stix:STIX_Package//*[@id]" mode="createReference">
                <xsl:with-param name="isTopLevel" select="fn:true()" />
            </xsl:apply-templates>
        </reference>
        <!- -
        <xsl:for-each select="/stix:STIX_Package/stix:Observables/cybox:Observable/(cybox:Event|cybox:Object)">
            <xsl:apply-templates mode="oneDeep" select="." />
        </xsl:for-each>
        - ->
    </root>
</xsl:template>
-->

<xsl:template match="node()" mode="createNormalized" priority="10.0">
    
    <xsl:copy copy-namespaces="no">
        <!-- pull in all the attributes -->
        <xsl:apply-templates select="@*" mode="createNormalized" />
        
        <!-- cut off the children of items having an id attribute
         (it will be replaced with an idref)
        -->
        <xsl:if test="not(@id) and not(@idref)">
            <xsl:apply-templates select="node()" mode="createNormalized" />
        </xsl:if>
    </xsl:copy>
</xsl:template>

<xsl:template match="@*" mode="createNormalized" priority="10.0">
    <xsl:copy copy-namespaces="no" />
</xsl:template>

<xsl:template match="@id" mode="createNormalized" priority="20.0">
    <xsl:attribute name="idref" select="fn:data(.)" />
</xsl:template>        


<!--
  recursively copy all nodes, except stop copying when an element with an id
  attribute comes up and for that element, change the id to an idref (and all
  of its children are left off, as they will be listed as their own reference
  nodes).
-->
<xsl:template match="node()" mode="createReference" priority="10.0">
    <xsl:param name="isTopLevel" select="fn:false()" />
    
    <xsl:copy copy-namespaces="no">
        
        <!-- for debugging, label each element with an attribute indicating if
             it's the top level or a descendant
        -->
        <xsl:attribute name="level">
            <xsl:if test="$isTopLevel">TOP</xsl:if>
            <xsl:if test="not($isTopLevel)">DESCENDENT</xsl:if>
        </xsl:attribute>
        
        <!-- pull in all the attributes -->
        <xsl:apply-templates select="@*" mode="createReference">
            <xsl:with-param name="isTopLevel" select="$isTopLevel"/>
        </xsl:apply-templates>
        
        <!-- cut off the children of items having an id attribute
             (it will be replaced with an idref)
        -->
        <xsl:if test="$isTopLevel or not(@id)">
            <xsl:apply-templates select="node()" mode="createReference" />
        </xsl:if>
    </xsl:copy>
</xsl:template>

<!-- copy all attributes (excpet @id which will be handled in the
     following template with a higher priority
-->
<xsl:template match="@*" mode="createReference" priority="10.0">
    <xsl:param name="isTopLevel" select="fn:false()" />
    
    <xsl:copy copy-namespaces="no">
    </xsl:copy>
</xsl:template>
            
<xsl:template match="@id" mode="createReference" priority="20.0">
    <xsl:param name="isTopLevel" select="fn:false()" />
    <xsl:choose>
        <xsl:when test="not($isTopLevel)">
            <xsl:attribute name="idref" select="fn:data(.)" />
        </xsl:when>
        <xsl:otherwise>
            <xsl:attribute name="id" select="fn:data(.)" />
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>        

<xsl:template match="@*|node()" mode="oneDeepMain">
    <xsl:copy copy-namespaces="no">
        <xsl:apply-templates select="@*|node()" mode="oneDeepDescendant" />
    </xsl:copy>
</xsl:template>

<xsl:template match="@*|node()[not(@id) and not(@idref)]" mode="oneDeep">
    <xsl:copy copy-namespaces="no">
        <xsl:apply-templates select="@*|node()" mode="oneDeepDescendant" />
    </xsl:copy>
</xsl:template>
    
<!--
<xsl:template match="*[@id]" mode="oneDeepDescendant">
    <xsl:copy copy-namespaces="no">
        <xsl:attribute name="status" select="'SKIPPED'" />
        <xsl:attribute name="idref" select="fn:data(@id)" />
        <xsl:apply-templates select="(@*[not(self::id) and not(self::idref)])" mode="oneDeepDescendant" />
    </xsl:copy>
</xsl:template>

<xsl:template match="*[@idref]" mode="oneDeepDescendant">
    <xsl:copy copy-namespaces="no">
        <xsl:attribute name="status" select="'SKIPPED'" />
        <xsl:apply-templates select="(@*[not(self::id) and not(self::idref)])" mode="oneDeepDescendant" />
    </xsl:copy>
</xsl:template>
-->
    
<xsl:template match="@*|node()" mode="verbatim">
    <xsl:copy copy-namespaces="no">
        <xsl:apply-templates select="@*|node()" mode="verbatim" />
    </xsl:copy>
</xsl:template>
    
</xsl:stylesheet>