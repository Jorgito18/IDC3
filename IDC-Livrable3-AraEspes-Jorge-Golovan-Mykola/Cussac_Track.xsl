<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.topografix.com/GPX/1/1"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:saxon="http://saxon.sf.net/"
    extension-element-prefixes="saxon" version="3.0" exclude-result-prefixes="#all">

    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
    <xsl:strip-space elements="*"/>

    <xsl:variable name="geofile"
        select="document('fr_Cussac-coord-entites.xml')/geolocalisation/entite_nom"/>

    <xsl:variable name="date" select="xs:dateTime('2020-04-15T10:00:00+02:00')" saxon:assignable="yes"/>

    <xsl:template match="/">
        <xsl:variable name="length" select="6"/>
        <xsl:variable name="i" select="0"/>
        <xsl:element name="gpx">
            <xsl:attribute name="version">1.1</xsl:attribute>
            <xsl:attribute name="creator">JAE/MG</xsl:attribute>
            <xsl:element name="metadata">
                <xsl:element name="name">
                    <xsl:text>Cussac - Cussac</xsl:text>
                </xsl:element>
                <xsl:element name="link">
                    <xsl:attribute name="href">///fr_Cussac_Trans.xml</xsl:attribute>
                    <xsl:element name="text">fr_Cussac_Trans.xml</xsl:element>
                </xsl:element>
            </xsl:element>
            <xsl:for-each select="//*[@type = 'NAM']">
                <xsl:variable name="curVal" select="."/>
                <xsl:choose>
                    <xsl:when test="$curVal = $geofile">
                        <xsl:for-each select=" for $i in 0 to $length return $geofile[$i]">
                            <xsl:if test="$curVal/text() = ./text()">
                                <xsl:element name="wpt">
                                    <xsl:attribute name="lat">
                                        <xsl:value-of select="./@lat"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="lon">
                                        <xsl:value-of select="./@lng"/>
                                    </xsl:attribute>
                                    <xsl:element name="ele">
                                        <xsl:value-of select="./@alt"/>
                                    </xsl:element>
                                    <xsl:element name="name">
                                        <xsl:value-of select="$curVal/text()"/>
                                    </xsl:element>
                                </xsl:element>
                            </xsl:if>
                        </xsl:for-each>
                    </xsl:when>
                </xsl:choose>
            </xsl:for-each>
            <xsl:element name="trk">
                <xsl:element name="name">Cussac - Cussac</xsl:element>
                <xsl:element name="trkseg">
                    <xsl:for-each select="//*[@type = 'NAM']">
                        <xsl:variable name="curVal" select="."/>
                        <xsl:choose>
                            <xsl:when test="$curVal = $geofile">
                                <xsl:for-each select=" for $i in 0 to $length return $geofile[$i]">
                                    <xsl:if test="$curVal/text() = ./text()">
                                        <xsl:element name="trkpt">
                                            <xsl:attribute name="lat">
                                                <xsl:value-of select="./@lat"/>
                                            </xsl:attribute>
                                            <xsl:attribute name="lon">
                                                <xsl:value-of select="./@lng"/>
                                            </xsl:attribute>
                                            <xsl:element name="ele">
                                                <xsl:value-of select="./@alt"/>
                                            </xsl:element>
                                            <xsl:element name="time">
                                                <xsl:value-of select="$date"/>
                                            </xsl:element>
                                            <xsl:element name="name">
                                                <xsl:value-of select="$curVal/text()"/>
                                            </xsl:element>
                                        </xsl:element>
                                    </xsl:if>
                                </xsl:for-each>
                                <saxon:assign name="date" select="$date + xs:dayTimeDuration('PT0H30M')"/>
                            </xsl:when>
                        </xsl:choose>
                    </xsl:for-each>
                </xsl:element>
            </xsl:element>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>
