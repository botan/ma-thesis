source("1-imports.R")
source("2-helpers.R")
source("3-workers.R")

# Define number of rerun
n <- 1000

# Simulate cca for different mar models and props
cca_results <- tibble()
for (j in c("RIGHT", "TAIL", "MID")) {
  for (i in seq(0.1, 0.9, 0.2)) {
    results <-
      rerun(n, cca(i, j)) %>%
      bind_rows() %>%
      group_by(term) %>%
      summarise_if(is.numeric, mean) %>%
      mutate(props = i, types = j, method = "cca")
    cca_results <- bind_rows(cca_results, results)
  }
}

# Simulate all single imputations for different mar models and props
single_imp_results <- tibble()
for (k in c("mean", "norm.predict", "norm.nob", "pmm")) {
  for (j in c("RIGHT", "TAIL", "MID")) {
    for (i in seq(0.1, 0.9, 0.2)) {
      results <-
        rerun(n, single_imp(i, j, k)) %>%
        bind_rows() %>%
        group_by(term) %>%
        summarise_if(is.numeric, mean) %>%
        mutate(props = i, types = j, method = k)
      single_imp_results <- bind_rows(single_imp_results, results)
    }
  }
}

# Simulate mice for different mar models and props
mice_results <- tibble()
for (j in c("RIGHT", "TAIL", "MID")) {
  for (i in seq(0.1, 0.9, 0.2)) {
    results <-
      rerun(n, multiple_imp(i, j)) %>%
      bind_rows() %>%
      group_by(term) %>%
      summarise_if(is.numeric, mean) %>%
      mutate(props = i, types = j, method = "mice")
    mice_results <- bind_rows(mice_results, results)
  }
}

# Bind all results
df <-
  bind_rows(
    cca_results,
    single_imp_results,
    mice_results %>%
      select(
        term,
        estimate,
        std.error,
        statistic,
        p.value,
        conf_lower,
        conf_upper,
        r2,
        r2_bias,
        est_bias,
        coverage,
        width,
        props,
        types,
        method
      )
  ) %>%
  mutate_if(is_character, as_factor)

# Keep only useful outputs and save them
rm(list = setdiff(ls(), c("cca_results", "single_imp_results", "mice_results", "df")))
save.image("output.RData")
