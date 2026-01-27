library(lattice)

# 1. Grouping: 不分面板，但在同张图里用颜色区分
# 需求：在同一张图里看 Temp vs Wind，用颜色区分 Month
xyplot(Temp ~ Wind,
    groups = Month,
    data = airquality,
    auto.key = list(space = "right"), # 自动生成右侧图例
    main = "Lattice Group Plot"
)

# 2. cloud：Lattice 的 3D 散点图
cloud(mpg ~ hp * wt,
    data = mtcars,
    screen = list(z = 40, x = -60), # 调整观察视角
    col = "steelblue"
)
