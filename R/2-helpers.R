# Generate data
data_gen <- function() {
  comp_data <-
    mvrnorm(
      n = 1000,
      mu = c(0, 0, 0, 0),
      Sigma = matrix(
        data = c(
          1.00, 0.75, 0.50, 0.25,
          0.75, 1.00, 0.25, 0.00,
          0.50, 0.25, 1.00, 0.00,
          0.25, 0.00, 0.00, 1.00
        ),
        nrow = 4,
        byrow = TRUE
      )
    ) %>%
    data.frame() %>%
    as_tibble()
}

# Ampute data
amp <- function(i, j) {
  data_gen() %>%
    ampute(prop = i, type = j) %>%
    .$amp
}

# True model
true_model <- function() {
  fit <- lm(X1 ~ X2 + X3 + X4, data = data_gen())
  true_summary <-
    fit %>%
    tidy() %>%
    bind_cols(
      fit %>%
        confint() %>%
        as_tibble() %>%
        rename("conf_lower" = "2.5 %", "conf_upper" = "97.5 %")
    ) %>%
    mutate(
      r2 = fit %>%
        glance() %>%
        .$r.squared,
      term = c("b0", "b1", "b2", "b3")
    )
  true_summary
}
