# Data-Driven Insights on Hospital Mortality Rates: An R-Based Analysis
### Data Science Project in R

## Project Overview
This project aimed to analyze hospital performance data using R programming. The primary goal was to rank hospitals by their 30-day mortality rates for specific conditions (heart attack, heart failure, and pneumonia) and explore the relationship between hospital size and mortality rates.

## Data Visualization: 30-Day Mortality Rates for Heart Attack

### Understanding
We aimed to plot the 30-day mortality rates for heart attacks by reading data from a CSV file, converting columns to numeric values, and creating a histogram.

### Approach
1. Read the CSV file using `read.csv()`.
2. Convert the relevant column (column 11) to numeric using `as.numeric()`.
3. Handle NA values due to non-numeric entries.
4. Create a histogram using the `hist()` function to visualize mortality rate distribution.

## Hospital Ranking Functions

### Best Hospital in a State
- **Understanding:** Find the hospital with the lowest 30-day mortality rate for a given outcome and state.
- **Approach:**
  - Implemented `best()` function with state and outcome parameters.
  - Data validation and error checking.
  - Filtered data by state and outcome.
  - Sorted data by mortality rate and hospital name.
  - Returned the best hospital name or NA if unavailable.

### Ranking Hospitals by Outcome in a State
- **Understanding:** Rank hospitals within a state for a given outcome.
- **Approach:**
  - Created `rankhospital()` function with state, outcome, and num parameters.
  - Implemented ranking logic for "best", "worst", and specific numbers.
  - Sorted by mortality rate and hospital name for ties.
  - Returned the ranked hospital or NA.

### Ranking Hospitals Across All States
- **Understanding:** Rank hospitals in all states for a given outcome.
- **Approach:**
  - Implemented `rankall()` function with outcome and num parameters.
  - Processed data for all states in a loop.
  - Handled cases where data was unavailable.
  - Returned a data frame of hospital names and states.

## Relationship Between Hospital Size and Mortality Rates

### Aspect of Interest
Explored whether larger hospitals (by patient count) have lower mortality rates for heart attack, heart failure, and pneumonia.

### Key Findings
- Weak correlation (0.0683) between hospital size and mortality rates.
- Challenged the notion that larger hospitals necessarily provide better outcomes.
- Suggested that other factors like staffing, technology, and demographics may influence mortality rates.

## Challenges
- Data quality issues with missing and non-numeric values.
- Estimating patient count from available data.
- Interpreting weak correlations without overstating findings.
- Addressing confounding factors like hospital specialization and regional differences.

## Additional Analysis: Mortality Rates Across Diseases
- Compared mortality rates for heart attack, heart failure, and pneumonia.
- Found that heart attacks have the highest mortality rate (\~15%).
- Heart failure and pneumonia rates are comparable (\~11-12%).
- Highlighted the need for disease-specific interventions.

## Inference
The results indicate that hospital size does not strongly correlate with mortality rates, challenging the perception that larger hospitals inherently deliver better care. Further investigation into healthcare quality metrics is necessary to draw more nuanced conclusions.

## Video Presentation
- [Project Video Link: INFO6105.40534\_Group 7\_mini-project1](#)

## Instructions to Run the Project  

### Prerequisites  
- R installed on your system.  
- Necessary libraries: `dplyr`, `ggplot2`, `readr`, and any other packages used in the project.  

### Steps to Run  
```bash
# Clone the GitHub repository:
git clone <repository_link>

# Navigate to the project directory:
cd <repository_name>

# Set your working directory in R:
setwd("path_to_cloned_folder")

# Install necessary packages (if not already installed):
install.packages(c("dplyr", "ggplot2", "readr"))

# Verify the presence of the dataset:
# Make sure the dataset file (hospital_data.csv) is in the root folder of the cloned repository.

# Run the analysis script:
source("analysis_script.R")

# View the output files:
# The results will be saved in the results/ folder within the project directory.
# You can open the generated plots and analysis results from there.

# Troubleshooting:
# If any library is missing, install it using:
install.packages("package_name")

# Check for errors related to file paths and ensure that the dataset is correctly named as hospital_data.csv 
# and placed in the project root.

