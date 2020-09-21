
source("plots/thesis-theme.R")

df <-
  mvrnorm(
    n = 100,
    mu = c(3, 3),
    Sigma = matrix(c(1, 0.75, 0.75, 1), nrow = 2)
  ) %>%
  data.frame() %>%
  tibble()

fit <- lm(X1 ~ X2, data = df)
df <- transform(df, Fitted = fitted(fit))

df %>%
  ggplot(aes(X2, X1)) +
  geom_point(color = "#0EB6D1", size = 4) +
  geom_abline(
    intercept = coef(fit)[1],
    slope = coef(fit)[2],
    color = "#D1395E",
    size = 2
  ) +
  geom_segment(aes(x = X2, y = X1, xend = X2, yend = Fitted)) +
  expand_limits(x = 0, y = 0) +
  labs(x = "x", y = "y") +
  theme_thesis() 

ggsave("regplot.pdf", device = cairo_pdf, width = 20, height = 12, units = "cm")

