library(gtsummary)
library(dplyr)

trial %>%
  tbl_summary(
    include = c(trt, marker, age, response, stage),
    statistic = age ~ "{mean} ({sd})",
    by = trt
  ) %>%
  add_stat_label() %>%
  add_p(
    test = list(
      response ~ "fisher.test",
      age ~ "t.test"
    ),
    pvalue_fun = scales::label_pvalue(accuracy = .001)
  ) %>%
  separate_p_footnotes()