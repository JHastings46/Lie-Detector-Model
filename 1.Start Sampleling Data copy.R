# Load the readxl library
library(readxl)

# Read the Excel file
my_data <- read_excel("/Users/oakmoreroadinc./Desktop/Data Science /Portfolio Data Science /THP_NMD(Updated).xlsx")

# Assuming my_data is your tibble
my_data <- as.data.frame(my_data)

# Print the data frame to view it without <dbl> annotations
print(my_data)

#getting rid of all the NA's
cleaned_data <- na.omit(my_data)

# Print the cleaned data frame
print(cleaned_data)

# View the first few rows of the data
head(cleaned_data)



# Get a summary to see how the data is structured, especially the 'Result Score' column
summary(cleaned_data)

#Calculate basic measurements of data
# Summary for specific variables like 'Result Score'
summary(results)

# Frequency table for 'Result Score'
table(results)

# Proportion table for better understanding
prop.table(results)


# Assuming 'results' is your vector of trial outcomes where 1 = success, 0 = failure
# Calculate the number of trials
n <- length(results)

# Count the number of successes (where 'Result Score' equals 1)
number_of_successess <- sum(results == 1, na.rm = TRUE)

# Print the number of successes
print(paste("Number of successes:", number_of_successes))
p_successes <- sum(number_of_successess) / n  # Probability of success calculated from observed data
p_successes

p_hat <- sum(results) / n  # Probability of success calculated from observed data

# Plot the histogram of the observed results
hist(results, probability=TRUE, breaks=seq(-0.5, 1.5, by=1), main="Histogram of Observed Bernoulli Trials", col="grey", xlab="Outcome", xlim=c(-0.5, 1.5))

# Calculate the theoretical probabilities for the two possible outcomes in Bernoulli trials (0 and 1)
x <- 0:1  # Possible values for Bernoulli trials (0 or 1 successes)
y <- dbinom(x, size=1, prob=p_hat)  # Calculate probabilities using dbinom for a Bernoulli distribution

# Calculate probabilities for the outcomes of a single Bernoulli trial
print(prob_failure <- dbinom(0, size=1, prob=p_hat))  # Probability of 0 successes (failure)
print(prob_success <- dbinom(1, size=1, prob=p_hat) ) # Probability of 1 success (success)
prob_failure
prob_success
# Add the theoretical binomial distribution as lines on top of the histogram
lines(x, y, type="h", col="red", lwd=2)  # 'type="h"' creates a histogram-like line plot for clarity





# Sample Data 

# Set the seed for reproducibility
set.seed(123)

# Parameters for Bernoulli trials
size <- 1      # Each trial is a Bernoulli trial (size=1)
prob <- p_hat    # Probability of success in each trial
n <- 100         # Number of trials

# Generate Bernoulli trial data (this is equivalent to simulating individual Bernoulli trials)
sample_data <- rbinom(n, size, prob)

# Calculate probabilities for the outcomes of a single Bernoulli trial
y_0 <- dbinom(0, size, prob)  # Probability of 0 successes (failure)
y_1 <- dbinom(1, size, prob)  # Probability of 1 success (success)

# Print probabilities
print(paste("Probability of failure (0 successes):", y_0))
print(paste("Probability of success (1 success):", y_1))

# Display the histogram of the Bernoulli trials
hist(sample_data, breaks=seq(-0.5, 1.5, 1), main="Histogram of Bernoulli Trials", col="blue", xlab="Outcome", xlim=c(-0.5, 1.5), xaxt='n')
axis(1, at=c(0,1), labels=c("Failure", "Success"))

# Add the theoretical Bernoulli distribution as lines on top of the histogram
x_values <- c(0, 1)  # Points at which to place the lines
y_values <- c(y_0, y_1)  # Heights of the lines, corresponding to probabilities
lines(x_values, y_values, type="h", col="red", lwd=2)  # 'type="h"' creates a histogram-like line plot for clarity

x_bar=mean(sample_data)
x_bar
x_obs=mean(results)
x_obs


# Calculate the number of successes and failures
successes <- sum(results)
failures <- length(results) - successes
# Perform Chi-squared test
chisq.test(c(successes, failures), p=c(p_hat, 1-p_hat))

# Install the openxlsx package if it's not already installed
if (!require(openxlsx)) {
  install.packages("openxlsx", dependencies = TRUE)
  library(openxlsx)
} else {
  library(openxlsx)
}

# Assume 'cleaned_data' is your DataFrame
# Write 'cleaned_data' to an Excel file
write.xlsx(cleaned_data, file = "after_statistical_analysis_R.xlsx", rowNames = FALSE)

