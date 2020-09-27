# Load packages and theme
source("plots/0-theme.R")

# Get simulation outputs
load("output.RData")

# Define labels for methods
labels_method <- c(
  `cca` = "TVA",
  `mean` = "Ortalama ataması",
  `norm.predict` = "Regresyon ataması",
  `norm.nob` = "Stokastik regresyon ataması",
  `pmm` = "PMM",
  `mice` = "MICE"
) %>% as_labeller()

# B1 Bias -----------------------------------------------------------------

df %>%
  filter(term == "b1") %>%
  ggplot(aes(x = props, y = est_bias, color = types)) +
  geom_line(size = 1) +
  geom_hline(yintercept = c(-5, 5), colour = "black", size = 0.5, linetype = "dashed") +
  labs(
    x = "Kayıp veri oranı",
    y = TeX("$\\hat{\\beta}_1$ YY")
  ) +
  scale_x_continuous(breaks = seq(0.1, 0.9, by = 0.2)) +
  scale_colour_manual(
    values = c("#29AB87", "#FFAA1D", "#D1395E"),
    guide = "legend",
    name = "Düzen:",
    labels = c("SAĞDANRK", "UÇLARDANRK", "MERKEZDENRK")
  ) +
  theme_thesis() +
  facet_wrap(~method, labeller = labels_method, scales = "free_x", ncol = 2)

ggsave("b1bias.pdf", device = cairo_pdf, width = 20, height = 25, units = "cm")

# B1 Coverage -----------------------------------------------------------------

df %>%
  filter(term == "b1") %>%
  ggplot(aes(x = props, y = coverage, color = types)) +
  geom_line(size = 1) +
  geom_hline(yintercept = 0.9, colour = "black", size = 0.5, linetype = "dashed") +
  expand_limits(y = 1) +
  scale_x_continuous(breaks = seq(0.1, 0.9, by = 0.2)) +
  labs(
    x = "Kayıp veri oranı",
    y = TeX("$\\hat{\\beta}_1$ KO")
  ) +
  scale_colour_manual(
    values = c("#29AB87", "#FFAA1D", "#D1395E"),
    guide = "legend",
    name = "Düzen:",
    labels = c("SAĞDANRK", "UÇLARDANRK", "MERKEZDENRK")
  ) +
  theme_thesis() +
  facet_wrap(~method, labeller = labels_method, scales = "free_x", ncol = 2)

ggsave("b1coverage.pdf", device = cairo_pdf, width = 20, height = 25, units = "cm")

# B1 Width ----------------------------------------------------------------

df %>%
  filter(term == "b1") %>%
  ggplot(aes(x = props, y = width, color = types)) +
  geom_line(size = 1) +
  labs(
    x = "Kayıp veri oranı",
    y = TeX("$\\hat{\\beta}_1$ OG")
  ) +
  scale_x_continuous(breaks = seq(0.1, 0.9, by = 0.2)) +
  scale_colour_manual(
    values = c("#29AB87", "#FFAA1D", "#D1395E"),
    guide = "legend",
    name = "Düzen:",
    labels = c("SAĞDANRK", "UÇLARDANRK", "MERKEZDENRK")
  ) +
  theme_thesis() +
  facet_wrap(~method, labeller = labels_method, scales = "free_x", ncol = 2)

ggsave("b1width.pdf", device = cairo_pdf, width = 20, height = 25, units = "cm")

# B2 Bias -----------------------------------------------------------------

df %>%
  filter(term == "b2") %>%
  ggplot(aes(x = props, y = est_bias, color = types)) +
  geom_line(size = 1) +
  geom_hline(yintercept = c(-5, 5), colour = "black", size = 0.5, linetype = "dashed") +
  labs(
    x = "Kayıp veri oranı",
    y = TeX("$\\hat{\\beta}_2$ YY")
  ) +
  scale_x_continuous(breaks = seq(0.1, 0.9, by = 0.2)) +
  scale_colour_manual(
    values = c("#29AB87", "#FFAA1D", "#D1395E"),
    guide = "legend",
    name = "Düzen:",
    labels = c("SAĞDANRK", "UÇLARDANRK", "MERKEZDENRK")
  ) +
  theme_thesis() +
  facet_wrap(~method, labeller = labels_method, scales = "free_x", ncol = 2)

ggsave("b2bias.pdf", device = cairo_pdf, width = 20, height = 25, units = "cm")

# B2 Coverage -------------------------------------------------------------

df %>%
  filter(term == "b2") %>%
  ggplot(aes(x = props, y = coverage, color = types)) +
  geom_line(size = 1) +
  geom_hline(yintercept = 0.9, colour = "black", size = 0.5, linetype = "dashed") +
  expand_limits(y = 1) +
  labs(
    x = "Kayıp veri oranı",
    y = TeX("$\\hat{\\beta}_2$ KO")
  ) +
  scale_x_continuous(breaks = seq(0.1, 0.9, by = 0.2)) +
  scale_colour_manual(
    values = c("#29AB87", "#FFAA1D", "#D1395E"),
    guide = "legend",
    name = "Düzen:",
    labels = c("SAĞDANRK", "UÇLARDANRK", "MERKEZDENRK")
  ) +
  theme_thesis() +
  facet_wrap(~method, labeller = labels_method, scales = "free_x", ncol = 2)

