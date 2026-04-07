# Biomedical Visualization Functions - Quick Reference Guide

## Overview
This guide provides a quick reference for using the biomedical visualization functions included in this repository. These functions are designed specifically for common statistical visualizations in biomedical research.

## Installation and Setup

```r
# Source the visualization functions
source("biomedical_visualizations.R")

# Required packages will be automatically installed:
# - ggplot2
# - survival
# - survminer
# - dplyr
```

## Function Reference

### 1. Boxplot (`biomedical_boxplot`)

**Purpose**: Display and compare distributions of continuous data across groups

**Basic Usage**:
```r
biomedical_boxplot(data, x_var = "group", y_var = "measurement")
```

**Common Parameters**:
- `data` - Your data frame
- `x_var` - Name of grouping variable (categorical)
- `y_var` - Name of measurement variable (continuous)
- `title` - Plot title
- `fill_color` - Color for boxes (e.g., "steelblue", "#69b3a2")
- `show_points` - TRUE/FALSE to overlay individual points
- `point_alpha` - Transparency of points (0-1)

**Example**:
```r
biomedical_boxplot(
  data = patient_data,
  x_var = "treatment_group",
  y_var = "blood_pressure",
  title = "Blood Pressure by Treatment Group",
  fill_color = "coral",
  show_points = TRUE
)
```

---

### 2. Scatterplot (`biomedical_scatterplot`)

**Purpose**: Examine relationships between two continuous variables

**Basic Usage**:
```r
biomedical_scatterplot(data, x_var = "age", y_var = "cholesterol")
```

**Common Parameters**:
- `data` - Your data frame
- `x_var` - Name of x-axis variable
- `y_var` - Name of y-axis variable
- `title` - Plot title
- `point_color` - Color for points
- `point_size` - Size of points
- `add_regression` - TRUE/FALSE to add regression line
- `regression_color` - Color for regression line
- `show_ci` - TRUE/FALSE to show confidence interval
- `group_var` - Optional variable for colored groups

**Example**:
```r
# Simple scatterplot with regression
biomedical_scatterplot(
  data = patient_data,
  x_var = "age",
  y_var = "bmi",
  title = "Age vs BMI",
  add_regression = TRUE,
  regression_color = "red"
)

# Grouped scatterplot
biomedical_scatterplot(
  data = patient_data,
  x_var = "age",
  y_var = "bmi",
  title = "Age vs BMI by Gender",
  group_var = "gender",
  add_regression = TRUE
)
```

---

### 3. Histogram (`biomedical_histogram`)

**Purpose**: Visualize frequency distribution of a continuous variable

**Basic Usage**:
```r
biomedical_histogram(data, var = "measurement")
```

**Common Parameters**:
- `data` - Your data frame
- `var` - Name of variable to plot
- `title` - Plot title
- `fill_color` - Color for bars
- `bins` - Number of bins (default: 30)
- `add_density` - TRUE/FALSE to overlay density curve
- `density_color` - Color for density curve
- `add_normal` - TRUE/FALSE to overlay normal distribution

**Example**:
```r
# Simple histogram
biomedical_histogram(
  data = patient_data,
  var = "cholesterol",
  title = "Cholesterol Distribution",
  fill_color = "skyblue",
  bins = 25
)

# Histogram with density curve
biomedical_histogram(
  data = patient_data,
  var = "cholesterol",
  title = "Cholesterol Distribution with Density",
  add_density = TRUE,
  density_color = "red"
)
```

---

### 4. Survival Curve (`biomedical_survival_curve`)

**Purpose**: Visualize patient survival data using Kaplan-Meier curves

**Basic Usage**:
```r
biomedical_survival_curve(data, time_var = "time", event_var = "event")
```

**Common Parameters**:
- `data` - Your data frame
- `time_var` - Name of time variable
- `event_var` - Name of event variable (1 = event, 0 = censored)
- `group_var` - Optional grouping variable
- `title` - Plot title
- `palette` - Color palette for groups
- `risk_table` - TRUE/FALSE to show risk table
- `conf_int` - TRUE/FALSE to show confidence intervals
- `pval` - TRUE/FALSE to show p-value (for group comparisons)

**Example**:
```r
# Single survival curve
biomedical_survival_curve(
  data = survival_data,
  time_var = "time_months",
  event_var = "death",
  title = "Overall Survival"
)

# Comparing two groups
biomedical_survival_curve(
  data = survival_data,
  time_var = "time_months",
  event_var = "death",
  group_var = "treatment",
  title = "Survival by Treatment",
  palette = c("red", "blue"),
  pval = TRUE
)
```

