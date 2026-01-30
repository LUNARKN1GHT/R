library(tidyverse)
library(lubridate) # R 语言处理日期的黄金标准
library(scales)

if (!dir.exists("projects/TMDB/result")) dir.create("projects/TMDB/result")

# 0. 读取数据
df_cleaned <- read.csv("data/TMDB/cleaned/tmdb_cleaned.csv")

# 1. 数据准备
df_time <- df_cleaned %>%
    filter(!is.na(release_date) & release_date != "") %>%
    mutate(
        date = as.Date(release_date),
        year = year(date),
        month = month(date, label = TRUE, abbr = TRUE) # 提取月份缩写：Jan, Feb...
    ) %>%
    filter(year >= 1980 & year <= 2016) # 筛选数据较全的年份区间

pdf("projects/TMDB/result/movie_time_analysis.pdf", width = 10, height = 7)

# ------------------------------------------
# 任务 A：电影档期分析 (月度票房均值)
# ------------------------------------------
monthly_revenue <- df_time %>%
    group_by(month) %>%
    summarise(avg_revenue = mean(revenue, na.rm = TRUE))

p1 <- ggplot(monthly_revenue, aes(x = month, y = avg_revenue, fill = avg_revenue)) +
    geom_col(show.legend = FALSE) +
    scale_y_continuous(labels = label_dollar()) +
    scale_fill_gradient(low = "#99ccff", high = "#003366") +
    labs(
        title = "Monthly Seasonality: When is the Best Time to Release?",
        subtitle = "Average revenue peaks during Summer (June) and Winter (December) holidays",
        x = "Month", y = "Average Revenue"
    ) +
    theme_minimal()

print(p1)

# ------------------------------------------
# 任务 B：流派演变趋势 (1980 - 2016)
# ------------------------------------------
# 拆分流派并计算每年各流派的占比
genre_trend <- df_time %>%
    separate_rows(genres_clean, sep = ", ") %>%
    rename(genre = genres_clean) %>%
    filter(genre %in% c("Action", "Drama", "Comedy", "Science Fiction", "Horror")) %>%
    count(year, genre) %>%
    group_by(year) %>%
    mutate(percent = n / sum(n))

p2 <- ggplot(genre_trend, aes(x = year, y = percent, color = genre)) +
    geom_line(linewidth = 1) +
    geom_point(alpha = 0.5) +
    scale_y_continuous(labels = percent) +
    labs(
        title = "Genre Evolution: How Audience Tastes Change",
        subtitle = "Percentage of major genres over the years",
        x = "Year", y = "Market Share (%)"
    ) +
    theme_minimal()

print(p2)

dev.off()
