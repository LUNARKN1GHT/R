library(ggplot2)

# 1. 基础画布 + 映射 (Aesthetics)
p <- ggplot(data = mtcars, aes(x = wt, y = mpg))

# 2. 添加几何对象层 (Geometry)
p + geom_point()

# 3. 继续叠加：添加平滑曲线层 (Statistics) + 标签层 (Labs)
p + geom_point(aes(color = factor(cyl))) +
    geom_smooth(method = "lm") +
    labs(
        title = "wt & cyl",
        subtitle = "colored by cyl",
        x = "wt", y = "cyl"
    )
