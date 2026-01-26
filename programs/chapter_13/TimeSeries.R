# 时间序列绘图

# AirPassengers绘图
data(AirPassengers)

## 检查一下数据结构
## 数据并不是简单的 DataFrame，而是带周期的
print(AirPassengers)

## 最基础的时间序列图
plot(AirPassengers,
    main = "1949-1960 AirPassengers of international airlines",
    ylab = "passengers (thousand)",
    xlab = "year",
    col = "blue",
    lwd = 2 # lwd 控制线条粗细
)

## 序列的拆解
### 这里可以将数据拆成：趋势、季节性和噪声
### 拆解时间序列
decomposed_data <- decompose(AirPassengers)

### 直接绘图，R 会自动生成四份子图
plot(decomposed_data)


# 手动绘制 DataFrame 数据集
## 很多时候，我们的数据集都是从 CSV 里面读取进来的，并不是 ts对象。
## 这时候我们需要用到基础绘图里面的参数
## 这里用空气质量数据作为练习
library(tidyverse)

### 准备 5 月的数据
may_data <- airquality |> filter(Month == 5)

### 画折线图
plot(may_data$Day, may_data$Temp,
    type = "o", # type="l" 是纯线，"p" 是纯点，"o"是电线结合
    pch = 19, # 点的形状
    lty = 1, # 线的类型（1是实线，2是虚线）
    col = "darkred",
    main = "May Temperature",
    xlab = "date",
    ylab = "Temperature",
)

### 更进一步，可以加一条趋势线
lines(lowess(may_data$Day, may_data$Temp), col = "blue", lwd = 2)
