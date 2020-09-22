# If a package is installed, it will be loaded. If any are not,
# the missing package(s) will be installed and loaded.

# Required packages
# Do not change the order and prevent conflicts!
packages <- c(
  "MASS",
  "tidyverse",
  "mice",
  "broom",
  "latex2exp",
  "Cairo",
  "scatterplot3d"
)

# Install package if it is not installed yet
installed_packages <- packages %in% rownames(installed.packages())
if (any(installed_packages == FALSE)) {
  install.packages(packages[!installed_packages])
}

# Load packages
invisible(lapply(packages, library, character.only = TRUE))

# Clean global environment
rm(packages, installed_packages)
