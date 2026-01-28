# 创建存放路径和报告名称
pdf("projects/heart_disease/result/EDA.pdf")

# 1. 目标变量的分布
# 首先我们要知道，样本里患病的和正常的人数比例
library(ggplot2)

df <- read.csv("data/heart_disease/heart_cleaned.csv")

# print(df) # 随手检查数据集是个好习惯

# 转换 target 为因子方便绘图
df$target <- factor(df$target,
    levels = c(0, 1),
    labels = c("Healthy", "Disease")
)

ggplot(df, aes(x = target, fill = target)) +
    geom_bar() +
    theme_minimal() +
    labs(title = "Target Distribution", y = "Count")

# 2. 年龄与心脏病的关系（直方图/密度图）
ggplot(df, aes(x = age, fill = target)) +
    geom_density(alpha = 0.5) + # alpha 设置透明度，方面重叠观察
    theme_classic() +
    labs(title = "Age distribution under different target")

# 3. 性别与心脏病
# 转换性别因子
df$sex <- factor(df$sex,
    levels = c(0, 1),
    labels = c("Female", "Male")
)

ggplot(df, aes(x = sex, fill = target)) +
    geom_bar(position = "fill") + # “fill” 会显示比例，而不是绝对人数
    labs(title = "Sex distribution under sex", y = "Ratio")

# 4. 最大心率和心脏病的关系
ggplot(df, aes(x = thalach, fill = target)) +
    geom_density(alpha = 0.5) +
    theme_classic() +
    labs(title = "thalach & target", x = "thalach", fill = "target")

# 结尾务必记得关闭，释放内存
dev.off()
