# Lie Detector Model

## Project Overview
The Lie Detector Model is designed to predict the outcomes of individuals in a youth program based on various assessments and behavioral scores. This predictive model aims to determine the likelihood of a participant either succeeding (graduating) or failing (being discharged) based on their entrance assessments.

## Features
- Predictive modeling using machine learning techniques.
- Analysis of historical data from program participants.
- Utilization of logistic regression, decision trees, and other algorithms for classification.
- Extensive data handling and preprocessing in R:
  - **Data Loading and Preprocessing**: Uses `readxl` to read Excel data, ensuring smooth data handling for further analysis.
  - **Data Inspection**: Initial data exploration using functions like `head()` and `summary()` to understand the structure, especially focusing on the 'Result Score' column.
  - **Data Transformation**: Conversion of 'Result Score' from character to numeric for accurate mathematical operations.
  - **Success Counting**: Calculation of the number of successes based on the 'Result Score'.
  - **Descriptive Statistics**: Generation of basic statistics, frequency, and proportion tables to get insights into 'Result Score'.
  - **Data Visualization**: Creation of histograms and bar plots for visual insights into variables like 'Days in Program' and 'Result Score'.
  - **Advanced Statistical Analysis**: Calculation of variance and standard deviation across numeric variables in the dataset.
  - **Maximum Likelihood Estimation (MLE)**: Applies MLE to estimate the probability of success in binomial trials, enriching the model's statistical foundation.

