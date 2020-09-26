source("plots/thesis-theme.R")

pdf(file = "reg3Dplot.pdf", width = 6.6, height = 4.4)

dm <-
  mvrnorm(
    n = 100,
    mu = c(0, 0, 0),
    Sigma = matrix(
      data = c(
        1.00, 0.55, 0.50,
        0.55, 1.00, 0.55,
        0.50, 0.55, 1.00
      ),
      nrow = 3,
      byrow = TRUE
    )
  )

x <- dm[, 1]
y <- dm[, 2]
z <- dm[, 3]
fit <- lm(y ~ x + z)

# scatterplot
s3d <-
  scatterplot3d(
    x, z, y,
    pch = 19,
    type = "p",
    color = "#0EB6D1",
    lwd = 5,
    grid = TRUE,
    box = FALSE,
    xlab = TeX("x_{1}"),
    ylab = TeX("x_{2}"),
    zlab = TeX("y")
  )

# compute locations of segments
orig <- s3d$xyz.convert(x, z, y)
plane <- s3d$xyz.convert(x, z, fitted(fit))
i_negpos <- 1 + (resid(fit) > 0) # which residuals are above the plane?

# draw residual distances to regression plane
segments(
  orig$x, orig$y, plane$x, plane$y,
  col = "black", lty = c(2, 1)[i_negpos], lwd = 1.5
)

# draw the regression plane
s3d$plane3d(
  fit,
  draw_polygon = TRUE,
  draw_lines = TRUE,
  polygon_args = list(col = rgb(.9, .1, .3, .6))
)

# redraw positive residuals and segments above the plane
wh <- resid(fit) > 0
segments(
  orig$x[wh], orig$y[wh], plane$x[wh], plane$y[wh],
  col = "black", lty = 1, lwd = 1.5
)

s3d$points3d(
  x[wh], z[wh], y[wh],
  pch = 19, col = "#042f66", lwd = 5
)

dev.off()
