# Check if libraries are installed and install if necessary
needed_packages <- c("dplyr", "gtsummary")

for (package in needed_packages) {
  if (!require(package, character.only = TRUE)) {
    install.packages(package, dependencies = TRUE)
    library(package, character.only = TRUE)
  }
}

# Load necessary libraries
library(gtsummary)
library(dplyr)

trial %>%
  tbl_summary(
    include = c(trt, marker, age, response, stage),
    statistic = age ~ "{mean} ({sd})",
    by = trt #it creates a summary table for the trial dataset with specific columns and summary statistics
  ) %>%
  add_stat_label() %>% #The add_stat_label() function adds statistical labels to the summary table
  add_p(
    test = list(
      response ~ "fisher.test",
      age ~ "t.test"
    ),# The add_p() function adds p-values for the tests listed in the "test" argument.
    pvalue_fun = scales::label_pvalue(accuracy = .001)
  ) %>%
  separate_p_footnotes() # Finally, separate_p_footnotes() separates the p-values and footnotes from the main table