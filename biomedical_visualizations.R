# ==============================================================================
# Biomedical Visualization Functions
# ==============================================================================
# This script provides visualization tools useful for biomedical statistics
# including boxplots, scatterplots, histograms, and survival curves.
# ==============================================================================

# Check if libraries are installed and install if necessary
needed_packages <- c("ggplot2", "survival", "survminer", "dplyr")

for (package in needed_packages) {
  if (!require(package, character.only = TRUE)) {
    install.packages(package, dependencies = TRUE)
    library(package, character.only = TRUE)
  }
}

# Load required libraries
library(ggplot2)
library(survival)
library(survminer)
library(dplyr)


# ==============================================================================
# 1. BOXPLOT FUNCTION
# ==============================================================================

#' Create Customizable Boxplot for Biomedical Data
#'
#' This function creates a boxplot to display the distribution of a dataset,
#' commonly used to compare distributions across groups in biomedical research.
#'
#' @param data A data frame containing the data to plot
#' @param x_var The name of the grouping variable (categorical)
#' @param y_var The name of the continuous variable to plot
#' @param title Plot title (default: "Boxplot of Data Distribution")
#' @param x_label X-axis label (default: uses x_var name)
#' @param y_label Y-axis label (default: uses y_var name)
#' @param fill_color Fill color for boxes (default: "steelblue")
#' @param show_points Logical, whether to overlay individual points (default: TRUE)
#' @param point_alpha Transparency of points (default: 0.3)
#'
#' @return A ggplot object
#' @export
#'
#' @examples
#' # Using iris dataset
#' biomedical_boxplot(iris, "Species", "Sepal.Length", 
#'                    title = "Sepal Length by Species")
biomedical_boxplot <- function(data, x_var, y_var, 
                               title = "Boxplot of Data Distribution",
                               x_label = NULL, y_label = NULL,
                               fill_color = "steelblue",
                               show_points = TRUE,
                               point_alpha = 0.3) {
  
  # Set default labels if not provided
  if (is.null(x_label)) x_label <- x_var
  if (is.null(y_label)) y_label <- y_var
  
  # Create base plot
  p <- ggplot(data, aes_string(x = x_var, y = y_var)) +
    geom_boxplot(fill = fill_color, alpha = 0.7, outlier.shape = NA) +
    labs(title = title, x = x_label, y = y_label) +
    theme_bw() +
    theme(
      plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
      axis.text = element_text(size = 11),
      axis.title = element_text(size = 12, face = "bold")
    )
  
  # Add points if requested
  if (show_points) {
    p <- p + geom_jitter(width = 0.2, alpha = point_alpha, color = "black")
  }
  
  return(p)
}


# ==============================================================================
# 2. SCATTERPLOT FUNCTION
# ==============================================================================

