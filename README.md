
#  Lie Detector Model — Program Completion Prediction

##  Overview

This project explores whether participant entrance assessment scores can **predict successful program completion**. It’s structured in **two key phases**:

1. **Statistical Inference** — Establishing a baseline probability of completion using Bernoulli distribution and hypothesis testing.
2. **Statistical Modelling** — Building, evaluating, and comparing predictive models to determine if they can outperform the baseline accuracy.

The ultimate goal:

> 🏆 **Can I build a model that beats the baseline accuracy of 59% and generalizes well to unseen data?**

---

## 📈 Phase 1: Statistical Inference — Establishing the Baseline

The first phase focuses on understanding the underlying data before introducing any predictive model.

### Key Steps:

* Calculated the probability of success from observed Bernoulli outcomes (`p̂ = 0.59`).
* Simulated theoretical Bernoulli trials to compare observed and expected distributions.
* Constructed **confidence intervals** for mean and variance.
* Conducted **t-tests** and **chi-square tests** to validate whether the observed data significantly deviated from population parameters.
* Used QQ plots and resampling to check for normality of the sampling distribution.

✅ **Result:** Baseline accuracy = **59%**
This represents the performance level of a naïve model predicting all participants as completers.

---

## 🤖 Phase 2: Statistical Modelling — Beating the Baseline

The second phase tests different models to see if they can outperform the 59% baseline.

### Data & Features:

* **Target:** `Result.Score` (`1` = completer, `0` = non-completer)
* **Predictors:** Assessment domains

  * `PWS`, `DL`, `SC`, `RC`, `HMM`, `WSL`, `CEP`, `LF`

### Models Tested:

| Model                        | In-Sample Accuracy | LOOCV Accuracy | Outcome                      |
| ---------------------------- | ------------------ | -------------- | ---------------------------- |
| Logistic Regression          | 86%                | 60%            | Matches baseline             |
| PCA + GAM                    | 100%               | 31%            | Overfit, poor generalization |
| Composite Mean GAM           | 72%                | 75%            | Beats baseline               |
| **Composite2 (Logit + GAM)** | 86%                | **83%**        | ✅ Best performing model      |

✅ **Best Model:** Composite2 GAM — using a logistic regression–derived composite score as a single predictor.
This approach provided strong predictive power, avoided overfitting, and produced interpretable results.

---

## 🧮 Why This Matters

* **Inference first, modeling second**: By grounding the model in statistical inference, I ensured the results were meaningful and not random.
* **Cross-validation over simple accuracy**: LOOCV gave a realistic view of how the model performs on new data.
* **Interpretability**: Composite2 GAM provides a clean, understandable way to assess participant completion risk.

---

## 📊 Example Prediction

| Assessment Domain | Score |
| ----------------- | ----- |
| PWS               | 4.2   |
| DL                | 4.5   |
| SC                | 4.0   |
| RC                | 4.3   |
| HMM               | 3.9   |
| WSL               | 4.1   |
| CEP               | 4.2   |
| LF                | 4.0   |

* Predicted Probability: **0.99**
* Predicted Class: **1** (Completer)

---

## 🧰 Tech Stack

* **Language:** R
* **Key Packages:**

  * `boot` (Cross-validation)
  * `mgcv` (GAM models)
  * `stats` (GLM, inference tests)
  * `base` (data wrangling, visualization)

---

## 🚀 Next Steps

* Add more features (e.g., demographic, behavioral indicators) to strengthen model generalization.
* Validate on a larger, external dataset.
* Deploy a simple **Shiny app** or API to make predictions operational.

---

## 🧾 License

This project is for **educational and research purposes** only. No personally identifiable information is included.

---


