import requests
import json
import time
from datetime import datetime, timedelta

# Replace with your NewsAPI key
API_KEY = 'api_key'

# Endpoint for NewsAPI
url = 'https://newsapi.org/v2/everything'

# Query focused on Donald Trump
query = (
    '"Donald Trump" OR "President Trump" OR "Trump Administration" OR '
    '"Former President Trump" OR "Trump Organization" OR "Donald J. Trump"'
)

# Expanded list of US and Canadian sources
north_american_sources = [
    "the-new-york-times", "the-washington-post", "the-wall-street-journal",
    "usa-today", "la-times", "cnn", "fox-news", "nbc-news", "abc-news",
    "cbs-news", "politico", "the-hill", "national-review", "vice-news",
    "associated-press", "npr", "chicago-tribune", "houston-chronicle",
    "boston-globe", "miami-herald", "bloomberg", "cnbc", "business-insider",
    "the-globe-and-mail", "national-post", "toronto-star", "vancouver-sun",
    "montreal-gazette", "cbc-news", "ctv-news", "global-news"
]

language = 'en'
page_size = 100  # Maximum allowed by NewsAPI

def generate_last_28_days():
    """
    Generate a list of daily date ranges for the last 28 days.
    """
    date_ranges = []
    today = datetime.now()
    for i in range(28):
        day = today - timedelta(days=i)
        start_date = day.strftime('%Y-%m-%d')
        end_date = day.strftime('%Y-%m-%d')
        date_ranges.append((start_date, end_date))
    return date_ranges

def filter_articles(articles):
    """
    Filters articles to ensure 'Donald Trump' or related terms are mentioned in the title or description.
    """
    relevant_terms = [
        "Donald Trump", "President Trump", "Trump Administration",
        "Former President Trump", "Trump Organization", "Donald J. Trump"
    ]
    filtered_articles = []
    for article in articles:
        title = article.get('title', '').lower()
        description = article.get('description', '').lower()
        # Check if any relevant term is in the title or description
        if any(term.lower() in title or term.lower() in description for term in relevant_terms):
            filtered_articles.append(article)
    return filtered_articles

def fetch_news(date_from, date_to, sources):
    articles = []
    for page_number in range(1, 2):  # Only fetch the first page due to free-tier limits
        params = {
            'q': query,
            'from': date_from,
            'to': date_to,
            'sources': ','.join(sources),
            'language': language,
            'pageSize': page_size,
            'page': page_number,
            'apiKey': API_KEY,
        }
        response = requests.get(url, params=params)
        if response.status_code == 200:
            data = response.json()
            articles_batch = data.get('articles', [])
            filtered_batch = filter_articles(articles_batch)  # Apply filtering
            articles.extend(filtered_batch)
            print(f"Fetched {len(filtered_batch)} relevant articles (Page {page_number}) from {date_from} to {date_to}")
        else:
            print(f"Error: {response.status_code}, {response.json()}")
            break  # Stop on API error to prevent unnecessary requests
    return articles

def save_to_json_file(articles, filename='trump_last.json'):
    with open(filename, 'w', encoding='utf-8') as file:
        json.dump(articles, file, ensure_ascii=False, indent=4)
    print(f"Saved {len(articles)} articles to {filename}")

if __name__ == '__main__':
    all_articles = []
    date_ranges = generate_last_28_days()  # Generate the last 28 days' date ranges
    for date_from, date_to in date_ranges:
        try:
            articles = fetch_news(date_from, date_to, north_american_sources)
            all_articles.extend(articles)
            time.sleep(1)  # To respect rate limits
        except Exception as e:
            print(f"An error occurred: {e}")
    save_to_json_file(all_articles, filename='trump_last.json')
