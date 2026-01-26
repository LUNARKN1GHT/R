# 分布图

# 1. 直方图
# 使用 airquality 数据集中的气温 Temp
data(airquality)

# 基础直方图
hist(airquality$Temp,
    main = "NY Temp",
    xlab = "Temp(F)",
    ylab = "Frequency",
    col = "skyblue",
    border = "white",
    breaks = 12 # 控制柱子数量
)

# 2. 核密度图
## 先计算密度对象，再进行绘图
## 2.1 计算密度对象
d <- density(airquality$Temp, na.rm = TRUE)

## 2.2 绘图
plot(d,
    main = "Temp distribution",
    xlab = "Temp(F)",
    ylab = "density",
    col = "red",
    lwd = 2
)

## 2.3 进阶技巧，给密度线下面的其余填充颜色
polygon(d, col = "mistyrose", border = "red")

# 箱线图
## 基础箱线图
boxplot(airquality$Temp,
    main = "Temp boxplot",
    ylab = "Temp (F)",
    col = "gold"
)

## 分类箱线图
## 可以看到不同月份的温度分布对比
boxplot(Temp ~ Month,
    data = airquality,
    main = "Temp compared by month",
    xlab = "month",
    ylab = "Temp (F)",
    col = c("lightblue", "lightgreen", "lightyellow", "lightpink", "lightcyan")
)

# 直方图和密度图放在一起对比
hist(airquality$Temp, freq = FALSE, col = "lightgray", main = "compound plot")
lines(density(airquality$Temp, na.rm = TRUE), col = "blue", lwd = 2)
rug(airquality$Temp)
