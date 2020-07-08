pkgload::load_all()

library(tidyverse)

mcmcr_example

long <-
  mcmcr_example %>%
  as.mcmc.list() %>%
  unclass() %>%
  enframe(name = "chain") %>%
  mutate(value = map(value, unclass)) %>%
  mutate(value = map(
    value, as_tibble,
    .name_repair = ~ c(
      "alpha[1]", "alpha[2]",
      "beta[1,1]", "beta[1,2]", "beta[2,1]", "beta[2,2]",
      "sigma"
    )
  )) %>%
  unnest(value) %>%
  group_by(chain) %>%
  mutate(iteration = row_number()) %>%
  ungroup() %>%
  pivot_longer(-c(chain, iteration)) %>%
  rename(term = name) %>%
  select(term, chain, iteration, value) %>%
  mutate(chain = forcats::fct_relabel(factor(chain), ~ paste0("chain ", .))) %>%
  mutate(iteration = factor(iteration))

# long <- tibble(
#   term_name = "alpha[1]",
#   chain = 1,
#   iteration = 1,
#   value = 7.17
# )

array <- xtabs(value ~ ., long)

cube <- cubelyr::as.tbl_cube(array, met_name = "value")

cube %>%
  filter(iteration < 10)

cube %>%
  group_by(term) %>%
  summarize(mean(value))

cube %>%
  group_by(term, chain) %>%
  summarize(mean(value))

try(
  cube %>%
    group_by(pars(as_term(term))) %>%
    summarize(mean(value))
)

wide_cube <-
  long %>%
  pivot_wider(c(chain, iteration), term) %>%
  as.tbl_cube(dim_names = c("chain", "iteration"))

try(
  wide_cube %>%
    mutate(alphas = `alpha[2]` / `alpha[1]`)
)

wide_cube %>%
  select(starts_with("alpha")) %>%
  as_tibble() %>%
  mutate(alphas = `alpha[2]` / `alpha[1]`) %>%
  as.tbl_cube()