ggsave("b2coverage.pdf", device = cairo_pdf, width = 20, height = 25, units = "cm")

# B2 Width ----------------------------------------------------------------

df %>%
  filter(term == "b2") %>%
  ggplot(aes(x = props, y = width, color = types)) +
  geom_line(size = 1) +
  labs(
    x = "Kayıp veri oranı",
    y = TeX("$\\hat{\\beta}_2$ OG")
  ) +
  scale_x_continuous(breaks = seq(0.1, 0.9, by = 0.2)) +
  scale_colour_manual(
    values = c("#29AB87", "#FFAA1D", "#D1395E"),
    guide = "legend",
    name = "Düzen:",
    labels = c("SAĞDANRK", "UÇLARDANRK", "MERKEZDENRK")
  ) +
  theme_thesis() +
  facet_wrap(~method, labeller = labels_method, scales = "free_x", ncol = 2)

ggsave("b2width.pdf", device = cairo_pdf, width = 20, height = 25, units = "cm")

# B3 Bias -----------------------------------------------------------------

df %>%
  filter(term == "b3") %>%
  ggplot(aes(x = props, y = est_bias, color = types)) +
  geom_line(size = 1) +
  geom_hline(yintercept = c(-5, 5), colour = "black", size = 0.5, linetype = "dashed") +
  labs(
    x = "Kayıp veri oranı",
    y = TeX("$\\hat{\\beta}_3$ YY")
  ) +
  scale_x_continuous(breaks = seq(0.1, 0.9, by = 0.2)) +
  scale_colour_manual(
    values = c("#29AB87", "#FFAA1D", "#D1395E"),
    guide = "legend",
    name = "Düzen:",
    labels = c("SAĞDANRK", "UÇLARDANRK", "MERKEZDENRK")
  ) +
  theme_thesis() +
  facet_wrap(~method, labeller = labels_method, scales = "free_x", ncol = 2)

ggsave("b3bias.pdf", device = cairo_pdf, width = 20, height = 25, units = "cm")

# B3 Coverage -------------------------------------------------------------

df %>%
  filter(term == "b3") %>%
  ggplot(aes(x = props, y = coverage, color = types)) +
  geom_line(size = 1) +
  geom_hline(yintercept = 0.9, colour = "black", size = 0.5, linetype = "dashed") +
  expand_limits(y = 1) +
  labs(
    x = "Kayıp veri oranı",
    y = TeX("$\\hat{\\beta}_3$ KO")
  ) +
  scale_x_continuous(breaks = seq(0.1, 0.9, by = 0.2)) +
  scale_colour_manual(
    values = c("#29AB87", "#FFAA1D", "#D1395E"),
    guide = "legend",
    name = "Düzen:",
    labels = c("SAĞDANRK", "UÇLARDANRK", "MERKEZDENRK")
  ) +
  theme_thesis() +
  facet_wrap(~method, labeller = labels_method, scales = "free_x", ncol = 2)

ggsave("b3coverage.pdf", device = cairo_pdf, width = 20, height = 25, units = "cm")

# B3 Width ----------------------------------------------------------------

df %>%
  filter(term == "b3") %>%
  ggplot(aes(x = props, y = width, color = types)) +
  geom_line(size = 1) +
  labs(
    x = "Kayıp veri oranı",
    y = TeX("$\\hat{\\beta}_3$ OG")
  ) +
  scale_x_continuous(breaks = seq(0.1, 0.9, by = 0.2)) +
  scale_colour_manual(
    values = c("#29AB87", "#FFAA1D", "#D1395E"),
    guide = "legend",
    name = "Düzen:",
    labels = c("SAĞDANRK", "UÇLARDANRK", "MERKEZDENRK")
  ) +
  theme_thesis() +
  facet_wrap(~method, labeller = labels_method, scales = "free_x", ncol = 2)

ggsave("b3width.pdf", device = cairo_pdf, width = 20, height = 25, units = "cm")

# R2 Bias -----------------------------------------------------------------

df %>%
  ggplot(aes(x = props, y = r2_bias, color = types)) +
  geom_line(size = 1) +
  geom_hline(yintercept = c(-5, 5), colour = "black", size = 0.5, linetype = "dashed") +
  labs(
    x = "Kayıp veri oranı",
    y = TeX("$R^2$ YY")
  ) +
  scale_x_continuous(breaks = seq(0.1, 0.9, by = 0.2)) +
  scale_colour_manual(
    values = c("#29AB87", "#FFAA1D", "#D1395E"),
    guide = "legend",
    name = "Düzen:",
    labels = c("SAĞDANRK", "UÇLARDANRK", "MERKEZDENRK")
  ) +
  theme_thesis() +
  facet_wrap(~method, labeller = labels_method, scales = "free_x", ncol = 2)

ggsave("r2bias.pdf", device = cairo_pdf, width = 20, height = 25, units = "cm")
