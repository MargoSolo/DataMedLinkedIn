# Check if libraries are installed and install if necessary
needed_packages <- c("rms",  'readxl') 

for (package in needed_packages) {
  if (!require(package, character.only = TRUE)) {
    install.packages(package, dependencies = TRUE)
    library(package, character.only = TRUE)
  }
}
 
# Load required libraries
library(rms)
library(readxl)

#Sets the working directory to the specified path. 
setwd('/../DataMedLinkedIn')

# Load  dataset
# sbreath - shortness of breath 
# sroh  - health status reported by the individual themselves 
# The variable is measured on a scale that ranges from E (Excellent) to VG (Very Good), G (Good), F (Fair), and P (Poor).

data <- read_excel('data.xlsx') 

# Perform logistic regression model using the lrm function from the
# rms library. The formula specifies that sbreath is the response 
# variable and age, sroh, bmi, and asthma are the predictor variables. 
# The 'data' argument specifies the dataset, while the 'x' and 'y' arguments indicate 
# that the matrix of covariates and vector of outcomes should be returned.

model <- lrm(sbreath ~ age + sroh +  bmi + asthma,
               data = data, x = TRUE, y = TRUE)

 
dd <- datadist(data) # This line creates a datadist object from the dataset, which is used to define variable transformations and defaults for plotting.
options(datadist = "dd") # This line sets the datadist option to the previously defined datadist object 'dd', so that the nomogram plot can be created.

# Create the nomogram plot
nom <- nomogram(model) #  This line creates a nomogram object from the logistic regression model.

plot(nom, main = "Nomogram for Logistic Regression Model") # This line plots the nomogram object with the specified title. The resulting plot visualizes the relationship between the predictor variables and the response variable, sbreath.
 