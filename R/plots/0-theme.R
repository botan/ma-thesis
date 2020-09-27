# Load packages
source("1-imports.R")

# Thesis theme
theme_thesis <- function() {
  theme_bw(
    base_size = 12,
    base_family = "Helvetica"
  ) +
    theme(
      axis.title = element_text(size = 14),
      strip.background = element_blank(),
      strip.text = element_text(size = 14),
      legend.key = element_rect(fill = "NA", size = 6, colour = "NA"),
      legend.position = "bottom",
      legend.box = "horizontal",
      legend.title = element_text(size = 14, face = "italic"),
      legend.text = element_text(size = 12),
      axis.ticks = element_line(colour = "grey10", size = 0.1),
      panel.grid.major = element_blank(),
      panel.grid.minor = element_blank()
    )
}
