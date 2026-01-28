# 1. 验证：心脏病患者和健康人的最大心率均值是否有显著差异
df <- read.csv("data/heart_disease/heart_cleaned.csv")

df$target <- factor(df$target,
    level = c(0, 1),
    labels = c("Healthy", "Disease")
)

# 检验平均值
tt <- t.test(thalach ~ target, data = df)
# 保存检验结果
sink("projects/heart_disease/result/t_test_thalach.txt")
print(tt)
sink()


# 2. 验证：性别和患心脏病是否有关联
co_table <- table(df$sex, df$target) # 创建列联表
ct <- chisq.test(co_table, correct = TRUE)
# 保存检验结果
sink("projects/heart_disease/result/Chi-squared_sex.txt")
print(ct)
sink()
