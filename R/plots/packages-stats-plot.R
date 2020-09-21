
source("plots/thesis-theme.R")

# Get CRAN stats for packages and tidy it
packs <- 
  dlstats::cran_stats(
    packages = c("mice", "mi", "Amelia", "pan"),
    use_cache = TRUE
  ) %>%
  select(-start) %>%
  filter(end != lubridate::today())

# Total downloads for packages by months
ggplot(packs, aes(x = end, y = downloads, color = package)) +
  geom_line(size = 1) +
  labs(
    x = "Yıllar",
    y = "Aylık toplam indirilme sayısı",
    color = "Paketler"
  ) +
  scale_colour_thesis() +
  theme_thesis()

ggsave("packagesplot.pdf", device = cairo_pdf, width = 18, height = 12, units = "cm")

