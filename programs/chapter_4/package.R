# R 包概览

# R 包和 python 里面的大差不差

# 列示本地库中的 R 包
print("=====列示本地库中的 R 包=====")
getOption("defaultPackages")

# 如果想要查看当前已加载的所有 R 包清单，可以使用如下指令
print("=====查看当前已加载的所有 R 包清单=====")
(.packages())

# 查看所有已安装的 R 包清单
print("=====查看所有已安装的 R 包清单=====")
(.packages(all.available = TRUE))

# 在 R 中加载包
print("=====在 R 中加载包=====")
library(rpart)
