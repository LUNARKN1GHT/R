# Lattice 基础绘图
library(lattice)

# 1. xyplot: Lattice的全能选手（散点与折线）
# 需求：看马力与油耗的关系，按气缸分面板
xyplot(mpg ~ hp | factor(cyl),
    data = mtcars,
    main = "Lattice Basic: scatter plot",
    type = c("p", "smooth"), # p 为点，smooth 为拟合曲线
    grid = TRUE
)
