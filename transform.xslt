<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="html" encoding="UTF-8" indent="yes"/>

  <xsl:template match="/">
    <html>
      <head>
        <meta charset="UTF-8"/>
        <title>The Anime Reel</title>
        <style>
          * {
            box-sizing: border-box;
          }

          body {
            background-color: #111111;
            color: #f4e6c1;
            font-family: "Playfair Display", serif;
            margin: 0;
            padding: 0;
          }

          body::after {
            content: "";
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
            background: url("https://www.transparenttextures.com/patterns/asfalt-dark.png");
            opacity: 0.15;
          }

          header {
            background: #1f1f1f;
            border-bottom: 1px solid #6d5f3c;
            padding: 24px;
            text-align: center;
          }

          h1 {
            margin: 0;
            font-size: 2.6rem;
            letter-spacing: 0.16em;
            text-transform: uppercase;
            color: #e6c88d;
          }

          header p {
            margin: 8px 0 0;
            opacity: 0.8;
            font-size: 0.95rem;
          }

          .grid {
            display: grid;
            grid-template-columns: repeat(5, 1fr);
            gap: 14px;
            padding: 18px;
            max-width: 1440px;
            margin: 0 auto;
          }

          @media (max-width: 1200px) {
            .grid {
              grid-template-columns: repeat(3, 1fr);
            }
          }

          @media (max-width: 768px) {
            .grid {
              grid-template-columns: repeat(1, 1fr);
            }
          }

          .card {
            position: relative;
            display: flex;
            flex-direction: column;
            height: 400px;
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid #6d5f3c;
            border-radius: 14px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.5);
            overflow: hidden;
            transition: all 0.3s ease;
          }

          .card:hover {
            transform: translateY(-6px) scale(1.02);
            box-shadow: 0 18px 40px rgba(0, 0, 0, 0.7);
            border-color: #d4af37;
          }

          .card::before,
          .card::after {
            content: "";
            position: absolute;
            top: 0;
            width: 6px;
            height: 100%;
            background: repeating-linear-gradient(
              to bottom,
              #000,
              #000 6px,
              transparent 6px,
              transparent 12px
            );
            z-index: 1;
          }

          .card::before {
            left: -6px;
          }

          .card::after {
            right: -6px;
          }

          .image-hero {
            flex: 3;
            position: relative;
            overflow: hidden;
          }

          .card img {
            width: 100%;
            height: 300px;
            object-fit: cover;
            background: #000;
            filter: sepia(20%) contrast(1.05);
            transition: transform 0.4s ease;
          }

          .card:hover img,
          .card:focus-within img {
            transform: scale(1.06);
          }

          .rank {
            position: absolute;
            top: 8px;
            left: 8px;
            background: rgba(0, 0, 0, 0.7);
            border: 1px solid #c2a66b;
            padding: 4px 8px;
            font-size: 0.75rem;
            letter-spacing: 0.08em;
            z-index: 2;
          }

          .details {
            flex: 1;
            padding: 10px 12px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            background: rgba(0, 0, 0, 0.3);
          }

          .details h2 {
            font-size: 0.95rem;
            margin: 0;
            letter-spacing: 0.04em;
            color: #f0d98c;
            text-shadow: 0 0 5px rgba(255, 215, 0, 0.25);
            line-height: 1.2;
            height: 2.4em;
            overflow: hidden;
          }

          .meta {
            display: flex;
            flex-wrap: wrap;
            gap: 6px;
            font-size: 0.8rem;
            margin-top: 4px;
          }

          .meta span {
            background: rgba(255, 255, 255, 0.08);
            border: 1px solid #6d5f3c;
            border-radius: 6px;
            padding: 3px 6px;
          }

          .synopsis {
            position: absolute;
            inset: 0;
            background: rgba(0, 0, 0, 0.75);
            backdrop-filter: blur(8px);
            color: #fff8dc;
            padding: 14px;
            overflow-y: auto;
            opacity: 0;
            transition: opacity 0.3s ease;
            display: flex;
            flex-direction: column;
            z-index: 3;
          }

          .card:hover .synopsis,
          .card:focus-within .synopsis {
            opacity: 1;
          }

          .synopsis h3 {
            margin: 0 0 8px;
            font-size: 0.9rem;
            letter-spacing: 1px;
            color: #f0d98c;
          }

          .synopsis p {
            margin: 0;
            font-size: 0.85rem;
            line-height: 1.6;
            text-shadow: 0 1px 3px rgba(0, 0, 0, 0.8);
          }

          .synopsis::-webkit-scrollbar {
            width: 6px;
          }

          .synopsis::-webkit-scrollbar-thumb {
            background: #c2a66b;
          }
        </style>
      </head>
      <body>
        <header>
          <h1>Anime Data Viewer</h1>
          <p>Top 10 anime rankings powered by the Jikan API, transformed through XML and XSLT.</p>
        </header>
        <div class="grid">
          <xsl:for-each select="anime_list/anime">
            <div class="card">
              <div class="image-hero">
                <img>
                  <xsl:attribute name="src"><xsl:value-of select="image"/></xsl:attribute>
                  <xsl:attribute name="alt"><xsl:value-of select="title"/></xsl:attribute>
                </img>
                <span class="rank">TOP <xsl:value-of select="position()"/></span>
              </div>
              <div class="details">
                <h2><xsl:value-of select="title"/></h2>
                <div class="meta">
                  <span>Score: <xsl:value-of select="score"/></span>
                  <span>Episodes: <xsl:value-of select="episodes"/></span>
                </div>
              </div>
              <div class="synopsis">
                <h3>Synopsis</h3>
                <p><xsl:value-of select="synopsis"/></p>
              </div>
            </div>
          </xsl:for-each>
        </div>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
