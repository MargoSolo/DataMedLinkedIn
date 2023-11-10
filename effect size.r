# Check if libraries are installed and install if necessary  
needed_packages <- c("dplyr", "gtsummary", "effsize")

for (package in needed_packages) {
  if (!require(package, character.only = TRUE)) {
    install.packages(package, dependencies = TRUE)
    library(package, character.only = TRUE)
  }
}

# Load necessary libraries 
library(dplyr)
library(gtsummary)
library(effsize)

# effect size function for Wilcoxon test
ES_Wilcoxon <- function(data, variable, by, ...) {
  rstatix::wilcox_effsize(data, as.formula(glue::glue("{variable} ~ {by}")))$effsize
}

# effect size function for Welch's t-test
ES_Welch <- function(data, variable, by, ...) {
  rstatix::cohens_d(data, as.formula(glue::glue("{variable} ~ {by}")))$effsize
}

# effect size function for Kruskal-Wallis test
ES_kruskal_effsize <- function(data, variable, by, ...) {
  rstatix::kruskal_effsize(data, as.formula(glue::glue("{variable} ~ {by}")))$effsize
}

# effect size function for Friedman test using the Kendall’s W value
ES_friedman_effsize <- function(data, variable, by, ...) {
  rstatix::friedman_effsize(data, as.formula(glue::glue("{variable} ~ {by}")))$effsize
}
 

# effect size function for ANOVA
ES_eta_squared <- function(data, variable, by, ...) {
  rstatix::eta_squared(data, as.formula(glue::glue("{variable} ~ {by}")))$effsize
}
 

tbl <-
  trial %>%
  select(age, marker, trt, grade ) %>% # Select relevant columns from the trial dataset
  tbl_summary(
    by = trt,# Group data by the 'trt' column 
    statistic = list( age ~ "{mean} ({sd})", marker ~ "{median} ({p25}, {p75})"),
    missing = "no"
  ) %>%
  add_stat(
    list(age ~ ES_Wilcoxon, # Apply a suitable effect size function to the selected variable
         marker ~ ES_Welch)) %>% # Apply a suitable effect size function to the selected variable
  modify_header(add_stat_1 ~ "**Effect Size**") %>%
  add_p(
    test = list(
      marker ~ "wilcox.test",  # Specify Wilcoxon test for 'response' variable
      age ~ "t.test" ),        # Specify t-test for 'age' variable  
    pvalue_fun = scales::label_pvalue(accuracy = .001)
  ) # Adding p-values

tbl