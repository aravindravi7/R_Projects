#1 Plot the 30-day mortality rates for heart attack

outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
head(outcome)
outcome[, 11] <- as.numeric(outcome[, 11])
hist(outcome[, 11])


#######################################################################################

#2 Finding the best hospital in a state

best <- function(state, outcome) {
  # Read the data
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  # Define valid outcomes and corresponding column names
  outcome_map <- list(
    "heart attack" = "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack",
    "heart failure" = "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure",
    "pneumonia" = "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia"
  )
  
  # Validate state
  if (!state %in% data$State) {
    stop("invalid state")
  }
  
  # Validate outcome
  if (!outcome %in% names(outcome_map)) {
    stop("invalid outcome")
  }
  
  # Filter the data for the specified state and outcome
  col_name <- outcome_map[[outcome]]
  state_data <- data[data$State == state & data[[col_name]] != "Not Available", ]
  
  # Convert mortality rates to numeric for sorting
  state_data[[col_name]] <- as.numeric(state_data[[col_name]])
  
  # Sort by mortality rate and then by hospital name
  sorted_data <- state_data[order(state_data[[col_name]], state_data$Hospital.Name), ]
  
  # Return the hospital name with the best (lowest) mortality rate
  if (nrow(sorted_data) > 0) {
    return(sorted_data$Hospital.Name[1])
  } else {
    return(NA)
  }
}

#run the function till above
#check outputs

best("TX", "heart attack")
best("TX", "heart failure")
best("MD", "heart attack")
best("MD", "pneumonia")
best("BB", "heart attack")
best("NY", "hert attack")




#######################################################################################

#3 Ranking hospitals by outcome in a state

rankhospital <- function(state, outcome, num = "best") {
  # Read the data
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  # Define valid outcomes and corresponding column names
  outcome_map <- list(
    "heart attack" = "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack",
    "heart failure" = "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure",
    "pneumonia" = "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia"
  )
  
  # Validate state
  if (!state %in% data$State) {
    stop("invalid state")
  }
  
  # Validate outcome
  if (!outcome %in% names(outcome_map)) {
    stop("invalid outcome")
  }
  
  # Filter the data for the specified state and outcome
  col_name <- outcome_map[[outcome]]
  state_data <- data[data$State == state & data[[col_name]] != "Not Available", ]
  
  # Convert mortality rates to numeric
  state_data[[col_name]] <- as.numeric(state_data[[col_name]])
  
  # Sort by mortality rate and hospital name (tie-breaking)
  sorted_data <- state_data[order(state_data[[col_name]], state_data$Hospital.Name), ]
  
  # Assign unique ranks by order (no ties)
  sorted_data$Rank <- seq_len(nrow(sorted_data))
  
  # Handle "best", "worst", and numeric rankings properly
  if (num == "best") {
    return(sorted_data$Hospital.Name[1])
  } else if (num == "worst") {
    return(tail(sorted_data$Hospital.Name, 1))
  } else if (is.numeric(num) && num <= nrow(sorted_data)) {
    return(sorted_data$Hospital.Name[num])
  } else {
    return(NA)
  }
}
#run the function till above
#check outputs
rankhospital("TX", "heart failure", 4)
rankhospital("MD", "heart attack", "worst")
rankhospital("MN", "heart attack", 5000)

###########################################################################################

#4 Ranking hospitals in all states

rankall <- function(outcome, num = "best") {
  # Read the data
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  # Define valid outcomes and corresponding column names
  outcome_map <- list(
    "heart attack" = "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack",
    "heart failure" = "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure",
    "pneumonia" = "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia"
  )
  
  # Validate outcome
  if (!outcome %in% names(outcome_map)) {
    stop("invalid outcome")
  }
  
  col_name <- outcome_map[[outcome]]
  
  # Initialize an empty data frame to store results
  results <- data.frame(hospital = character(), state = character(), stringsAsFactors = FALSE)
  
  # Get unique state names
  states <- sort(unique(data$State))
  
  # Loop through each state
  for (state in states) {
    
    # Filter data by state and valid mortality rates
    state_data <- data[data$State == state & data[[col_name]] != "Not Available", ]
    
    # Skip if no valid data for the outcome in the state
    if (nrow(state_data) == 0) {
      results <- rbind(results, data.frame(hospital = NA, state = state))
      next
    }
    
    # Convert mortality rates to numeric
    state_data[[col_name]] <- as.numeric(state_data[[col_name]])
    
    # Sort by mortality rate, then by hospital name for tie-breaking
    sorted_data <- state_data[order(state_data[[col_name]], state_data$Hospital.Name), ]
    
    # Assign unique ranks
    sorted_data$Rank <- seq_len(nrow(sorted_data))
    
    # Handle "best", "worst", and numeric rankings
    if (num == "best") {
      hospital_name <- sorted_data$Hospital.Name[1]
    } else if (num == "worst") {
      hospital_name <- tail(sorted_data$Hospital.Name, 1)
    } else if (is.numeric(num) && num <= nrow(sorted_data)) {
      hospital_name <- sorted_data$Hospital.Name[num]
    } else {
      hospital_name <- NA
    }
    
    # Add the hospital and state to the results dataframe
    results <- rbind(results, data.frame(hospital = hospital_name, state = state))
  }
  
  # Return the final result
  return(results)
}
#run the function till above
#check outputs
head(rankall("heart attack", 20), 10)
tail(rankall("pneumonia", "worst"), 3)
tail(rankall("heart failure"), 10)

