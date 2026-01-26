# 散点图

# 教材上一直在用 nutshell 这个包，但好像已经是老古董不能用了。
# 这里是让 Gemini 老师结合教材内容进行讲解。内容现代而且使用。
# 如果上课老师坚持用的话，那就还是跟着老师学吧。

# mtcars 数据集绘图：
## x轴是重量（wt）， y轴是油耗（mpg）
## 下面这个是最基础的一个图像
plot(mtcars$wt, mtcars$mpg)

## 不难看到上面的图表十分简陋，我们可以通过调参来美化一下
plot(mtcars$wt, mtcars$mpg,
    main = "wt & mpg",
    xlab = "wt (1000 lbs)",
    ylab = "mpg",
    pch = 19, # 实心圆点
    col = "steelblue", # 使用颜色名称或十六进制
    cex = 1.5 # 点放大 1.5 倍
)

## 接着上面的图，我们手动标出一个特殊的点（比如最重的那辆车）
## 假设我们要标出重量大于 5 的车，变红
points(mtcars$wt[mtcars$wt > 5], mtcars$mpg[mtcars$wt > 5],
    col = "red", pch = 19, cex = 2
)

## 加一条平均油耗的水平虚线
abline(h = mean(mtcars$mpg), col = "darkgray", lty = 2) # lty = 2 表示虚线

## 最后添加文字标注
text(5.3, 15, "overweight", pos = 4, col = "red")

# 函数中各个变量的不同变量可在书上找到
