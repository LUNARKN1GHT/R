library(ggplot2)
library(scales) # 用于处理坐标轴标签
library(tidyr)
library(dplyr)

if (!dir.exists("projects/TMDB/result")) dir.create("projects/TMDB/result")
pdf("projects/TMDB/result/movie_critic.pdf")

# 0. 读取数据
df_cleaned <- read.csv("data/TMDB/cleaned/tmdb_cleaned.csv")
df_cleaned <- df_cleaned |>
    filter(
        vote_average > 2,
        vote_count > 50, # 确保评分更有统计学上的意义
        revenue > 0,
        budget > 0
    ) # 清除过低评分的数据

# 1. 评分的分布
mean_vote <- mean(df_cleaned$vote_average, na.rm = TRUE)

ggplot(df_cleaned, aes(x = vote_average)) +
    geom_histogram(
        bins = 30,
        fill = "steelblue",
        color = "white"
    ) +
    geom_vline(
        xintercept = mean_vote,
        color = "black",
        linetype = "dashed",
        linewidth = 1
    ) +
    annotate("text",
        x = mean_vote + 0.5, y = 400,
        label = paste("Mean:", round(mean_vote, 2)), color = "#CC0000"
    ) +
    labs(
        title = "Distribution of Movie Ratings",
        subtitle = "Most movies cluster around 6-7 points",
        x = "Average Rating (IMDB Scale)",
        y = "Frequency"
    ) +
    theme_minimal()

# 2. 好口碑 = 高票房吗? (Correlation)
ggplot(df_cleaned, aes(x = vote_average, y = revenue, color = budget)) +
    geom_point(alpha = 0.4, size = 1.5) +
    scale_y_log10(labels = label_dollar()) +
    # 金融数据我们依然用 log 处理
    scale_color_gradient(
        low = "blue",
        high = "red",
        trans = "log10"
    ) +
    geom_smooth(method = "lm", se = TRUE, color = "black") +
    labs(
        title = "Do Higher Ratings Lead to Higher Revenue?",
        subtitle = "Color indicates production budget (log scale)",
        x = "Average Rating",
        y = "Revenue (log scale)",
        color = "budget"
    ) +
    theme_minimal()

# 3. 高分类型
## 2.1 数据拆分
df_genre <- df_cleaned |>
    # 将一行拆开成多行
    separate_rows(genres_clean, sep = ", ") |>
    # 重命名类型列名
    rename(genre = genres_clean) |>
    # 去除空值
    filter(genre != "")

## 2.2 数据聚合
genre_group <- df_genre |>
    # 按类别聚合
    group_by(genre) |>
    summarise(
        avg_vote = mean(vote_average),
        median_vote = median(vote_average),
        count = n(),
        sd_vote = sd(vote_average) # 计算标准差以观察稳定性
    ) |>
    filter(count > 10) # 过滤样本量太小的流派

## 2.3 绘制图表
ggplot(genre_group, aes(x = reorder(genre, avg_vote), y = avg_vote, fill = avg_vote)) +
    geom_col(show.legend = FALSE) +
    coord_flip() + # 横向条形图,方便阅读名称
    scale_fill_viridis_c(option = "magma", direction = -1) +
    labs(
        title = "Which Genres Win the Most Praise?",
        subtitle = "Average IMDB rating by genre",
        x = "Genre",
        y = "Mean Rating"
    ) +
    theme_minimal()

dev.off()