#' Create Customizable Scatterplot for Biomedical Data
#'
#' This function creates a scatterplot to examine relationships between two 
#' continuous variables, with options for adding regression lines and 
#' confidence intervals.
#'
#' @param data A data frame containing the data to plot
#' @param x_var The name of the x-axis variable
#' @param y_var The name of the y-axis variable
#' @param title Plot title (default: "Scatterplot")
#' @param x_label X-axis label (default: uses x_var name)
#' @param y_label Y-axis label (default: uses y_var name)
#' @param point_color Color of points (default: "darkblue")
#' @param point_size Size of points (default: 2)
#' @param point_alpha Transparency of points (default: 0.6)
#' @param add_regression Logical, whether to add regression line (default: FALSE)
#' @param regression_color Color of regression line (default: "red")
#' @param show_ci Logical, whether to show confidence interval (default: TRUE)
#' @param group_var Optional grouping variable for colored groups (default: NULL)
#'
#' @return A ggplot object
#' @export
#'
#' @examples
#' # Using iris dataset
#' biomedical_scatterplot(iris, "Sepal.Length", "Petal.Length",
#'                        title = "Relationship between Sepal and Petal Length",
#'                        add_regression = TRUE)
biomedical_scatterplot <- function(data, x_var, y_var,
                                   title = "Scatterplot",
                                   x_label = NULL, y_label = NULL,
                                   point_color = "darkblue",
                                   point_size = 2,
                                   point_alpha = 0.6,
                                   add_regression = FALSE,
                                   regression_color = "red",
                                   show_ci = TRUE,
                                   group_var = NULL) {
  
  # Set default labels if not provided
  if (is.null(x_label)) x_label <- x_var
  if (is.null(y_label)) y_label <- y_var
  
  # Create base plot
  if (is.null(group_var)) {
    p <- ggplot(data, aes_string(x = x_var, y = y_var)) +
      geom_point(color = point_color, size = point_size, alpha = point_alpha)
  } else {
    p <- ggplot(data, aes_string(x = x_var, y = y_var, color = group_var)) +
      geom_point(size = point_size, alpha = point_alpha) +
      scale_color_brewer(palette = "Set1")
  }
  
  # Add regression line if requested
  if (add_regression) {
    if (is.null(group_var)) {
      if (show_ci) {
        p <- p + geom_smooth(method = "lm", color = regression_color, 
                            fill = regression_color, alpha = 0.2)
      } else {
        p <- p + geom_smooth(method = "lm", color = regression_color, se = FALSE)
      }
    } else {
      if (show_ci) {
        p <- p + geom_smooth(method = "lm", alpha = 0.2)
      } else {
        p <- p + geom_smooth(method = "lm", se = FALSE)
      }
    }
  }
  
  # Add labels and theme
  p <- p + 
    labs(title = title, x = x_label, y = y_label) +
    theme_bw() +
    theme(
      plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
      axis.text = element_text(size = 11),
      axis.title = element_text(size = 12, face = "bold"),
      legend.position = "right"
    )
  
  return(p)
}


# ==============================================================================
# 3. HISTOGRAM FUNCTION
# ==============================================================================

#' Create Customizable Histogram for Biomedical Data
#'
#' This function creates a histogram to plot the frequency distribution of a 
#' dataset, useful for examining data distribution and normality.
#'
#' @param data A data frame containing the data to plot
#' @param var The name of the variable to plot
#' @param title Plot title (default: "Histogram")
#' @param x_label X-axis label (default: uses var name)
#' @param y_label Y-axis label (default: "Frequency")
#' @param fill_color Fill color for bars (default: "steelblue")
#' @param bins Number of bins (default: 30)
#' @param add_density Logical, whether to overlay density curve (default: FALSE)
#' @param density_color Color of density curve (default: "red")
#' @param add_normal Logical, whether to overlay normal distribution curve (default: FALSE)
#'
#' @return A ggplot object
#' @export
#'
#' @examples
#' # Using iris dataset
#' biomedical_histogram(iris, "Sepal.Length",
#'                      title = "Distribution of Sepal Length",
#'                      add_density = TRUE)
biomedical_histogram <- function(data, var,
                                 title = "Histogram",
                                 x_label = NULL, y_label = "Frequency",
                                 fill_color = "steelblue",
                                 bins = 30,
                                 add_density = FALSE,
                                 density_color = "red",
                                 add_normal = FALSE) {
  
  # Set default label if not provided
  if (is.null(x_label)) x_label <- var
  
  # Create base histogram
  p <- ggplot(data, aes_string(x = var)) +
    geom_histogram(bins = bins, fill = fill_color, color = "white", alpha = 0.7) +
    labs(title = title, x = x_label, y = y_label) +
    theme_bw() +
    theme(
      plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
      axis.text = element_text(size = 11),
      axis.title = element_text(size = 12, face = "bold")
    )
  
  # Add density curve if requested
  if (add_density) {
    p <- p + geom_density(aes(y = after_stat(count)), color = density_color, 
                         linewidth = 1.2, alpha = 0)
  }
  
  # Add normal distribution curve if requested
  if (add_normal) {
    mean_val <- mean(data[[var]], na.rm = TRUE)
    sd_val <- sd(data[[var]], na.rm = TRUE)
    
    p <- p + stat_function(
      fun = function(x) dnorm(x, mean = mean_val, sd = sd_val) * nrow(data) * 
        (max(data[[var]], na.rm = TRUE) - min(data[[var]], na.rm = TRUE)) / bins,
      color = "darkgreen",
      linewidth = 1.2
    )
  }
  
  return(p)
}


