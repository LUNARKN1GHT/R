library(tidyverse)

# 1. 加载数据
netflix <- read_csv("./data/netflix_titles.csv")

# 2. 查看结构
glimpse(netflix) # 快速查看列名和数据类型

# 3. 统计缺失值（NA）
# 检查哪些列是不完整的
# 从输出结果来看，我们可以看到两列的缺失值较多：director: 2634, cast: 825
# 这意味着我们分析其他列是比较可靠的
colSums(is.na(netflix))

# 4. 数据清洗与处理
## 4.1 Netflix 上到底是电影多还是剧集多？
type_counts <- netflix |>
    group_by(type) |>
    summarise(count = n()) |>
    mutate(percentage = count / sum(count) * 100)

print(type_counts)
## 结果应该看到是电影更多

# 4.2 提取年份并筛选
## 这里假设我们只想分析 2010 年之后上线的资源
netflix_recent <- netflix |>
    filter(release_year >= 2010)

print(netflix_recent)

# 5. 内容可视化
## 5.1 历年内容产量趋势图（折线图）
netflix |>
    group_by(release_year, type) |>
    summarise(n = n()) |>
    filter(release_year >= 2000 & release_year <= 2021) |>
    ggplot(aes(x = release_year, y = n, color = type)) +
    geom_line(size = 1) +
    geom_point() +
    theme_minimal() +
    labs(
        title = "2000-2021 Netflix increase tend",
        x = "release year", y = "counts"
    )


netflix |>
    filter(!is.na(country)) |>
    count(country, sort = TRUE) |>
    head(10) |>
    ggplot(aes(x = reorder(country, n), y = n)) +
    geom_col(fill = "darkred") +
    coord_flip() + # 横轴纵轴反转，方便阅读长国家名
    theme_minimal() +
    labs(
        title = "Netflix counts Top 10 country",
        x = "Country", y = "counts"
    )

## 5.3 电影时长的分布
### 提取电影时长
movie_duration <- netflix |>
    filter(type == "Movie", !is.na(duration)) |>
    mutate(duration_min = as.numeric(gsub(" min", "", duration)))

### 绘制分布图
ggplot(movie_duration, aes(x = duration_min)) +
    geom_histogram(aes(y = ..density..), bins = 30, fill = "indianred", alpha = 0.7) +
    geom_density(color = "blue", size = 1) +
    stat_function(
        fun = dnorm,
        args = list(
            mean = mean(movie_duration$duration_min, na.rm = T),
            sd = sd(movie_duration$duration_min, na.rm = T)
        ),
        color = "black", linetype = "dashed"
    ) +
    labs(titile = "Netflix duration distribution", subtitle = "Blue is real density")

### 绘制热力图
top_countries <- netflix |>
    count(country, sort = TRUE) |>
    head(10) |>
    pull(country)
top_genres <- netflix |>
    count(listed_in, sort = TRUE) |>
    head(10) |>
    pull(listed_in)

netflix |>
    filter(country %in% top_countries, listed_in %in% top_genres) |>
    count(country, listed_in) |>
    ggplot(aes(x = country, y = listed_in, fill = n)) +
    geom_tile() +
    scale_fill_gradient(low = "white", high = "darkred") +
    theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
    labs(title = "Country and themes")

# 6. 统计分析
## 6.1. 卡方检验
### 6.1.1 准备交叉表
### 筛选出最主要的几个分级避免干扰
rating_type_table <- netflix |>
    filter(rating %in% c("TV-MA", "TV-14", "TV-PG", "R", "PG-13")) |>
    table(.$type, .$rating)

### 6.1.2 执行卡方检验
#### H0: 作品类型与分级相互独立
#### H1: 作品类型与分级存在显著相关性
chisq_result <- chisq.test(rating_type_table)
print(chisq_result)
