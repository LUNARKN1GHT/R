df <- read.csv("data/heart_disease/heart_cleaned.csv")

linear_model <- glm(target ~ .,
    data = df,
    family = "binomial"
)

summary(linear_model)

sink("projects/heart_disease/result/Linear_model.txt")
print(summary(linear_model))
sink()

# 预测患病概率
pred_prob <- predict(linear_model,
    type = "response"
)

# 设定阈值，大于0.5认为是患病
pred_class <- ifelse(pred_prob >= 0.5, 1, 0)

# 计算准确率
accuracy <- mean(pred_class == df$target)
print(accuracy)

# 生成混淆矩阵
conf_matrix <- table(Predicted = pred_class, Actual = df$target)
sink("projects/heart_disease/result/conf_matrix.txt")
print(conf_matrix)
sink()
