
source("plots/thesis-theme.R")

n <- 1000
y <- 
  MASS::mvrnorm(
    n = n, 
    mu = c(0, 0),
    Sigma = matrix(c(1, 0.75, 0.75, 1), nrow = 2)
  )

y3 <- rbind(y,y,y,y)

p2_marright <- 1 - plogis(y[,1])
p2_marleft <- plogis(y[,1])
p2_marmid <- 1 - plogis(0.75 - abs(y[,1]))
p2_martail <- 1 - plogis(0.75 + abs(y[,1]))

r2_marright <- rbinom(n, 1, p2_marright)
r2_marleft <- rbinom(n, 1, p2_marleft)
r2_marmid <- rbinom(n, 1, p2_marmid)
r2_martail <- rbinom(n, 1, p2_martail)

r2 <- c(r2_marright, r2_marleft, r2_martail, r2_marmid)
r2 <- factor(r2, labels = c("Yk", "Yg"))

typ <- factor(
  rep(1:4, each = n),
  labels = c("SAĞDANRK", "SOLDANRK", "UÇLARDANRK", "MERKEZDENRK")
)

df <- tibble(y1 = y3[,1], y2 = y3[,2], r2 = r2, typ = typ)

# Show mar models affects with boxplot
df %>%
  ggplot(aes(x = y2, y = r2, fill = r2)) +
  geom_boxplot() +
  labs(
    x = "Y",
    y = " ",
    color = "Kayıplık:"
  ) +
  expand_limits(x = c(-4, 4)) +
  scale_fill_manual(values = c("#BC243C", "#7FCDCD")) +
  theme_thesis() +
  theme(
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    legend.position = "none"
  ) +
  facet_wrap(typ ~ ., scale = "free_x", strip.position = "left", ncol = 1)

ggsave("marplotbox.pdf", device = cairo_pdf, width = 20, height = 19, units = "cm")

