<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="//Service/Connector[@protocol = 'HTTP/1.1']/@port">
        <xsl:attribute name="port">
            <xsl:value-of select="'29000'" />
        </xsl:attribute>
    </xsl:template>

</xsl:stylesheet>