# 📰 Trump Media Coverage Analysis

&#x20; &#x20;

**Analysis of 694 North American news articles on President Donald Trump, combining sentiment analysis, TF‑IDF term extraction, and data visualization.**

---

## 📄 Overview

Media coverage strongly influences public perception of political figures. This project investigates:

- **Dominant topics** in Trump-related news coverage
- **Most distinctive keywords** within each topic (via TF‑IDF)
- **Sentiment distribution** (Positive, Negative, Neutral) across topics

Data was collected over a 28‑day period using **NewsAPI**, drawing from a range of outlets to reduce ideological bias.

---

## 🛠 Tech Stack

- **Python** – Data cleaning, sentiment analysis, TF‑IDF keyword extraction
- **R** – Data visualization (bar charts, heatmaps, pie charts)
- **JSON** – Raw annotated dataset

---

## 📂 Repository Structure

```
├── data/                 # JSON dataset of 694 annotated articles
├── scripts/
│   ├── python/           # Sentiment analysis & TF‑IDF processing
│   └── r/                # R visualizations used in the report
├── report/               # Final PDF report & supplementary figures
├── LICENSE               # MIT License
└── README.md             # Project documentation
```

---

## 📊 Key Findings

- Most articles were **neutral**, challenging some expectations about media bias.
- Six thematic categories were identified:
  1. Policy Proposals & Political Positions
  2. Elections Results & Coverage
  3. Reaction & Public Sentiment
  4. Legal Issues & Controversies
  5. Foreign Affairs & Relations
  6. Electoral Campaign & Strategies
- TF‑IDF analysis highlighted **topic‑specific keywords**, validating the human annotation framework.

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

*(Requires **`ggplot2`**, **`tidytext`** — run from an R console or RStudio)*

```r
source("scripts/r/visualizations.R")
```

---

## 📜 License

This project is licensed under the **MIT License**. See `LICENSE` for details.

---

## 👨‍💻 Authors

- **Efe Gülalp** – Data collection pipeline, dataset annotation
- **Muhammad Hydarali** – Sentiment analysis, TF‑IDF, visualizations
- **Eddy Hage‑Youssef** – Report writing, dataset annotation
