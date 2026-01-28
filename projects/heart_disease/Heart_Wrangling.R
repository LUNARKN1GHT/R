# Heart_Wrangling 导入数据并格式化

# 定义列名
column_names <- c(
    "age", "sex", "cp", "trestbps", "chol", "fbs", "restecg",
    "thalach", "exang", "oldpeak", "slope", "ca", "thal", "target"
)

# 直接从 UCI 官网读取克利夫兰的数据
# na.strings = "?" 非常关键，因为这个数据里的缺失值是用问号表示的
url <- "https://archive.ics.uci.edu/ml/machine-learning-databases/heart-disease/processed.cleveland.data"
heart_data <- read.csv(
    url,
    header = FALSE,
    col.names = column_names,
    na.strings = "?" # 数据中的缺失值是用问号表示的
)

# 观察一下数据
library(tidyverse)
glimpse(heart_data)

# 检查缺失值
# 应该可以看到 ca; 4, thal:2, 其余列都没有缺失值
colSums(is.na(heart_data))

# 因为这里缺失值比较少，我们执行以下操作直接删除
# 再次检查数据集，发现缺失值统计都变成了0
heart_data <- na.omit((heart_data))
colSums(is.na(heart_data))

# 在进行分析之前，我们进行一次因子化，所有有病都归到1，无病归为0
heart_data$target <- ifelse(
    heart_data$target == 0,
    0,
    1
)
# glimpse(heart_data$target)

# 最后，我们保存数据
write.csv(
    heart_data,
    "data/heart_disease/heart_cleaned.csv",
    row.names = FALSE
)
