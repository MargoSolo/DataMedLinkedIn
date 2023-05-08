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

# Selecting relevant columns from trial dataset
small_trial <- trial %>% dplyr :: select(grade, age, response)

# Creating summary table by grade 
t0 <- small_trial %>%
  tbl_summary(by = grade, missing = "no") %>%
  modify_header(all_stat_cols() ~ "**{level}**")

# Creating table comparing grade I and II  
t1 <- small_trial %>%
  filter(grade %in% c("I", "II")) %>%
  tbl_summary(by = grade, missing = "no") %>%
  add_p(test = list(  age  ~ "mood.test" ), pvalue_fun = function(x) style_pvalue(x, digits = 3)) %>%
  separate_p_footnotes()%>%
  modify_header(p.value ~ md("**I vs. II**")) %>%
  modify_column_hide(all_stat_cols())

# Creating table comparing grade I and III 
t2 <- small_trial %>%
  filter(grade %in% c("I", "III")) %>%
  tbl_summary(by = grade, missing = "no") %>%
  add_p(test = list(  age  ~ "mood.test" ),pvalue_fun = function(x) style_pvalue(x, digits = 3)) %>%
  separate_p_footnotes() %>%
  modify_header(p.value ~ md("**I vs. III**")) %>%
  modify_column_hide(all_stat_cols())

# Merging the 3 tables together and adding additional gt formatting
finally_table <- tbl_merge(list(t0, t1, t2)) %>%
  modify_spanning_header(
    list(
      all_stat_cols() ~ "**Tumor Grade**",
      starts_with("p.value") ~ "**p-values**"
    )
  ) %>% 
  modify_footnote( 
    c("stat_1_1", "stat_2_1", "stat_3_1") ~  "**Note:** Median and IQR are reported in the non-parametric case to summarize the central tendency and dispersion of the data. ,  
**Note:**  Mood's test for medians is a non-parametric alternative to the one-way ANOVA F-test. ,                       
**Note:**  Fisher's exact test is a non-parametric alternative to the chi-squared test for small sample sizes."
  )    
finally_table 
 
 