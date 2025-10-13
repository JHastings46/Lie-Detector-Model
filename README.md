# Predictive Modeling & Statistical Inference Projects  
**Author:** J. Hastings  
**Date:** 2024–2025  
**Language:** R  
**Keywords:** Bernoulli Distribution · Logistic Regression · PCA · GAM · Cross-Validation  

---

##  Project 1: Statistical Inference — Bernoulli Data Analysis  
**Date:** July 3, 2024  

###  Objective  
To understand the underlying success probability of a client program using **Bernoulli-distributed outcome data**  
(`1 = successful completion`, `0 = unsuccessful`).

###  Key Steps  
1. **Observed Data Analysis**  
   - Sample size: **22 participants**  
   - Probability of success (`p̂`): **0.59**  
   - Interpreted as a 59% completion rate.  

2. **Theoretical Bernoulli Distribution**  
   - Simulated 10,000 trials with `p = 0.5`.  
   - Estimated population variance ≈ **0.25**.  
   - Compared observed vs. theoretical distributions using histograms.  

3. **Normality & Resampling**  
   - Bootstrapped 1,000 samples to test sampling distribution.  
   - QQ-plot confirmed approximate normality of sample means.  

4. **Hypothesis Testing**  
   - \( H_0: \mu = 0.5 \) vs \( H_1: \mu \neq 0.5 \)  
   - t-Test p-value = **0.215** → Fail to reject \( H_0 \).  
   - 95% CI for mean: **[0.368, 0.814]**  
   - True variance test \( H_0: \sigma^2 = 0.25 \): p = **0.887** → Fail to reject \( H_0 \).  

5. **Inference**  
   - The observed success rate (≈59%) is statistically consistent with a 50% Bernoulli process.  
   - Indicates moderate but not statistically significant program improvement.  

---

## 🤖 Project 2: Statistical Modeling — Predicting Program Completion  
**Date:** June 7, 2025  

###  Objective  
To build a predictive “**Lie Detector Model**” that determines which participants are likely to **successfully complete** the program based on their **entrance assessment scores**.

###  Data Overview  
Each row represents a youth participant with scores across 8 skill domains:  
| Acronym | Category |  
|----------|-----------|  
| PWS | Permanency / Navigating Welfare System |  
| DL | Daily Living |  
| SC | Self Care |  
| RC | Relationships & Communication |  
| HMM | Housing & Money Management |  
| WSL | Work & Study Life |  
| CEP | Career & Education Planning |  
| LF | Looking Forward |  

Outcome Variable:  
- `1 = Completer`  
- `0 = Non-completer`  

---

## 🧹 Data Cleaning & Preparation  
-  No missing or duplicate rows.  
-  Standardized all assessment variables to normalize spread (SD ratio = 1.7).  
-  Principal Component Analysis (PCA) reduced 8 features → **3 PCs explaining ≥90% variance**.

---

## 🧪 Modeling Approach  

### 1. Baseline — Logistic Regression (GLM)
- Model: `Result.Score ~ PWS + DL + SC + RC + HMM + WSL + CEP + LF`  
- Validation: Leave-One-Out Cross-Validation (LOOCV)  
- Accuracy: **54.5%** vs Baseline (59.1%) → *Underperformed simple guessing*  

### 2.  Advanced — PCA + GAM (Generalized Additive Model)
- Model: `Result.Score ~ s(PC1) + PC2 + PC3 + Gender`  
- Allows for **nonlinear effects** and **interaction by Gender**.  
- LOOCV Accuracy: **77.3%**  
- 5-Fold Cross-Validation: **83% ± 0.17**  
- Baseline Accuracy: **59%**

| Metric | GLM (PC1 + Gender) | GAM (PC1–PC3 + Gender) |
|---------|--------------------|-------------------------|
| LOOCV Accuracy | 0.636 | **0.773** ✅ |
| 5-Fold Accuracy | — | **0.83 ± 0.17** |
| Baseline | 0.591 | 0.591 |
| Interpretability | High | Moderate (nonlinear) |
| Overfitting Risk | Medium | Lower (cross-validated) |

---

## 📈 Key Insights  
- **PC1** shows a **nonlinear relationship** with completion likelihood.  
- **Gender** introduces a small but noticeable shift — females generally scored higher.  
- The **GAM model captures patterns** that the simpler GLM missed.  
- **Predicted probability (example):**  
  - New female participant → **0.985 (likely completer)**  

---

## ⚖️ Interpretation: Prediction Strength vs. Statistical Significance  
Even though **PC1, PC2, PC3, and Gender** were *not statistically significant*,  
the model still **generalized well** and achieved strong predictive accuracy.  

This underscores a key trade-off:  
- **Predictive strength** ≠ **Statistical significance**.  
- The model forecasts outcomes accurately but provides less interpretive clarity about “why.”  

---

##  Next Steps  
1. **Validation:**  
   - Re-run both **GLM (PC1 + Gender)** and **GAM (PC1–PC3 + Gender)** using **LOOCV** and **10-fold CV** for stronger reliability.  
2. **Expansion:**  
   - Collect more observations to stabilize variance and improve inference power.  
3. **Simplification:**  
   - Reassess whether PC2 and PC3 add meaningful predictive value — possibly refit `s(PC1) + Gender`.  
4. **Deployment:**  
   - Package the final GAM pipeline (scaling, PCA rotation, GAM model) for real-time predictions.  
5. **Monitoring:**  
   - Continuously validate model accuracy as new data comes in to detect drift over time.  

---

## Final Conclusion  
The **GAM (PC1–PC3 + Gender)** model achieved **77–83% accuracy**, outperforming both the baseline (59%) and the simpler GLM.  
It offers **strong predictive performance** and **generalizes well** despite small sample size.  

However, because its predictors are not statistically significant, it should be viewed as a **high-performing predictive model** rather than an explanatory one.  
It provides a robust foundation for developing future tools that help identify participants most likely to succeed in the program.  

---

##  Technologies Used  
- **R 4.5.1** (macOS Sequoia 15.6.1)  
- Libraries:  
  - `mgcv` — Generalized Additive Models  
  - `caret` — Cross-validation and model assessment  
  - `ggplot2` — Visualization  
  - `glmnet` / `brglm2` — Robust logistic regression alternatives  
  - `knitr`, `rmarkdown` — Report generation  


