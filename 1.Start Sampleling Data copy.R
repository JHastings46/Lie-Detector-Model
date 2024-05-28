#replicated the 'Results Score' column to get at least 30 observations
results<-c(1,1,0,1,0,0,1,0,0,0,1,0,1,1,1,1,1,0,1,0,1,1)

results
# Frequency table for 'Results Score'
freq_table <- table(results)
print(freq_table)

# Proportion table for better understanding
prop_table <- prop.table(freq_table)
print(prop_table)

# Calculate the number of trials
n <- length(results)
n
# Calculate the probability of success from observed data
p_hat <- sum(results) / n
p_hat

#observation varience
obs_var= p_hat*(1-p_hat)/n
obs_var

# Create a histogram of the observed data
hist(results, breaks=seq(-0.5, 1.5, by=1), col="blue", xlab="Outcome", ylab="Frequency", main="Histogram of Observed Data", xaxt='n', axes=FALSE)
axis(side=1, at=c(0, 1))  # Set x-axis labels to 0 and 1
axis(side=2)  # Add default y-axis
box()  # Add a box around the plot


# Population(simulation of the true population)
# Set the seed for reproducibility
set.seed(123)

# Parameters for Bernoulli trials
size <- 1      # Each trial is a Bernoulli trial (size=1)
prob <- 0.5   # Probability of success in each trial
n.1 <- 10000         # Number of trials

# Generate Bernoulli trial data (this is equivalent to simulating individual Bernoulli trials)
pop_data <- rbinom(n.1, size, prob)
pop_variance<-var(pop_data)
pop_variance
# Calculate probabilities for the outcomes of a single Bernoulli trial
y_0 <- dbinom(0, size, prob)  # Probability of 0 successes (failure)
y_1 <- dbinom(1, size, prob)  # Probability of 1 success (success)

# Print probabilities
print(paste("Probability of failure (0 successes):", y_0))
print(paste("Probability of success (1 success):", y_1))

# Display the histogram of the Bernoulli trials
hist(pop_data, breaks=seq(-0.5, 1.5, 1), main="Histogram of Bernoulli Trials", col="blue", xlab="Outcome", xlim=c(-0.5, 1.5), xaxt='n')
axis(1, at=c(0,1), labels=c("Failure", "Success"))

# Add the theoretical Bernoulli distribution as lines on top of the histogram
x_values <- c(0, 1)  # Points at which to place the lines
y_values <- c(y_0, y_1)  # Heights of the lines, corresponding to probabilities
lines(x_values, y_values, type="h", col="red", lwd=2)  # 'type="h"' creates a histogram-like line plot for clarity

###################################################################################
#checking for Normality 

# Replicating the 'Results Score' column to get at least 30 observations
results_30 <- rep(results, length.out = 30)

# Calculating the sample mean (proportion of successes)
p_hat_30 <- mean(results_30)

# QQ plot for the original Bernoulli data
qqnorm(results_30, main = "QQ Plot of Bernoulli Data")
qqline(results_30)

# Number of resamples
num_resamples <- 1000

# Number of observations in each resample
n.2 <- length(results_30)

# Storage for sample means
sample_means <- numeric(num_resamples)

# Generate resamples and calculate sample means
set.seed(123)  # For reproducibility
for (i in 1:num_resamples) {
  sample_means[i] <- mean(sample(results_30, size = n.2, replace = TRUE))
}

# QQ plot for the sample means
qqnorm(sample_means, main = "QQ Plot of Sample Means")
qqline(sample_means)
##################################################################################

# Get confidence intervals for p_hat=mean 
#theoretical population mean
mu=0.5
#sample_data(observation)
p_hat <- sum(results) / n
p_hat

#unbiased sample Variance
sample_var=var(results) 
sample_var
samp_sd=sqrt(sample_var)
samp_sd


#find population mean 
#calculate t sub-alpha, alpha=0.05 and using t-stat since n<30 and pop variance unknown
df=n-1
df

#95% confidence interval
alpha=0.05

cv=qt(alpha/2,df,lower.tail=FALSE)
cv
se=samp_sd/sqrt(n)
se

moe=cv*se
moe

low_interval=p_hat-moe
high_interval=p_hat+moe
low_interval=round(low_interval,4)
high_interval=round(high_interval,4)
low_interval
high_interval
#we are 95% sure that from several simulations the population mean will be between [0.3678,0.814]

##Reject H0 in favor of H1 if p_hat > - c or p_hat< + c for two tailed test
#HO:mu=0.50; H1 does NOT=0.50

mu=0.5
p_hat


#calculate "for some c"(cut off):
c.up=mu+cv*(samp_sd/sqrt(n))
c.down=mu-cv*(samp_sd/sqrt(n))
c.up
c.down

#Test shows: Fail to REJECT H0 in favor of H1 since p_hat is between [0.2768,0.723]

#calculate p_value
t=(p_hat-mu)/(samp_sd/sqrt(n))
t

p_value=2*1-(pnorm(t))
p_value
#since p_value>alpha ,Fail to reject(accept) H0!

#Find Population Variance:chi-square distribution;CI
low=qchisq(alpha/2,df,lower.tail=FALSE)
up=qchisq(1-alpha/2,df,lower.tail = FALSE)
chi_low=(df*sample_var)/low
chi_up=(df*sample_var)/up
chi_low=round(chi_low,4)
chi_up=round(chi_up,4)
chi_low
chi_up
#we are 95% confident that from several simulation the population variance will be between [0.1499,0.5172]
sample_var
pop_variance

# Test statistic
chi_sq <-(df * sample_var) / pop_variance


# P-value
p_value <- 2 * min(pchisq(chi_sq, df), 1 - pchisq(chi_sq, df))

# Output the test statistic and p-value
chi_sq
p_value

#Since the p-value is greater than 0.05, you fail to reject the null hypothesis. 
#This means there is no significant difference between the observed variance and the hypothesized population variance.

