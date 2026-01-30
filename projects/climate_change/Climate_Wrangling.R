# 加载我们要用的两个包
library(zoo)
library(dplyr)

# 1. 读取数据文件
climate_df <- read.csv("data/climate_change/global_temp_annual.csv")
# print(climate_df)

# 2. 清洗与计算
climate_df <- climate_df |>
    filter(Source == "GISTEMP") |>
    arrange(Year) |>
    mutate(
        fill = NaN, # 用于填充窗口不足而产生的空位，保证长度一致
        mean_10 = rollmean(Mean, k = 10, fill = NaN, align = "right")
    )

# 3. 检查数据并存储
glimpse(climate_df)
write.csv(
    climate_df,
    "data/climate_change/climate_change_cleaned.csv"
)
