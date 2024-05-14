# Load the readxl library
if (!require(readxl)) install.packages("readxl", dependencies=TRUE)
library(readxl)

# Read the Excel file
my_data <- read_excel("/Users/oakmoreroadinc./Desktop/Data Science /Portfolio Data Science /THP_NMD(Updated).xlsx")

# View the first few rows of the dataset
head(my_data)

# Get a summary to see how the data is structured, especially the 'Result Score' column
summary(my_data)

# Columns in the dataset
columns <- c("Youth ID", "Gender", "PWS", "DL", "SC", "RC", "HMM", "WSL", "CEP", "LF", "Days_in_Program", "Category", "Result Score")


# Convert 'Result Score' to numeric if it's not already
my_data$`Result Score` <- as.numeric(as.character(my_data$`Result Score`))

# Count the number of successes (where 'Result Score' equals 1)
number_of_successes <- sum(my_data$`Result Score` == 1, na.rm = TRUE)

# Print the number of successes
print(paste("Number of successes:", number_of_successes))



#Calculate basic measurements of data
# Summary for specific variables like 'Result Score'
summary(my_data$`Result Score`)

# Frequency table for 'Result Score'
table(my_data$`Result Score`)

# Proportion table for better understanding
prop.table(table(my_data$`Result Score`))

# Histogram for a numerical variable like 'Days_in_Program'
hist(my_data$Days_in_Program, main="Histogram of Days in Program", xlab="Days", col="blue")

# Bar plot for 'Result Score'
barplot(table(my_data$`Result Score`), main="Bar Plot of Result Scores", ylab="Count", col="red")

# Standard deviation for all numeric variables
sapply(my_data[, sapply(my_data, is.numeric)], sd)

# Variance for a specific variable
var(my_data$Days_in_Program)
var(my_data$'Result Score')





#new df called results to call upon for convenience 
results <- my_data$`Result Score`  # Correct extraction of 'Result Score'
min(results)
max(results)


#MLE for Binomial. Estimator from observed data. 
# MLE for p
p_hat <- mean(results)  # This is equivalent to sum(results) / length(results)

# Assuming the size is the total number of trials (length of results if each row is a trial)
n <- length(results)

# Possible values of successes
x <- 0:n  # This should cover from 0 to the maximum number of trials

# Compute the binomial PDF
y <- dbinom(x, size=n, prob=p_hat)


# Plot the histogram of results
hist(results, probability=TRUE, breaks=c(0, 1, 0.1), main="My Amazing Histogram of Results", col="grey", xlab="Result Score")

# Add the binomial distribution PDF as a line on top of the histogram
lines(x, y, col="red", type="h")  # Using type='h' for a clearer depiction





#MLE for Binomial. Estimator from sample dist. 

# Set the seed for reproducibility
set.seed(123)

# Generate the binomial sample
size <- 10          # Number of trials in each experiment
prob <- 0.5         # Probability of success in each trial
n <- 100            # Number of experiments

sample_data <- rbinom(n, size, prob)
# Basic summary statistics
summary(sample_data)

# Histogram of the sample data
hist(sample_data, breaks = size + 1, main = "Histogram of Binomial Sample", xlab = "Number of Successes", col = "lightblue",
     border = "black")


#Add Binomial PDF for Comparison

# Probability of each number of successes
x_values <- 0:size
pdf_values <- dbinom(x_values, size, prob)

# Add the PDF to the histogram
hist(sample_data, breaks = size + 1, probability = TRUE, main = "Histogram with Binomial PDF", xlab = "Number of Successes", col = "lightblue", ylim=c(0, max(pdf_values)))
lines(x_values, pdf_values, type = "b", col = "red", pch = 19)
