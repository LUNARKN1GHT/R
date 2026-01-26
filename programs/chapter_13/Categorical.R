# 分类数据图

# 1. 棘状态图
spineplot(
    factor(am) ~ factor(cyl),
    data = mtcars,
    main = "Spinogram: cyl and am",
    xlab = "cyls", ylab = "am(1) vs auto(0)",
    col = c("lightgray", "skyblue")
)

# 2. 马赛克图
data(Titanic)
mosaicplot(Titanic,
    main = "Titanic survival",
    color = TRUE
)

# 3. 点图
df_sub <- mtcars[1:10.]
dotchart(
    df_sub$mpg,
    labels = row.names(df_sub),
    cex = 0.8,
    main = "petrol costs",
    xlab = "Miles Per Gallon"
)

# 4. 四瓣图
admission <- UCBAdmissions[, , 1]
fourfoldplot(
    admission,
    color = c("pink", "lightblue"),
    main = "Berkeley admission"
)
