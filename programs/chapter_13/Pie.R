# 饼图

# mtcars 数据实操
## 1. 准备数据
cyl_counts <- table(mtcars$cyl)

## 绘制基础饼图
pie(cyl_counts,
    main = "cyl Distribution",
    labels = paste(names(cyl_counts), "cyls"), # 自定义标签内容
    col = terrain.colors(3) # 使用内置的地形调色板
)

## 先计算百分比，然后再把标签贴上去
pct <- round(100 * cyl_counts / sum(cyl_counts), 1)
## 拼接标签：类别 + 百分比 + “%”
lab <- paste(names(cyl_counts), " (", pct, "%)", sep = "")

## 饼图
pie(cyl_counts,
    labels = lab,
    col = rainbow(length(cyl_counts)), # 使用彩虹色
    main = "with percentage"
)
