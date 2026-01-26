# 3D 数据图

# 基础 3D 透视图
# 这非常适合表现数学函数或者地理等高线
## 使用内置的火山地形数据 volcano
x <- 10 * (1:nrow(volcano))
y <- 10 * (1:ncol(volcano))

res <- persp(x, y, volcano,
    theta = 135, phi = 30,
    col = "green3", scale = FALSE,
    ltheta = -120, shade = 0.75,
    main = "Auckland volcano",
    border = NA
)