---

### 5. Save Plot (`save_biomedical_plot`)

**Purpose**: Save plots to files in various formats

**Basic Usage**:
```r
save_biomedical_plot(plot, filename = "output.png")
```

**Common Parameters**:
- `plot` - The plot object to save
- `filename` - Output filename (supports .png, .pdf, .svg, .jpg)
- `width` - Width in inches (default: 10)
- `height` - Height in inches (default: 6)
- `dpi` - Resolution (default: 300)

**Example**:
```r
# Create a plot
my_plot <- biomedical_boxplot(data, "group", "value")

# Save as PNG
save_biomedical_plot(my_plot, "boxplot.png", width = 8, height = 6)

# Save as PDF
save_biomedical_plot(my_plot, "boxplot.pdf", width = 10, height = 7)
```

---

## Color Options

### Named Colors
Common R color names you can use:
- `"steelblue"`, `"skyblue"`, `"navy"`
- `"coral"`, `"red"`, `"darkred"`
- `"green"`, `"darkgreen"`, `"lightgreen"`
- `"purple"`, `"orchid"`, `"lavender"`
- `"orange"`, `"darkorange"`

### Hex Colors
You can also use hex color codes:
- `"#69b3a2"` - Teal
- `"#404080"` - Purple
- `"#FF6B6B"` - Coral red

---

## Complete Workflow Example

```r
# 1. Load functions
source("biomedical_visualizations.R")

# 2. Load your data
patient_data <- read.csv("patient_data.csv")

# 3. Create visualizations

# Compare BMI across treatment groups
bmi_plot <- biomedical_boxplot(
  data = patient_data,
  x_var = "treatment",
  y_var = "bmi",
  title = "BMI Distribution by Treatment Group",
  fill_color = "#69b3a2"
)

# Examine age vs blood pressure relationship
bp_plot <- biomedical_scatterplot(
  data = patient_data,
  x_var = "age",
  y_var = "systolic_bp",
  title = "Age vs Systolic Blood Pressure",
  add_regression = TRUE,
  group_var = "gender"
)

# View cholesterol distribution
chol_plot <- biomedical_histogram(
  data = patient_data,
  var = "cholesterol",
  title = "Cholesterol Distribution",
  add_density = TRUE,
  bins = 30
)

# Analyze survival data
surv_plot <- biomedical_survival_curve(
  data = patient_data,
  time_var = "survival_time",
  event_var = "death_event",
  group_var = "treatment",
  title = "Survival Analysis by Treatment"
)

# 4. Save plots
save_biomedical_plot(bmi_plot, "bmi_boxplot.png")
save_biomedical_plot(bp_plot, "bp_scatterplot.png")
save_biomedical_plot(chol_plot, "cholesterol_histogram.png")
```

---

## Tips and Best Practices

1. **Data Preparation**: Ensure your data is in the correct format:
   - Grouping variables should be factors or characters
   - Numeric variables should be numeric (not character)
   - For survival analysis, event variable should be 0/1

2. **Choosing Colors**: 
   - Use contrasting colors for different groups
   - Consider colorblind-friendly palettes
   - Keep it professional for publications

3. **Plot Titles and Labels**:
   - Use descriptive, clear titles
   - Include units in axis labels (e.g., "mg/dL", "years")
   - Keep labels concise but informative

4. **File Formats**:
   - PNG: Good for presentations and web
   - PDF: Best for publications (vector graphics)
   - SVG: For web and further editing

5. **Customization**:
   - All functions return ggplot objects
   - You can further customize with ggplot2 functions
   - Example: `plot + theme(legend.position = "bottom")`

---

## Getting Help

For comprehensive examples, see `biomedical_visualizations_examples.R`

For function documentation:
```r
# View function details
?biomedical_boxplot
?biomedical_scatterplot
?biomedical_histogram
?biomedical_survival_curve
```

For ggplot2 customization: https://ggplot2.tidyverse.org/
For survival analysis: https://www.rdocumentation.org/packages/survival/

---

## Troubleshooting

**Problem**: "Error: could not find function..."
- **Solution**: Make sure to source the functions file first: `source("biomedical_visualizations.R")`

**Problem**: Packages not installing
- **Solution**: Try manual installation: `install.packages(c("ggplot2", "survival", "survminer", "dplyr"))`

**Problem**: Survival curve not showing
- **Solution**: Check that event variable is coded as 0/1 (not 1/2)

**Problem**: Colors not displaying
- **Solution**: Check spelling of color names or use hex codes