###########################################################################################

#5 Ask a quality question of your interest and find a Data Science answer using R

#Finding if bigger is better

# Load necessary libraries
library(dplyr)
library(ggplot2)

# Read the CSV file
data <- read.csv("outcome-of-care-measures.csv", stringsAsFactors = FALSE)

# Replace "Not Available" with NA
data[data == "Not Available"] <- NA

# Convert necessary columns to numeric
data$Heart_Attack_Rate <- as.numeric(data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack)
data$Heart_Failure_Rate <- as.numeric(data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure)
data$Pneumonia_Rate <- as.numeric(data$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia)

data$Num_Heart_Attack <- as.numeric(data$Number.of.Patients...Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack)
data$Num_Heart_Failure <- as.numeric(data$Number.of.Patients...Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure)
data$Num_Pneumonia <- as.numeric(data$Number.of.Patients...Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia)

# Replace NA values with 0
data <- data %>%
  mutate(
    Heart_Attack_Rate = ifelse(is.na(Heart_Attack_Rate), 0, Heart_Attack_Rate),
    Heart_Failure_Rate = ifelse(is.na(Heart_Failure_Rate), 0, Heart_Failure_Rate),
    Pneumonia_Rate = ifelse(is.na(Pneumonia_Rate), 0, Pneumonia_Rate),
    Num_Heart_Attack = ifelse(is.na(Num_Heart_Attack), 0, Num_Heart_Attack),
    Num_Heart_Failure = ifelse(is.na(Num_Heart_Failure), 0, Num_Heart_Failure),
    Num_Pneumonia = ifelse(is.na(Num_Pneumonia), 0, Num_Pneumonia)
  )

# Calculate total number of patients for each outcome
data <- data %>%
  mutate(
    Heart_Attack_Patients = ifelse(Heart_Attack_Rate == 0, 0, Num_Heart_Attack / (Heart_Attack_Rate * 0.01)),
    Heart_Failure_Patients = ifelse(Heart_Failure_Rate == 0, 0, Num_Heart_Failure / (Heart_Failure_Rate * 0.01)),
    Pneumonia_Patients = ifelse(Pneumonia_Rate == 0, 0, Num_Pneumonia / (Pneumonia_Rate * 0.01)),
    Total_Calculated_Patients = Heart_Attack_Patients + Heart_Failure_Patients + Pneumonia_Patients
  )

# Calculate the total reported patients
data <- data %>%
  mutate(
    Total_Reported_Patients = Num_Heart_Attack + Num_Heart_Failure + Num_Pneumonia
  )

# Compute mortality percentage
data <- data %>%
  mutate(
    Mortality_Percentage = ifelse(Total_Calculated_Patients == 0, 0, (Total_Reported_Patients * 100) / Total_Calculated_Patients)
  )
#########################################################################################
# Calculated the required data and now displaying the data####################################

# Print hospital name, reported vs calculated patients, and mortality percentage
print(data[c("Hospital.Name", "Total_Reported_Patients", "Total_Calculated_Patients", "Mortality_Percentage")])

# Calculate correlation coefficient for analysis
correlation <- cor(data$Total_Calculated_Patients, data$Mortality_Percentage, use = "complete.obs")

# Print correlation coefficient
print(paste("Correlation Coefficient:", round(correlation, 4)))


#######################Visualization#############################
# Plot mortality percentage vs. total calculated patients
ggplot(data, aes(x = Total_Calculated_Patients, y = Mortality_Percentage)) +
  geom_point(color = "blue", alpha = 0.6) +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  labs(title = "Mortality Percentage vs. Total Calculated Patients",
       x = "Total Calculated Patients",
       y = "Mortality Percentage") +
  theme_minimal()
