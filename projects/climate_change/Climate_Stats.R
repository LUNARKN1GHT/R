library(dplyr)
pdf("projects/climate_change/result/climate_trend.pdf")
climate_df <- read.csv("data/climate_change/climate_change_cleaned.csv")

climate_df <- climate_df |>
    mutate(
        period = ifelse(Year < 1980, "Before 1980", "After 1980")
    )

model_all <- lm(Mean ~ Year, data = climate_df)
summary(model_all)

model_period <- lm(Mean ~ Year * period, data = climate_df)
summary(model_period)

library(ggplot2)

ggplot(climate_df, aes(x = Year, y = Mean, color = period)) +
    geom_point(alpha = 0.5) +
    geom_smooth(method = "lm", se = FALSE) +
    labs(
        title = "Trend in Mean Temperature Over Time",
        color = "Period"
    ) +
    theme_minimal()

dev.off()
