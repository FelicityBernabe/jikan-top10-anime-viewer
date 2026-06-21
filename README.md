# Anime Data Viewer

A mini integration project that transforms anime data into a visually styled HTML report using a complete data pipeline.

This project fetches real-time anime data from the Jikan API and converts it into a structured and interactive cinematic interface.

---

## 📌 Features

* Cinematic card-based UI (film-inspired design)
* Displays Top 10 Anime with:

  * Title
  * Ranking
  * Score
  * Episode count
* Poster-style images
* Hover-to-view synopsis overlay
* Styled using gold-accented dark theme

---

## 🧰 Tech Stack

* Python
* Requests
* XML (ElementTree / lxml)
* XSLT
* HTML + CSS

---

## 🔄 Data Integration Pipeline

```
API (JSON)
   ↓
Python (requests)
   ↓
XML (structured data)
   ↓
XSLT Transformation
   ↓
HTML Report (styled output)
```

---

## 🖼️ Screenshots

### 🎬 Main Interface

<img width="959" height="509" alt="image" src="https://github.com/user-attachments/assets/b11f05c3-def4-4cdd-82a7-2f5114559f87" />

### 📖 Synopsis Overlay

<img width="959" height="508" alt="image" src="https://github.com/user-attachments/assets/2beaed92-6229-4de3-a0b0-129d7fd46e2d" />


---

## ▶️ How to Run

1. Install dependencies:

```
pip install requests lxml
```

2. Run the Python script:

```
python main.py
```

3. Open:

```
output.html
```

---

🌐 API Used

* Jikan API (MyAnimeList unofficial API)

---

📁 Project Structure

```
project/
 ├── main.py
 ├── data.xml
 ├── transform.xslt
 ├── output.html
```

---

👤 Author

saya

BSIT 2-1

---

📚 Notes

This project was created as a deliverable for Integrative Programming and Technologies, demonstrating data transformation from API to structured HTML output.
