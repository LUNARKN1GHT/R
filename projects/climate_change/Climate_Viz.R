library(ggplot2)

pdf("projects/climate_change/result/climate_viz.pdf")

climate_df <- read.csv("data/climate_change/climate_change_cleaned.csv")

# 1. 趋势对比图
ggplot(climate_df, aes(x = Year)) +
    # 原始数据用浅色点表示
    geom_point(aes(y = Mean), alpha = 0.3, color = "gray") +
    # 10年滚动平均线用彩色粗线表示，增强视觉冲击
    geom_line(aes(y = mean_10, color = mean_10), size = 1.2) +
    # 零度基准线
    geom_hline(yintercept = 0, linetype = "dashed", col = "black") +
    scale_color_gradient2(low = "blue", mid = "darkgray", high = "red", midpoint = 0) +
    labs(
        title = "Global warming trend (1880-2023)",
        x = "Year", y = "Temp differ from average"
    ) +
    theme_minimal()


# 2. 气候条纹图
ggplot(climate_df, aes(x = Year, y = 1, fill = Mean)) +
    geom_tile() + # tile 会填满矩形空间
    scale_fill_gradient2(low = "blue", mid = "white", high = "red", midpoint = 0) +
    theme_void() +
    theme(
        plot.title = element_text(hjust = 0.5, size = 15, vjust = -1),
        legend.position = "bottom"
    ) +
    labs(title = "Warming Stripes: 1880 - 2023", fill = "Temp differ from avg")

dev.off()
