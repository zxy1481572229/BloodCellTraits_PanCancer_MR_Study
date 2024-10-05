
# Importing Required Libraries
library(data.table)  # Import the data.table package for fast and efficient data handling
library(TwoSampleMR)  # Import the TwoSampleMR package for Mendelian Randomization (MR) analysis

# Define the `run_data_analysis` Function
run_data_analysis <- function(file_path) {
  # Read the input file using fread for fast performance
  dataset <- fread(file_path, header = TRUE, sep = "	")
  
  # Store the file name as a new column for tracking
  file_name <- basename(file_path)
  dataset$file_source <- file_name
  
  # Convert the file from .gz format to .csv and save the output
  output_csv <- sub("\.gz$", ".csv", file_name)
  write.csv(dataset, file = output_csv, row.names = FALSE)
  
  # Read the newly generated CSV file as input for the outcome data
  outcome_data <- read_outcome_data(snps = unique(exposure_data$SNP),
                                    filename = output_csv, sep = ",",
                                    snp_col = "snp_id",
                                    beta_col = "beta_value",
                                    se_col = "standard_error",
                                    effect_allele_col = "effect_allele",
                                    other_allele_col = "other_allele",
                                    pval_col = "p_value",
                                    eaf_col = "effect_allele_frequency")
  
  # Harmonize the exposure and outcome data to align the effect estimates
  harmonized_data <- harmonise_data(exposure_data, outcome_data)
  
  # Run the Mendelian Randomization analysis
  mr_result <- mr(harmonized_data)
  
  # Generate and save the odds ratios summary in CSV format
  result_summary <- generate_odds_ratios(mr_result)
  write.csv(result_summary, file = paste0(file_name, "_results_summary.csv"), row.names = FALSE)
  
  # Perform heterogeneity analysis and save the results
  heterogeneity_result <- mr_heterogeneity(harmonized_data)
  write.csv(heterogeneity_result, file = paste0(file_name, "_heterogeneity.csv"), row.names = FALSE)
  
  # Perform pleiotropy testing and save the results
  pleiotropy_result <- mr_pleiotropy_test(harmonized_data)
  write.csv(pleiotropy_result, file = paste0(file_name, "_pleiotropy_test.csv"), row.names = FALSE)
}

# Set the Working Directory
# Ensure the working directory is where the input files are located

# List All .gz Files in the Directory
file_list <- list.files(pattern = "\.gz$")  # Find all files ending with .gz extension

# Load the Exposure Data for Analysis
exposure_data <- read.csv('Trait_Exposure_Data.csv', header = TRUE)  # Load the exposure dataset for the analysis

# Process Each File from the List
for (file in file_list) {
  run_data_analysis(file)  # Run the analysis function for each file
}
