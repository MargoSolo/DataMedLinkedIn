# Check if libraries are installed and install if necessary 
needed_packages <- c("report", "dplyr",  'readxl') 

for (package in needed_packages) {
  if (!require(package, character.only = TRUE)) {
    install.packages(package, dependencies = TRUE)
    library(package, character.only = TRUE)
  }
}

# Load required libraries 
library(readxl)
library(report) # to report results 
library(dplyr)

#Sets the working directory to the specified path.  
setwd('/../DataMedLinkedIn')

# Load dataset
library(readxl)
data <- read_excel("data.xlsx")

# Define variable names
# sbreath: Shortness of breath
# sroh: Self-reported health status (rated from E to P)
# SAD: Systolic blood pressure
# Chol: Cholesterol
# bmi: Body mass index
# age: Age

# Run t-test to compare BMI between those with and without shortness of breath
t.test(bmi ~ sbreath, data = data) %>% report()

# Run correlation test to examine the relationship between BMI and age
cor.test(data$bmi, data$age ) %>% report()

# Run ANOVA to investigate the relationship between SAD, Chol, and BMI
aov(SAD ~ Chol + bmi, data = data) %>% report()
