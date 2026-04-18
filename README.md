# Predictive Modeling & Statistical Inference Projects

**Author:** J. Hastings  
**Date:** 2024–2026  
**Language:** R  
**Keywords:** Bernoulli Distribution · PCA · GAM · Regularized Logistic Regression · LOOCV · AUC

---

## Project 1: Statistical Inference — Bernoulli Data Analysis

**Date:** July 3, 2024

### Objective
Estimate the underlying success probability of a client program using Bernoulli outcome data:

- `1` = successful completion  
- `0` = unsuccessful completion  

### Key Steps

#### Observed Data Analysis
- Sample size: `22` participants  
- Estimated completion rate: `0.59`  
- Interpreted as a 59% observed success rate  

#### Theoretical Bernoulli Distribution
- Simulated `10,000` Bernoulli trials with `p = 0.5`  
- Estimated population variance: approximately `0.25`  
- Compared observed and theoretical behavior using visual summaries  

#### Normality and Resampling
- Bootstrapped `1,000` samples  
- QQ-plot showed approximate normality of sample means  

#### Hypothesis Testing
- Tested whether the mean completion rate differed from `0.5`  
- t-test p-value: `0.215` → failed to reject the null  
- 95% confidence interval for the mean: `[0.368, 0.814]`  
- Variance test p-value: `0.887` → failed to reject the null  
- Estimated variance remained close to the Bernoulli benchmark of `0.25`  

### Inference
The observed completion rate of about **59%** was statistically consistent with a **50% Bernoulli process**. This suggests moderate program success, but not enough evidence to conclude a statistically significant improvement over chance.

---

## Project 2: Statistical Modeling — Predicting Program Completion

**Date:** Updated April 2026

### Objective
Build a predictive **Lie Detector Model** that estimates whether a participant will successfully complete the program using entrance assessment scores.

### Outcome Variable
- `1` = Completer  
- `0` = Non-completer  

### Assessment Variables
- **PWS** — Permanency / Navigating Welfare System  
- **DL** — Daily Living  
- **SC** — Self Care  
- **RC** — Relationships & Communication  
- **HMM** — Housing & Money Management  
- **WSL** — Work & Study Life  
- **CEP** — Career & Education Planning  
- **LF** — Looking Forward  

### Data Preparation
- Removed non-modeling columns such as IDs and category labels where appropriate  
- Converted outcome to binary integer form  
- Treated `Gender` as a categorical predictor  
- Applied **PCA within each training fold only** to avoid leakage  
- Used **Leave-One-Out Cross-Validation (LOOCV)** for model evaluation  

### Models Tested

#### 1. Baseline GAM
Model:
`Result.Score ~ Gender + s(Avg_Metric)`

Performance:
- **AUC:** `0.5897`
- **Sensitivity:** `0.7692`
- **Specificity:** `0.4444`

Interpretation:
The baseline model performed only slightly better than random guessing and was much better at identifying completers than non-completers.

#### 2. PCA + GAM
Model:
`Result.Score ~ Gender + s(PC1)`

Performance:
- **AUC:** `0.6068`
- **Sensitivity:** `0.7692`
- **Specificity:** `0.5556`

Interpretation:
Using PCA gave a small improvement over the baseline model and improved balance, especially for identifying non-completers.

#### 3. PCA + GLM
Model:
`Result.Score ~ Gender + PC1`

Performance:
- **AUC:** `0.6154`
- **Sensitivity:** `0.6923`
- **Specificity:** `0.5556`

Interpretation:
The GLM using PC1 performed slightly better than the GAM-based versions in overall separation, but performance was still modest.

#### 4. PCA + SMOTE + GAM
Model:
`Result.Score ~ Gender + s(PC1)`

Performance:
- **AUC:** `0.6154`
- **Accuracy:** `0.6818`
- **Sensitivity:** `0.6923`
- **Specificity:** `0.6667`

Interpretation:
SMOTE improved balance between the two classes, especially specificity, but did not improve overall AUC.

#### 5. Final Model — PCA + Regularized GLM
Model:
`Result.Score ~ Gender + PC1 + PC2`

Method:
- Ridge-regularized logistic regression using `glmnet`
- PCA trained inside each LOOCV fold
- Final production model fit on all data using the same PCA pipeline

Performance:
- **AUC:** `0.7692`
- **Accuracy:** `0.8182`
- **Sensitivity:** `0.9231`
- **Specificity:** `0.6667`

Interpretation:
This was the strongest model tested. Adding **PC2** and using **regularization** substantially improved class separation and overall prediction quality.

### Model Comparison

| Model | AUC | Accuracy | Sensitivity | Specificity |
|------|-----:|---------:|------------:|------------:|
| Baseline GAM | 0.5897 | — | 0.7692 | 0.4444 |
| PCA + GAM | 0.6068 | — | 0.7692 | 0.5556 |
| PCA + GLM | 0.6154 | — | 0.6923 | 0.5556 |
| PCA + SMOTE + GAM | 0.6154 | 0.6818 | 0.6923 | 0.6667 |
| **PCA + Regularized GLM** | **0.7692** | **0.8182** | **0.9231** | **0.6667** |

### New Data Prediction Example
Using the final regularized GLM, a new participant with the entered assessment profile received:

- **Predicted probability of completion:** `0.987`
- **Predicted class:** `1`  

Interpretation:
The model classified this participant as a **likely completer** with very high confidence.

### Key Insight
The strongest predictive performance came from combining:

- **PCA** for dimension reduction  
- **PC1 and PC2** as compressed signals from the eight assessments  
- **Ridge regularization** for a more stable logistic model on a small dataset  

This project shows that predictive performance improved meaningfully once the workflow moved beyond the baseline average-score model and into a leak-free PCA + regularization pipeline.

### Next Steps
1. Re-test the final model with repeated cross-validation or bootstrapping for stability.  
2. Add more participant records to improve reliability and reduce small-sample noise.  
3. Compare the final `PC1 + PC2 + Gender` model against a simpler `PC1 + Gender` version.  
4. Save the final PCA object and regularized GLM for real-time scoring of new cases.  
5. Monitor AUC, accuracy, sensitivity, and specificity as new data is added.  

### Final Conclusion
The final **PCA + regularized GLM** was the best-performing model in the project, achieving **0.7692 AUC** and **81.8% accuracy**, clearly outperforming the earlier GAM, GLM, and SMOTE-based versions. While the dataset is small and results should be interpreted with caution, the updated workflow provides a stronger and more stable predictive foundation for identifying participants most likely to complete the program.

---

## Technologies Used

- **R**
- **mgcv** — Generalized Additive Models  
- **glmnet** — Regularized Logistic Regression  
- **pROC** — ROC and AUC evaluation  
- **themis** — SMOTE for class balancing  
- **dplyr** — Data wrangling  
- **ggplot2** — Visualization  
- **knitr / rmarkdown** — Report generation  
