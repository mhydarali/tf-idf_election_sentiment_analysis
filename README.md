# 📰 Trump Media Coverage Analysis

&#x20;&#x20;

**Analysis of 694 North American news articles on President Donald Trump, combining sentiment analysis, TF‑IDF term extraction, and data visualization.**

---

## 📄 Overview

This project examines how North American media outlets cover President Donald Trump. Using **NewsAPI** for data collection, we:

- Categorized articles into six thematic topics via human annotation.
- Performed **sentiment analysis** (Positive, Negative, Neutral).
- Applied **TF‑IDF** to identify distinctive keywords per topic.
- Created visualizations to illustrate trends.

The dataset spans a 28‑day period and includes coverage from across the political spectrum to minimize bias.

---

## 🛠 Tech Stack

- **Python** – Data cleaning, sentiment analysis, TF‑IDF keyword extraction.
- **R** – Data visualization (bar charts, heatmaps, pie charts).
- **JSON** – Raw annotated dataset.

---

## 📂 Repository Structure

```
├── data/                 # JSON dataset of 694 annotated articles
├── scripts/
│   ├── python/           # Sentiment analysis & TF‑IDF processing
│   └── r/                # R visualizations used in the report
├── report/               # Final PDF report & supplementary figures
└── README.md             # Project documentation
```

---

## 📊 Key Findings

- **Neutral tone dominance** – Most articles maintained a neutral tone, challenging common perceptions about consistent partisan bias.
- **Sentiment by category** – Negative sentiment was concentrated in *Reaction and Public Sentiment* and *Legal Issues and Controversies*, while *Elections Results and Coverage* remained mostly neutral.
- **Topic diversity** – Six mutually exclusive and collectively exhaustive thematic categories captured the full range of coverage:
  1. Policy Proposals & Political Positions
  2. Elections Results & Coverage
  3. Reaction & Public Sentiment
  4. Legal Issues & Controversies
  5. Foreign Affairs & Relations
  6. Electoral Campaign & Strategies
- **Distinctive vocabulary** – TF‑IDF revealed unique, topic-specific terms (e.g., “Iowa” for election coverage, “minister” for foreign affairs, “lawyers” for legal issues).
- **Cross-category trends** – Certain geographic or campaign-related terms appeared in multiple categories, indicating overlap in media narratives.
- **Public reaction highlights** – Cultural and social references (e.g., “UFC”, “Dogecoin”, “Nicky Jam”) showed how political events intersect with popular culture.
- **Balanced methodology** – Articles were sourced from outlets across the political spectrum (Center, Center-Left, Center-Right) to ensure balanced representation.

---

## 🚀 How to Run

### 1️⃣ Clone the repository

```bash
git clone https://github.com/yourusername/trump-media-coverage-analysis.git
cd trump-media-coverage-analysis
```

### 2️⃣ Run Python scripts

*(Requires **`pandas`**, **`scikit-learn`**, **`nltk`** — consider using a virtual environment)*

```bash
python scripts/python/sentiment_analysis.py
python scripts/python/tfidf_analysis.py
```

### 3️⃣ Run R visualizations

*(Requires **`ggplot2`**, **`tidytext`** — run from R console or RStudio)*

```r
source("scripts/r/visualizations.R")
```

---

## 👨‍💻 Authors

- **Efe Gülalp** – Data collection pipeline, dataset annotation.
- **Muhammad Hydarali** – Sentiment analysis, TF‑IDF, visualizations.
- **Eddy Hage‑Youssef** – Report writing, dataset annotation.
