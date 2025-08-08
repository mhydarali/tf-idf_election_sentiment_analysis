# This version includes the pie charts per category
# Also added custom stop words in addition to the default given list

library(tidyverse)
library(tidytext)

# Load the dataset
data <- read.csv("data_comp370.csv")
view(data)

# Select relevant columns and rename for consistency
relevant_data <- data %>%
  select(Open.Coding..Topic., Open.Coding..Sentiment., title, description) %>%
  rename(topic = Open.Coding..Topic., sentiment = Open.Coding..Sentiment.)

# Count the number of articles per topic
category_counts <- relevant_data %>%
  group_by(topic) %>%
  summarise(article_count = n())
# Print the results
print(category_counts)


# Combine columns into a single text column for analysis
tidy_data <- relevant_data %>%
  pivot_longer(cols = c(title, description), names_to = "column", values_to = "text") %>%
  unnest_tokens(word, text)  # Tokenize into words

# Load default stop words from tidytext
data("stop_words")

# Define additional custom stop words
exclude_words_final <- c("trump", "donald", "president", "prime", "day", "says", "2024", "vice", "madison", "square", "garden", "baby", "birth", "309")

# Combine default stop words with custom stop words
custom_stop_words <- bind_rows(
  stop_words, 
  tibble(word = exclude_words_final, lexicon = "custom")
)

# Remove stop words
data_clean <- tidy_data %>%
  anti_join(custom_stop_words, by = "word")  # Remove both default and custom stop words

# Count word occurrences
word_counts <- data_clean %>%
  count(topic, word, sort = TRUE)

# Compute TF-IDF
tf_idf <- word_counts %>%
  bind_tf_idf(word, topic, n)  # Use the topic as the document identifier

# View top terms by TF-IDF score
tf_idf %>%
  arrange(desc(tf_idf)) %>%
  head(20)

# Visualize the top 10 terms for each category
tf_idf %>%
  group_by(topic) %>%
  slice_max(tf_idf, n = 10, with_ties = FALSE) %>%  # Strictly limit to 10 terms
  ungroup() %>%
  ggplot(aes(tf_idf, reorder(word, tf_idf), fill = topic)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~topic, scales = "free") +
  labs(title = "Top TF-IDF Terms by Topic", x = "TF-IDF", y = NULL) +
  theme(
    plot.title = element_text(hjust = 0.5, size = 15),  # Center and style the title
    plot.margin = margin(t = 20, r = 20, b = 20, l = 20)
  )

# Function to generate bar plots for two topics - WITHOUT NUMBERS
# generate_two_topics_plot <- function(topic1, topic2) {
#   tf_idf %>%
#     filter(topic %in% c(topic1, topic2)) %>%  # Filter for the two topics
#     group_by(topic) %>%
#     slice_max(tf_idf, n = 10, with_ties = FALSE) %>%  # Strictly limit to 10 terms
#     ungroup() %>%
#     ggplot(aes(tf_idf, reorder(word, tf_idf), fill = topic)) +
#     geom_col(show.legend = FALSE) +
#     facet_wrap(~topic, scales = "free", ncol = 2) +  # Two graphs side by side
#     labs(title = paste(topic1, "&", topic2),
#          x = "TF-IDF", y = NULL) +
#     theme(
#       plot.title = element_text(hjust = 0.5, size = 15),  # Center and style the title
#       plot.margin = margin(t = 20, r = 20, b = 20, l = 20)  # Adjust margins
#     )
# }

generate_two_topics_plot("Elections Results and Coverage", "Reaction and Public Sentiment")

# Function to generate bar plots for two topics
generate_two_topics_plot <- function(topic1, topic2) {
  tf_idf %>%
    filter(topic %in% c(topic1, topic2)) %>%  # Filter for the two topics
    group_by(topic) %>%
    slice_max(tf_idf, n = 10, with_ties = FALSE) %>%  # Strictly limit to 10 terms
    ungroup() %>%
    ggplot(aes(tf_idf, reorder(word, tf_idf), fill = topic)) +
    geom_col(show.legend = FALSE) +
    geom_text(aes(label = round(tf_idf, 4)),  # Add the TF-IDF values as labels
              hjust = 1.5, vjust = 0.5, size = 3) +  # Center inside bars
    facet_wrap(~topic, scales = "free", ncol = 2) +  # Two graphs side by side
    labs(title = paste(topic1, "&", topic2),
         x = "TF-IDF", y = NULL) +
    theme(
      plot.title = element_text(hjust = 0.5, size = 15),  # Center and style the title
      axis.title.x = element_text(margin = margin(t = 10)),  # Lower the X-axis label
      plot.margin = margin(t = 20, r = 20, b = 20, l = 20)  # Adjust margins
    ) +
    coord_cartesian(clip = "off")  # Allow text labels to extend outside plot area
}

