# 函数

# 函数是 R 中的一个特殊对象，他接受一些输入对象，并返回一个输出对象。

# 简洁赋值函数
apples <- 3
# 赋值操作的函数形式
"<-"(apples, 3)
"<-"(oranges, 4)
apples
# 四则运算的函数形式
"+"(apples, oranges)
# if-then语句的函数形式
"if"(apples > oranges, "apples are better", "oranges are better")

# 在赋值语句中，对象会被复制
print("对象会复制")
u <- list(1)
v <- u
u[[1]] <- "hat"
u
