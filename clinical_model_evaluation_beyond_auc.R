# ==============================================================================
# CLINICAL ML EVALUATION: BEYOND AUC AND ACCURACY 
# ==============================================================================

# 1. LOAD LIBRARIES
if (!require("pacman")) install.packages("pacman")
pacman::p_load(tidyverse, pROC, dcurves, patchwork)

# 2. GENERATE SYNTHETIC CLINICAL DATA
set.seed(123)
n_patients <- 1000
prevalence <- 0.05 # 5% of patients have the condition  

# True outcomes
y <- rbinom(n_patients, 1, prevalence)

# Model A: Well-calibrated expert system
# High discrimination (AUC ~0.85) and accurate risk estimates
risk_a <- plogis(rnorm(n_patients, mean = -3 + 3 * y, sd = 1))

# Model B: Miscalibrated "toxic" system 
# Same ranking ability (same AUC) but systematically overestimates risk
# This happens often when moving models between different hospitals
risk_b <- risk_a^0.3 

df <- data.frame(outcome = y, model_a = risk_a, model_b = risk_b)

# ==============================================================================
# 3. THE ACCURACY PARADOX
# ==============================================================================
# A "Naive" model that predicts NO ONE has the disease
naive_preds <- rep(0, n_patients)
accuracy_naive <- sum(naive_preds == y) / n_patients

cat("--- ACCURACY PARADOX ---\n")
cat("Naive accuracy (predicting 'no disease' for all):", accuracy_naive * 100, "%\n")
cat("Clinical utility: 0% (missed every single patient in need)\n\n")

# ==============================================================================
# 4. THE AUC ILLUSION
# ==============================================================================
auc_a <- auc(df$outcome, df$model_a)
auc_b <- auc(df$outcome, df$model_b)

cat("--- DISCRIMINATION (AUC) ---\n")
cat("Model A AUC:", round(auc_a, 3), "\n")
cat("Model B AUC:", round(auc_b, 3), "\n")
cat("Conclusion: AUC says they are identical. But are they?\n\n")

# ==============================================================================
# 5. CALIBRATION: WHERE MEDICINE HAPPENS
# ==============================================================================
# Does a 20% predicted risk actually mean 20% of patients have the disease?

calibration_plot <- ggplot(df) +
  geom_abline(intercept = 0, slope = 1, linetype = "dashed", color = "grey") +
  stat_summary_bin(aes(model_a, outcome, color = "Model A (Calibrated)"), 
                   bins = 10, geom = "pointrange") +
  stat_summary_bin(aes(model_b, outcome, color = "Model B (Miscalibrated)"), 
                   bins = 10, geom = "pointrange") +
  labs(title = "Calibration plot",
       subtitle = "Model B vastly overestimates risk despite high AUC",
       x = "Predicted probability", y = "Observed proportion") +
  theme_minimal() +
  theme(legend.position = "bottom")



# ==============================================================================
# 6. DECISION CURVE ANALYSIS (DCA): CLINICAL NET BENEFIT
# ==============================================================================
# Net Benefit = (TP / N) - (FP / N) * (Weight)
# Weight = Threshold / (1 - Threshold)

dca_results <- dca(outcome ~ model_a + model_b, 
                   data = df,
                   thresholds = seq(0, 0.5, by = 0.01))

dca_plot <- plot(dca_results) +
  labs(title = "Decision curve analysis",
       subtitle = "Model B is worse than 'Treat all' at low thresholds") +
  theme_minimal()

# Show plots side-by-side

calibration_plot + dca_plot