# Function to generate bar plots for two topics with specific bar colors
generate_two_topics_plot <- function(topic1, topic2) {
  tf_idf %>%
    filter(topic %in% c(topic1, topic2)) %>%  # Filter for the two topics
    group_by(topic) %>%
    slice_max(tf_idf, n = 10, with_ties = FALSE) %>%  # Strictly limit to 10 terms
    ungroup() %>%
    ggplot(aes(tf_idf, reorder(word, tf_idf))) +
    geom_col(fill = rgb(166/255, 200/255, 221/255)) +  # Set bar colors
    geom_text(aes(label = round(tf_idf, 4)),  # Add the TF-IDF values as labels
              hjust = 1.5, vjust = 0.5, size = 3) +  # Center inside bars
    facet_wrap(~topic, scales = "free", ncol = 2) +  # Two graphs side by side
    labs(title = paste(topic1, "&", topic2),
         x = "TF-IDF", y = NULL) +
    theme(
      plot.title = element_text(hjust = 0.5, size = 15),  # Center and style the title
      axis.title.x = element_text(margin = margin(t = 10)),  # Lower the X-axis label
      plot.margin = margin(t = 20, r = 20, b = 20, l = 20)  # Adjust margins
    ) +
    coord_cartesian(clip = "off")  # Allow text labels to extend outside plot area
}

unique_topics
# Reorder unique_topics
unique_topics <- c(
  "Elections Results and Coverage",
  "Electoral Campaign and Strategies",
  "Policy Proposals and Political Positions",
  "Reaction and Public Sentiment",
  "Foreign Affairs and Relations",
  "Legal Issues and Controversies"
)

# Save bar plots for each pair of topics
for (i in seq(1, length(unique_topics), by = 2)) {
  topic1 <- unique_topics[i]
  topic2 <- ifelse(i + 1 <= length(unique_topics), unique_topics[i + 1], NULL)  # Handle odd numbers of topics
  
  # Generate and save the plot
  plot <- generate_two_topics_plot(topic1, topic2)
  file_name <- if (!is.null(topic2)) {
    paste0("bar_plot_", gsub(" ", "_", topic1), "_and_", gsub(" ", "_", topic2), ".jpg")
  } else {
    paste0("bar_plot_", gsub(" ", "_", topic1), ".jpg")  # Single topic case
  }
  ggsave(filename = file_name, plot = plot, width = 8, height = 4)
}

# Generate pie charts for sentiment distribution within each topic
# Count the number of positive, negative, neutral articles per topic
sentiment_distribution <- relevant_data %>%
  group_by(topic, sentiment) %>%
  summarise(count = n(), .groups = "drop")

generate_pie_chart <- function(category_name) {
  # Filter the data for the specified category
  category_data <- sentiment_distribution %>%
    filter(topic == category_name) %>%
    mutate(percentage = round(100 * count / sum(count), 1))  # Calculate percentages
  
  ggplot(category_data, aes(x = "", y = count, fill = sentiment)) +  # Use count for y aesthetic
    geom_col(width = 1, color = "white") +             # Bar chart converted to pie
    coord_polar(theta = "y") +                         # Convert to pie chart
    scale_fill_brewer(palette = "Blues") +
    geom_text(aes(label = paste0(percentage, "%")),    # Add percentage labels
              position = position_stack(vjust = 0.5), # Center labels in slices
              size = 5) +                             # Adjust text size
    labs(title = paste("Sentiment Distribution for", category_name), fill = NULL) +  # Remove legend title
    theme_void() +                                     # Remove unnecessary grid/axes
    theme(
      plot.title = element_text(hjust = 0.5, size = 15, 
                                margin = margin(t = 10, b = -20)),  # Lower the title
      legend.position = "bottom",                                 # Keep legend at the bottom
      legend.margin = margin(t = -20),                           # Move legend closer to the pie chart
      legend.key.size = unit(0.8, "cm"),                         # Adjust legend key size
      legend.text = element_text(size = 15),                     # Adjust legend text size
      plot.margin = margin(t = 20, r = 20, b = 20, l = 20)       # Adjust overall plot margin
    )
}

generate_pie_chart("Reaction and Public Sentiment")


unique_topics <- unique(sentiment_distribution$topic)

for (topic in unique_topics) {
  plot <- generate_pie_chart(topic)
  ggsave(filename = paste0("pie_chart_", gsub(" ", "_", topic), ".jpg"), plot = plot)
}


