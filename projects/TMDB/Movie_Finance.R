library(ggplot2)
library(scales) # 用于处理坐标轴标签
library(tidyr)
library(dplyr)

if (!dir.exists("projects/TMDB/result")) dir.create("projects/TMDB/result")

pdf("projects/TMDB/result/movie_finance.pdf")

# 0. 读取数据
df_final <- read.csv("data/TMDB/cleaned/tmdb_cleaned.csv")

# 1. 预算 vs 票房 散点图
ggplot(df_final, aes(x = budget, y = revenue)) +
    geom_point(aes(color = roi), alpha = 0.5) +
    # 使用对数坐标轴, 这是处理金融数据的常用技巧
    scale_x_log10(labels = label_dollar()) +
    scale_y_log10(labels = label_dollar()) +
    # 添加趋势线
    geom_smooth(method = "lm", color = "black", linetype = "dashed") +
    scale_color_gradient(low = "blue", high = "red", trans = "log10") +
    labs(
        title = "Budget and Revenue",
        subtitle = "Log scale axis",
        x = "Budget (Log10)", y = "Revenue (Log10)", color = "ROI"
    ) +
    theme_minimal()

# 2. 流派财富榜
## 2.1 拆解数据
df_genre <- df_final |>
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
        avg_roi = mean(roi),
        median_roi = median(roi),
        count = n()
    ) |>
    filter(count > 10) # 过滤样本量太小的流派

## 2.3 数据可视化: 中位数 ROI 排行榜
ggplot(genre_group, aes(x = reorder(genre, median_roi), y = median_roi)) +
    geom_col(fill = "steelblue") +
    coord_flip() + # 横向条形图,方便阅读名称
    labs(
        title = "Who is key to Hollywood?",
        subtitle = "ROI rank",
        x = "Genre", y = "Mid ROI"
    ) +
    theme_minimal()
dev.off()
