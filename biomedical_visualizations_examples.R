# ==============================================================================
# Biomedical Visualization Functions - Usage Examples
# ==============================================================================
# This script demonstrates the usage of biomedical visualization functions
# with sample datasets commonly used in biomedical research.
# ==============================================================================

# Source the visualization functions
source("biomedical_visualizations.R")

# Set seed for reproducibility
set.seed(123)


# ==============================================================================
# Example 1: BOXPLOT - Comparing BMI across different groups
# ==============================================================================

cat("\n=== Example 1: Boxplot ===\n")

# Create sample biomedical data: BMI across different treatment groups
sample_bmi_data <- data.frame(
  Treatment = rep(c("Control", "Treatment A", "Treatment B"), each = 50),
  BMI = c(
    rnorm(50, mean = 25, sd = 3),  # Control group
    rnorm(50, mean = 23, sd = 2.5),  # Treatment A
    rnorm(50, mean = 24, sd = 3.2)   # Treatment B
  ),
  Age = c(rnorm(50, mean = 45, sd = 10),
          rnorm(50, mean = 47, sd = 11),
          rnorm(50, mean = 46, sd = 9))
)

# Create basic boxplot
plot1 <- biomedical_boxplot(
  data = sample_bmi_data,
  x_var = "Treatment",
  y_var = "BMI",
  title = "BMI Distribution Across Treatment Groups",
  x_label = "Treatment Group",
  y_label = "Body Mass Index (kg/m²)",
  fill_color = "#69b3a2"
)

print(plot1)

# Save the plot
save_biomedical_plot(plot1, "example_boxplot_bmi.png", width = 8, height = 6)

# Create boxplot without overlaid points
plot1b <- biomedical_boxplot(
  data = sample_bmi_data,
  x_var = "Treatment",
  y_var = "BMI",
  title = "BMI Distribution (Without Points)",
  fill_color = "coral",
  show_points = FALSE
)

print(plot1b)


# ==============================================================================
# Example 2: SCATTERPLOT - Relationship between age and blood pressure
# ==============================================================================

cat("\n=== Example 2: Scatterplot ===\n")

# Create sample data: Age vs Systolic Blood Pressure
sample_bp_data <- data.frame(
  Age = runif(100, min = 20, max = 80),
  SBP = 100 + 0.5 * runif(100, 20, 80) + rnorm(100, 0, 10),
  Gender = sample(c("Male", "Female"), 100, replace = TRUE)
)

# Basic scatterplot with regression line
plot2 <- biomedical_scatterplot(
  data = sample_bp_data,
  x_var = "Age",
  y_var = "SBP",
  title = "Relationship Between Age and Systolic Blood Pressure",
  x_label = "Age (years)",
  y_label = "Systolic Blood Pressure (mmHg)",
  add_regression = TRUE,
  point_color = "navy",
  regression_color = "red"
)

print(plot2)
save_biomedical_plot(plot2, "example_scatterplot_age_bp.png", width = 8, height = 6)

# Scatterplot with groups (by gender)
plot2b <- biomedical_scatterplot(
  data = sample_bp_data,
  x_var = "Age",
  y_var = "SBP",
  title = "Age vs Blood Pressure by Gender",
  x_label = "Age (years)",
  y_label = "Systolic Blood Pressure (mmHg)",
  add_regression = TRUE,
  group_var = "Gender",
  show_ci = TRUE
)

print(plot2b)
save_biomedical_plot(plot2b, "example_scatterplot_by_gender.png", width = 9, height = 6)


# ==============================================================================
# Example 3: HISTOGRAM - Distribution of cholesterol levels
# ==============================================================================

cat("\n=== Example 3: Histogram ===\n")

# Create sample data: Cholesterol levels
sample_chol_data <- data.frame(
  Cholesterol = rnorm(200, mean = 200, sd = 40),
  Patient_ID = 1:200
)

# Basic histogram
plot3 <- biomedical_histogram(
  data = sample_chol_data,
  var = "Cholesterol",
  title = "Distribution of Cholesterol Levels",
  x_label = "Total Cholesterol (mg/dL)",
  y_label = "Number of Patients",
  fill_color = "skyblue",
  bins = 25
)

print(plot3)
save_biomedical_plot(plot3, "example_histogram_cholesterol.png", width = 8, height = 6)

# Histogram with density curve
plot3b <- biomedical_histogram(
  data = sample_chol_data,
  var = "Cholesterol",
  title = "Distribution of Cholesterol Levels with Density",
  x_label = "Total Cholesterol (mg/dL)",
  fill_color = "lightgreen",
  bins = 30,
  add_density = TRUE,
  density_color = "darkred"
)

print(plot3b)

# Histogram with normal distribution overlay
plot3c <- biomedical_histogram(
  data = sample_chol_data,
  var = "Cholesterol",
  title = "Cholesterol Distribution vs Normal Distribution",
  x_label = "Total Cholesterol (mg/dL)",
  fill_color = "lavender",
  bins = 25,
  add_normal = TRUE
)

