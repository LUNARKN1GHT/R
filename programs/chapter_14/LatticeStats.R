library(lattice)

# 1. bwplot：箱线图
# 需求：对比不同档位的油耗分布
bwplot(factor(gear) ~ mpg,
    data = mtcars,
    notch = TRUE, # 加上切口，方便看中位数显著性
    xlab = "Miles Per Gallon"
)

# 2. histogram: 直方图
# 需求：看气温分布，按月份切片
histogram(~ Temp | factor(Month),
    data = airquality,
    layout = c(1, 5)
)
