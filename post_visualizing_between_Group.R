# Check if libraries are installed and install if necessary
needed_packages <- c("ggplot2", "ggstatsplot" )

for (package in needed_packages) {
  if (!require(package, character.only = TRUE)) {
    install.packages(package, dependencies = TRUE)
    library(package, character.only = TRUE)
  }
}

# Load libraries 
library(ggplot2)
library(ggstatsplot)

# Set seed for reproducibility 
set.seed(123)

# Create a box plot visualization
ggbetweenstats(
  data  = iris,
  x     = Species,
  y     = Sepal.Length,
  plot.type = "violin",  #This creates a violin plot of the sepal length distribution for each species of iris. 
  type = "np", # The  "type" parameter is set to "np" to indicate that we want to use a
  # nonparametric test to compare the groups 
  title = "Distribution of sepal length across Iris species"
  
) + 
  theme_bw()

# Save the plot as SVG
ggsave("iris.svg", width = 10, height = 6) 
















# Load the required libraries
library(ggplot2)
library(ggstatsplot) 
library(dplyr)
library(broom)

# Load the NHANES dataset
nhanes <- NHANES::NHANES
# Conduct Kruskal-Wallis test
kruskal.test(BMI ~ Gender, data = nhanes)

# Create a box plot visualization
ggbetweenstats(data = nhanes, x = Gender, y = BMI, plot.type = "boxplot",
               title = "Comparison of BMI between Males and Females",
               subtitle = "Using Kruskal-Wallis Test",
               caption = "Data Source: NHANES dataset") + 
  theme_bw()

# Save the plot as SVG
ggsave("nhanes_bmi.svg", width = 10, height = 6) 
