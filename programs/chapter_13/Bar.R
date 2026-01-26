# 柱状图

# 和 python 中不同
# 在 R 中绘制柱状图需要先统计后绘图

# 刹车距离与汽车重量的关系
## 1. 统计频数
## table() 函数会生成一个频数表
cyl_counts <- table(mtcars$cyl)
print(cyl_counts)

## 2. 绘图
barplot(cyl_counts,
    main = "Cars Distribution",
    xlab = "cyls",
    ylab = "cars",
    col = "lightblue"
)

## R 中还可以给每根柱子添不同的颜色
barplot(cyl_counts,
    main = "Cars Distribution",
    xlab = "cyls",
    ylab = "cars",
    col = c("red", "green", "blue"), # 循环颜色
    border = "darkgray", # 边框颜色
    horiz = TRUE, # 横向柱状图
)

# 分组柱状图与堆叠柱状图
## 创建一个二维频数表
counts <- table(mtcars$am, mtcars$cyl)
rownames(counts) <- c("auto", "am")
print(counts)

## 默认是堆叠柱状图
barplot(counts,
    main = "cyl & type",
    col = c("coral", "skyblue"),
    legend = rownames(counts) # 自动添加图例
)

## 分组柱状图与堆叠柱状图
barplot(counts,
    main = "group",
    col = c("coral", "skyblue"),
    beside = TRUE, # 关键参数：并列排布
    legend = rownames(counts)
)
