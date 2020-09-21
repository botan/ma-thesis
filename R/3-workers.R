
# Complete case analyze
cca <- function(i, j) {
  fit <- lm(X1 ~ X2 + X3 + X4, data = amp(i, j))
  true_summary <- true_model()
  ccm_summary <- 
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
      term = c("b0", "b1", "b2", "b3"),
      r2_bias = 100 * ((r2 - true_summary$r2) / true_summary$r2),
      est_bias = 100 * ((estimate - true_summary$estimate) / true_summary$estimate),
      coverage = as.integer(
        ((conf_lower < true_summary$estimate) & (true_summary$estimate < conf_upper))
      ),
      width = (conf_upper - conf_lower)
    )
  ccm_summary
}

# Single imputation
single_imp <- function(i, j, k) {
  imp <- mice(
    data = amp(i, j),
    method = k, 
    m = 1, 
    maxit = 1,
    print = FALSE
  ) %>%
    complete()
  fit <- lm(X1 ~ X2 + X3 + X4, data = imp)
  true_summary <- true_model()
  imp_summary <- 
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
      term = c("b0", "b1", "b2", "b3"),
      r2_bias = 100 * ((r2 - true_summary$r2) / true_summary$r2),
      est_bias = 100 * ((estimate - true_summary$estimate) / true_summary$estimate),
      coverage = as.integer(
        ((conf_lower < true_summary$estimate) & (true_summary$estimate < conf_upper))
      ),
      width = (conf_upper - conf_lower)
    )
  imp_summary
}

# Mice
multiple_imp <- function(i, j) {
  imp <- mice(data = amp(i, j), print = FALSE)
  fit <- with(imp, lm(X1 ~ X2 + X3 + X4))
  est <- pool(fit)
  true_summary <- true_model()
  mice_summary <- 
    summary(est, "all", conf.int = TRUE) %>%
    rename("conf_lower" = "2.5 %", "conf_upper" = "97.5 %") %>% 
    mutate(
      r2 = pool.r.squared(fit)[1, 1],
      term = c("b0", "b1", "b2", "b3"),
      re = 1 / (1 + (fmi / m)),
      r2_bias = 100 * ((r2 - true_summary$r2) / true_summary$r2),
      est_bias = 100 * ((estimate - true_summary$estimate) / true_summary$estimate),
      coverage = as.integer(
        ((conf_lower < true_summary$estimate) & (true_summary$estimate < conf_upper))
      ),
      width = (conf_upper - conf_lower)
    ) %>% 
    as_tibble()
  mice_summary
}