# ==============================================================================
# 4. SURVIVAL CURVE FUNCTION
# ==============================================================================

#' Create Customizable Survival Curve Plot
#'
#' This function creates a Kaplan-Meier survival curve to visualize patient 
#' survival data, commonly used in clinical research.
#'
#' @param data A data frame containing survival data
#' @param time_var The name of the time variable
#' @param event_var The name of the event variable (1 = event occurred, 0 = censored)
#' @param group_var Optional grouping variable (default: NULL)
#' @param title Plot title (default: "Survival Curve")
#' @param x_label X-axis label (default: "Time")
#' @param y_label Y-axis label (default: "Survival Probability")
#' @param palette Color palette for groups (default: "Set1")
#' @param risk_table Logical, whether to show risk table (default: TRUE)
#' @param conf_int Logical, whether to show confidence intervals (default: TRUE)
#' @param pval Logical, whether to show p-value for log-rank test (default: TRUE)
#'
#' @return A ggsurvplot object (or survfit object if survminer not available)
#' @export
#'
#' @examples
#' # Using lung dataset from survival package
#' data(lung)
#' lung$status_binary <- lung$status - 1  # Convert to 0/1
#' biomedical_survival_curve(lung, "time", "status_binary", "sex",
#'                           title = "Survival by Sex")
biomedical_survival_curve <- function(data, time_var, event_var, group_var = NULL,
                                      title = "Survival Curve",
                                      x_label = "Time",
                                      y_label = "Survival Probability",
                                      palette = "Set1",
                                      risk_table = TRUE,
                                      conf_int = TRUE,
                                      pval = TRUE) {
  
  # Create survival formula
  if (is.null(group_var)) {
    surv_formula <- as.formula(paste0("Surv(", time_var, ", ", event_var, ") ~ 1"))
  } else {
    surv_formula <- as.formula(paste0("Surv(", time_var, ", ", event_var, ") ~ ", group_var))
  }
  
  # Fit survival curve
  fit <- survfit(surv_formula, data = data)
  
  # Create survival plot using survminer if available
  if (requireNamespace("survminer", quietly = TRUE)) {
    p <- ggsurvplot(
      fit,
      data = data,
      title = title,
      xlab = x_label,
      ylab = y_label,
      pval = pval && !is.null(group_var),
      conf.int = conf_int,
      risk.table = risk_table,
      risk.table.title = "Number at Risk",
      palette = palette,
      ggtheme = theme_bw(),
      legend.title = if (!is.null(group_var)) group_var else "",
      legend.labs = if (!is.null(group_var)) levels(factor(data[[group_var]])) else NULL
    )
    return(p)
  } else {
    # Fallback to base plot if survminer is not available
    plot(fit, main = title, xlab = x_label, ylab = y_label, 
         col = 1:length(fit$strata), lwd = 2)
    if (!is.null(group_var)) {
      legend("topright", legend = levels(factor(data[[group_var]])), 
             col = 1:length(fit$strata), lwd = 2)
    }
    return(fit)
  }
}


# ==============================================================================
# UTILITY FUNCTION: Save Plot
# ==============================================================================

#' Save a Plot to File
#'
#' Utility function to save plots in various formats
#'
#' @param plot A ggplot or ggsurvplot object
#' @param filename Output filename
#' @param width Width in inches (default: 10)
#' @param height Height in inches (default: 6)
#' @param dpi Resolution (default: 300)
#'
#' @export
save_biomedical_plot <- function(plot, filename, width = 10, height = 6, dpi = 300) {
  # Handle ggsurvplot objects
  if (inherits(plot, "ggsurvplot")) {
    ggsave(filename, plot = print(plot), width = width, height = height, dpi = dpi)
  } else {
    ggsave(filename, plot = plot, width = width, height = height, dpi = dpi)
  }
  message(paste("Plot saved to:", filename))
}
