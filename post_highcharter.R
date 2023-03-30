# Check if libraries are installed and install if necessary
needed_packages <- c("dplyr", "broom", "highcharter")

for (package in needed_packages) {
  if (!require(package, character.only = TRUE)) {
    install.packages(package, dependencies = TRUE)
    library(package, character.only = TRUE)
  }
}

# Load necessary libraries
library(dplyr)
library(broom)
library(highcharter)


# Load NHANES dataset and select relevant variables  
nhanes_data <- NHANES::NHANES
df <- nhanes_data %>%
  select(BMI, BPSysAve,Gender )

# Fit linear models for males and females 
male_model <- lm(BPSysAve ~ BMI, data = filter(df, Gender == "male"))
male_fit <- augment(male_model) %>% arrange(BMI)

female_model <- lm(BPSysAve ~ BMI, data = filter(df, Gender == "female"))
female_fit <- augment(female_model) %>% arrange(BMI)

#  Define colors for male and female lines 
male_fit_color <- "#0072B2"
female_fit_color <- "#D55E00"
        
#  Visualization
hc <- df %>%  
  hchart('scatter', hcaes(x = BMI, y = BPSysAve, group = Gender))  %>%
  hc_colors(c("#009E73","#F0E442" )) %>%
  hc_add_series(
    male_fit, type = "line", hcaes(x = BMI, y = .fitted),
    name = "Male Fit", id = "male_fit", color = male_fit_color  
  ) %>% 
  hc_add_series(
    female_fit, type = "line", hcaes(x = BMI, y = .fitted),
    name = "Female Fit", id = "female_fit", color = female_fit_color
  ) 
hc