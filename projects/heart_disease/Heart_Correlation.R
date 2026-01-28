pdf("projects/heart_disease/result/Correlation.pdf")
df <- read.csv("data/heart_disease/heart_cleaned.csv")

# 1. 热力相关矩阵：查看所有数值变量之间的凉凉相关性
library(dplyr)
df_numeric <- select_if(df, is.numeric)

cor_matrix <- cor(df_numeric)
# print(cor_matrix)

cor_matrix <- cor(df_numeric, use = "complete.obs")

library(ggcorrplot)
ggcorrplot(cor_matrix,
    hc.order = TRUE,
    type = "lower", # 显示下半部分
    lab = TRUE, # 显示数值
    lab_size = 3,
    method = "circle", # 用圆圈大小表示相关性强度
    colors = c("#6D9EC1", "white", "#E46726"), # 自定义高低颜色
    title = "Correlation",
    ggtheme = theme_minimal()
)

dev.off()
