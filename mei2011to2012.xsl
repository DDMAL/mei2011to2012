<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
    <xsl:output indent="yes"/>
    
    <!-- Copy everything -->
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
    
    <!-- Change attributes -->
    <xsl:template match="@meiversion">
        <xsl:attribute name="meiversion">2012</xsl:attribute>
    </xsl:template>
    
    <!-- Remove nodes -->
    <xsl:template match="facsimile"/>
    <xsl:template match="pb"/>
    <xsl:template match="sb"/>
    
    <!-- Modify nodes -->
    <xsl:template match="layout">
        <layouts>
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
        </layouts>
    </xsl:template>
    <xsl:template match="system">
        <xsl:copy>
            <xsl:apply-templates select="@*[name()!='facs']"/>
            <laidOutStaff>
                <laidOutLayer>
                    <xsl:for-each select="//layer//*[name()!='sb']">
                        <laidOutElement>
                            <xsl:attribute name="target">
                                <xsl:value-of select="@xml:id"/>
                            </xsl:attribute>
                            <xsl:apply-templates select="//zone/@*[name()!='xml:id']"/>
                        </laidOutElement>
                    </xsl:for-each>
                </laidOutLayer>
            </laidOutStaff>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="score">
        <xsl:copy>
            <xsl:apply-templates select="section"/>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>