print(plot3c)
save_biomedical_plot(plot3c, "example_histogram_with_normal.png", width = 8, height = 6)


# ==============================================================================
# Example 4: SURVIVAL CURVE - Patient survival analysis
# ==============================================================================

cat("\n=== Example 4: Survival Curve ===\n")

# Create sample survival data
# Time in months, Event (1 = death, 0 = censored), Treatment group
sample_survival_data <- data.frame(
  Time = c(
    rexp(60, rate = 0.05),  # Control group
    rexp(60, rate = 0.03)   # Treatment group
  ),
  Event = c(
    rbinom(60, 1, 0.7),     # Control group event indicator
    rbinom(60, 1, 0.5)      # Treatment group event indicator
  ),
  Treatment = rep(c("Control", "Treatment"), each = 60),
  Age_Group = rep(c("< 65", ">= 65"), 60)
)

# Basic survival curve (single group)
sample_survival_single <- sample_survival_data[sample_survival_data$Treatment == "Control", ]

plot4a <- biomedical_survival_curve(
  data = sample_survival_single,
  time_var = "Time",
  event_var = "Event",
  title = "Overall Survival - Control Group",
  x_label = "Time (months)",
  y_label = "Survival Probability",
  risk_table = TRUE,
  conf_int = TRUE,
  pval = FALSE
)

print(plot4a)

# Survival curve with groups (comparing treatments)
plot4b <- biomedical_survival_curve(
  data = sample_survival_data,
  time_var = "Time",
  event_var = "Event",
  group_var = "Treatment",
  title = "Survival Comparison: Control vs Treatment",
  x_label = "Time (months)",
  y_label = "Survival Probability",
  palette = c("red", "blue"),
  risk_table = TRUE,
  conf_int = TRUE,
  pval = TRUE
)

print(plot4b)


# ==============================================================================
# Example 5: Using Real Biomedical Dataset (iris as proxy)
# ==============================================================================

cat("\n=== Example 5: Using Built-in Dataset (iris) ===\n")

# Load iris dataset (commonly used for demonstration)
data(iris)

# Boxplot: Sepal Length by Species
plot5a <- biomedical_boxplot(
  data = iris,
  x_var = "Species",
  y_var = "Sepal.Length",
  title = "Sepal Length Distribution by Species",
  x_label = "Iris Species",
  y_label = "Sepal Length (cm)",
  fill_color = "orchid"
)

print(plot5a)
save_biomedical_plot(plot5a, "example_iris_boxplot.png", width = 8, height = 6)

# Scatterplot: Sepal Length vs Petal Length
plot5b <- biomedical_scatterplot(
  data = iris,
  x_var = "Sepal.Length",
  y_var = "Petal.Length",
  title = "Sepal Length vs Petal Length",
  x_label = "Sepal Length (cm)",
  y_label = "Petal Length (cm)",
  add_regression = TRUE,
  group_var = "Species"
)

print(plot5b)
save_biomedical_plot(plot5b, "example_iris_scatterplot.png", width = 9, height = 6)

# Histogram: Petal Width distribution
plot5c <- biomedical_histogram(
  data = iris,
  var = "Petal.Width",
  title = "Distribution of Petal Width",
  x_label = "Petal Width (cm)",
  fill_color = "darkorange",
  bins = 20,
  add_density = TRUE
)

print(plot5c)


# ==============================================================================
# Example 6: Using lung cancer dataset from survival package
# ==============================================================================

cat("\n=== Example 6: Lung Cancer Survival Analysis ===\n")

# Load lung dataset from survival package
data(lung, package = "survival")

# Prepare data: Convert status to binary (1 = dead, 0 = censored)
lung$status_binary <- lung$status - 1
lung$sex_factor <- factor(lung$sex, levels = c(1, 2), labels = c("Male", "Female"))

# Create survival curve by sex
plot6 <- biomedical_survival_curve(
  data = lung,
  time_var = "time",
  event_var = "status_binary",
  group_var = "sex_factor",
  title = "Lung Cancer Survival by Sex",
  x_label = "Time (days)",
  y_label = "Survival Probability",
  palette = c("blue", "red"),
  risk_table = TRUE,
  conf_int = TRUE,
  pval = TRUE
)

print(plot6)


# ==============================================================================
# Summary
# ==============================================================================

cat("\n=== Summary ===\n")
cat("All visualization examples have been generated.\n")
cat("Functions demonstrated:\n")
cat("  1. biomedical_boxplot() - for comparing distributions across groups\n")
cat("  2. biomedical_scatterplot() - for examining relationships between variables\n")
cat("  3. biomedical_histogram() - for visualizing frequency distributions\n")
cat("  4. biomedical_survival_curve() - for analyzing survival data\n")
cat("  5. save_biomedical_plot() - for saving plots to files\n")
cat("\nAll functions support extensive customization options.\n")
cat("See biomedical_visualizations.R for full documentation.\n")
