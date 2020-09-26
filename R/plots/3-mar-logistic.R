source("plots/thesis-theme.R")

grid <- rnorm(1000)
mr <- plogis(grid)
ml <- 1 - mr
mm <- plogis(0.75 - abs(grid))
mt <- plogis(-0.75 + abs(grid))

miss <-
  c(
    rep("RIGHT", length(grid)),
    rep("LEFT", length(grid)),
    rep("MID", length(grid)),
    rep("TAIL", length(grid))
  ) %>%
  factor(levels = c("RIGHT", "LEFT", "TAIL", "MID"))

df <-
  tibble(
    x = rep(grid, 4),
    y = c(mr, ml, mm, mt),
    t = miss
  )

# Logistic cumulative density plot
df %>%
  ggplot(aes(x, y, color = t)) +
  geom_point(size = 2) +
  labs(
    x = "Kayıplık eşdeğişkeni",
    y = "Kayıp olma olasılığı"
  ) +
  theme_thesis() +
  scale_colour_manual(
    values = c("#29AB87", "#1979a9", "#FFAA1D", "#D1395E"),
    guide = "legend",
    name = "Düzen:",
    labels = c("SAĞDANRK", "SOLDANRK", "UÇLARDANRK", "MERKEZDENRK")
  )

ggsave("mardistplot.pdf", device = cairo_pdf, width = 20, height = 12, units = "cm")
