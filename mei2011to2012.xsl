<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.music-encoding.org/ns/mei"
    xmlns:mei="http://www.music-encoding.org/ns/mei"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0">
    <xsl:output indent="yes" encoding="UTF-8"/>
    
    <!-- Copy everything -->
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
    
    <!-- Change meiversion -->
    <xsl:template match="@meiversion">
        <xsl:attribute name="meiversion">2012</xsl:attribute>
    </xsl:template>
    
    <!-- Remove zone nodes -->
    <xsl:template match="mei:facsimile"/>
    
    <!-- Modify nodes -->
    <xsl:template match="mei:layout">
        <layouts>
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
        </layouts>
    </xsl:template>
    <xsl:template match="mei:system">
        <xsl:variable name="selectedSystem" select="."/>
        <xsl:copy>
            <xsl:apply-templates select="//mei:zone[./@xml:id=current()/@facs]/@*[name()!='xml:id']"/>
            <xsl:apply-templates select="@*[name()!='facs']"/>
            <laidOutStaff staff="1">
                <laidOutLayer>
                    <xsl:for-each select="//mei:layer/*[@facs and preceding::mei:sb[1]/@systemref=$selectedSystem/@xml:id]">
                        <laidOutElement>
                            <xsl:attribute name="target">
                                <xsl:value-of select="@xml:id"/>
                            </xsl:attribute>
                            <xsl:apply-templates select="//mei:zone[./@xml:id=current()/@facs]/@*[name()!='xml:id']"/>
                        </laidOutElement>
                        <xsl:if test="name()='division' and @form='final'">
                            <!--<sectionBreak />-->
                        </xsl:if>
                    </xsl:for-each>
                </laidOutLayer>
            </laidOutStaff>
        </xsl:copy>
    </xsl:template>
    <!--
    <xsl:template match="body">
        <xsl:copy>
            <xsl:for-each select="//staffGrp/staffDef">
                <mdiv>
                    <score>
                        <scoreDef>
                            <staffGrp>
                                <xsl:copy>
                                   <xsl:apply-templates select="@*|node()"/>                                    
                                </xsl:copy>
                            </staffGrp>
                        </scoreDef>
                        <section>
                            <xsl:copy-of select="//section/staff[./@n=current()/@n]"/>
                        </section>
                    </score>
                </mdiv>
            </xsl:for-each>
        </xsl:copy>
    </xsl:template>
    -->
    <xsl:template match="mei:staff">
        <xsl:copy-of select="current()/mei:layer/child::node()[name()!='sb']" />   
    </xsl:template>
    <xsl:template match="mei:staffGrp">
        <xsl:copy>
            <xsl:apply-templates select="current()/mei:staffDef[@n='1']"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="mei:section">
        <section>
            <staff>
                <layer>
                    <xsl:apply-templates select="./*[name()!='pb']" />
                </layer>
            </staff>
        </section>
    </xsl:template>

</xsl:stylesheet>