# 定制 R 包

# 包也可以是我们自己定制的
# 通过 package.skeleton() 创建一个合适的目录结构
print("=====创建一个目录结构=====")
package.skeleton(
    name = "anRpackage", list,
    environment = .GlobalEnv, path = ".", force = FALSE, namespace = FALSE,
    code_files = character()
)
