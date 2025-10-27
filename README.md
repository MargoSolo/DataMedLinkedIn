# DataMedLinkedIn

## Description

DataMedLinkedIn is a repository dedicated to exploring and analyzing data related to medical professionals on LinkedIn. This project aims to provide insights and tools for understanding the healthcare workforce through data analytics.

## Features

- Data collection from LinkedIn profiles
- Data cleaning and preprocessing
- Analytical tools and visualizations
- **NEW**: Biomedical visualization functions for statistical analysis

## Installation

To get started, clone the repository and install the necessary dependencies.

```bash
git clone https://github.com/margosolo/datamedlinkedin.git
cd datamedlinkedin
```

## Usage

Instructions on how to use the tools and scripts provided in this repository.

### Biomedical Visualization Functions

This repository includes comprehensive visualization tools for biomedical statistics. The functions are located in `biomedical_visualizations.R` and provide easy-to-use interfaces for creating common statistical plots used in biomedical research.

#### Available Functions

1. **biomedical_boxplot()** - Create customizable boxplots for displaying data distributions across groups
2. **biomedical_scatterplot()** - Create scatterplots to examine relationships between variables with optional regression lines
3. **biomedical_histogram()** - Plot frequency distributions with optional density curves
4. **biomedical_survival_curve()** - Visualize patient survival data using Kaplan-Meier curves
5. **save_biomedical_plot()** - Utility function to save plots in various formats

#### Quick Start

```r
# Load the visualization functions
source("biomedical_visualizations.R")

# Example 1: Create a boxplot
biomedical_boxplot(
  data = your_data,
  x_var = "group",
  y_var = "measurement",
  title = "Measurement by Group",
  fill_color = "steelblue"
)

# Example 2: Create a scatterplot with regression line
biomedical_scatterplot(
  data = your_data,
  x_var = "age",
  y_var = "blood_pressure",
  title = "Age vs Blood Pressure",
  add_regression = TRUE
)

# Example 3: Create a histogram
biomedical_histogram(
  data = your_data,
  var = "cholesterol",
  title = "Cholesterol Distribution",
  add_density = TRUE
)

# Example 4: Create a survival curve
biomedical_survival_curve(
  data = survival_data,
  time_var = "time",
  event_var = "event",
  group_var = "treatment",
  title = "Survival by Treatment"
)
```

#### Examples File

For comprehensive examples and demonstrations, see `biomedical_visualizations_examples.R`. This file includes:
- Sample data generation for various biomedical scenarios
- Multiple examples for each visualization type
- Customization options and parameter variations
- Real dataset examples using built-in R datasets

#### Required R Packages

The visualization functions require the following R packages:
- `ggplot2` - for creating graphics
- `survival` - for survival analysis
- `survminer` - for enhanced survival plots
- `dplyr` - for data manipulation

These packages will be automatically installed when you source the visualization functions file.

## Contributing

Contributions are welcome! Please read the CONTRIBUTING.md file for details on our code of conduct and the process for submitting pull requests.

## License

This project is licensed under the MIT License - see the LICENSE file for details.