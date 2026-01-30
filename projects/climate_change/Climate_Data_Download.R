# 自动下载全球气温汇总数据 (精简版)
url <- "https://raw.githubusercontent.com/datasets/global-temp/master/data/annual.csv"
climate_raw <- read.csv(url)

# 保存到本地 data 文件夹
write.csv(climate_raw, "data/climate_change/global_temp_annual.csv", row.names = FALSE)
