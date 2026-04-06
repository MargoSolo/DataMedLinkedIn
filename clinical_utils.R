#' Standardize Clinical Phenotypes and Handle Missing Genomic Data
#' @description Utility functions for cleaning clinical datasets before survival analysis.
#' @param data A dataframe containing clinical observations.

clean_clinical_data <- function(data) {
  require(dplyr)
  require(tidyr)
  
  processed_data <- data %>%
    # Standardize HPO terms to uppercase
    mutate(across(contains("HPO"), toupper)) %>%
    # Simple imputation for non-critical missing values
    mutate(across(where(is.numeric), ~replace_na(., median(., na.rm = TRUE)))) %>%
    # Filter out records without essential genetic variants
    filter(!is.na(variant_id))
    
  return(processed_data)
}

# standardized_df <- clean_clinical_data(raw_clinical_df)
