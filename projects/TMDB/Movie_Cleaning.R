library(tidyverse)
library(jsonlite) # json 文件处理起来会比较麻烦，这里用一个包

# 1. 加载原始数据
movies <- read.csv("data/TMDB/tmdb_5000_movies.csv")
credits <- read.csv("data/TMDB/tmdb_5000_credits.csv")

# 2. 合并表格
# 注意：两张表的 ID 列名可能略有不同，检查后再合并
df_combined <- movies |>
    inner_join(credits, by = c("id" = "movie_id"))

# 3. 编写一个函数来提取 JSON 中的名称
parse_json_column <- function(json_str) {
    # 解析 JSON 字符串，提取 "name" 字段并用逗号连接
    # tryCatch 用于处理空置或格式错误的行
    tryCatch(
        {
            data <- fromJSON(json_str)
            return(paste(data$name, collapse = ", "))
        },
        error = function(e) {
            return(NA)
        }
    )
}

# 4. 应用解析函数 (先处理 genres 和 keywords 列)
df_combined <- df_combined |>
    mutate(
        genres_clean = sapply(genres, parse_json_column),
        keywords_clean = sapply(keywords, parse_json_column)
    )

# 5. 深度清理：处理异常值
df_final <- df_combined |>
    # 剔除预算或票房为 0 的电影
    # 这里我们将阈值调整到了10000, 避免混入一些奇奇怪怪的东西
    filter(budget > 10000 & revenue > 10000) |>
    # 计算 ROI (投资回报率)
    mutate(roi = (revenue - budget) / budget) |>
    # 只保留我们关心的列,精简文件体积
    select(
        id, title.x, budget, revenue, roi, release_date,
        vote_average, vote_count, genres_clean, keywords_clean
    )

# 6. 保存干净的数据集
# 创建文件夹
if (!dir.exists("data/TMDB/cleaned")) dir.create("data/TMDB/cleaned")
write.csv(df_final, "data/TMDB/cleaned/tmdb_cleaned.csv", row.names = FALSE)

# 附加: 查看 TOP ROI 的电影
df_final |>
    select(title.x, budget, revenue, roi) |>
    arrange(desc(roi)) |>
    head(10)
