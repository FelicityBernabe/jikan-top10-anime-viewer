import requests
from datetime import date
from lxml import etree


API_URL = "https://api.jikan.moe/v4/top/anime"
OUTPUT_XML = "data.xml"
OUTPUT_HTML = "output.html"
XSL_FILE = "transform.xslt"


def fetch_top_anime(limit=10):
    response = requests.get(API_URL, timeout=15)
    response.raise_for_status()
    data = response.json()
    print("Fetched JSON structure:\n")
    print(data)

    anime_items = data.get("data", [])[:limit]

    cleaned = []

    for anime in anime_items:
        cleaned.append({
            "title": anime.get("title", "Unknown title"),
            "score": anime.get("score") if anime.get("score") is not None else "N/A",
            "episodes": anime.get("episodes") if anime.get("episodes") is not None else "N/A",
            "image": anime.get("images", {}).get("jpg", {}).get("image_url", ""),
            "synopsis": anime.get("synopsis", "Synopsis not available."),
        })

    return cleaned


def write_xml(anime_list, path):
    root = etree.Element("anime_list")
    etree.SubElement(root, "report_date").text = date.today().isoformat()

    for anime in anime_list:
        anime_elem = etree.SubElement(root, "anime")
        etree.SubElement(anime_elem, "title").text = anime["title"]
        etree.SubElement(anime_elem, "score").text = str(anime["score"])
        etree.SubElement(anime_elem, "episodes").text = str(anime["episodes"])
        etree.SubElement(anime_elem, "image").text = anime["image"]
        etree.SubElement(anime_elem, "synopsis").text = anime["synopsis"]

    tree = etree.ElementTree(root)
    tree.write(path, pretty_print=True, xml_declaration=True, encoding="UTF-8")
    print(f"Wrote XML to {path}")


def transform_xml_to_html(xml_path, xsl_path, html_path):
    xml = etree.parse(xml_path)
    xsl = etree.parse(xsl_path)
    transform = etree.XSLT(xsl)
    result = transform(xml)

    with open(html_path, "w", encoding="utf-8") as f:
        f.write(str(result))

    print(f"Wrote HTML to {html_path}")


if __name__ == "__main__":
    anime_data = fetch_top_anime(10)
    write_xml(anime_data, OUTPUT_XML)
    transform_xml_to_html(OUTPUT_XML, XSL_FILE, OUTPUT_HTML)
