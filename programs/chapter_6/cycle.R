# 循环

# R 语言中有几种调用循环的方式
i <- 5
repeat {
    if (i > 25) {
        break
    } else {
        print(i)
        i <- i + 5
    }
}

j <- 5
while (j <= 25) {
    print(j)
    j <- j + 5
}

for (k in seq(from=5, to=25, by=5)) {
    print(k)
}