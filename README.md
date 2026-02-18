# Diamonds Statistical Analysis 💎📊

This project is based on the '_diamonds_' dataset with **50,000+ diamonds** and investigates the relationship between a diamond's **physical attributes** and its **market price**.

Read the full <ins>research paper</ins> here: [Hypothesis Testing and Statistical Modelling on Diamonds.pdf](https://github.com/LucaCallus/Diamond-Price-Statistical-Analysis/blob/e02aa6b3c49f43758c37c0d1ad4e8db19e919a8a/Hypothesis%20Testing%20and%20Statistical%20Modelling%20on%20Diamonds.pdf)

Grade: **98/100** _(more details at the bottom)_

## Key Research Phases

### 1. Exploratory Data Analysis (EDA)
* Visualisation of price distributions and feature correlations
* Identification of outliers and data cleaning

### 2. Hypothesis Testing (Parametric & Non-Parametric)
* **Normality Testing:** Used Shapiro-Wilk to determine test suitability
* **T-Tests & ANOVA:** Analysed price differences across different Cut and Carat categories
* **Non-Parametric Alternatives:** Applied Wilcoxon Signed Rank, Mann-Whitney U and Kruskal-Wallis since normality assumptions were violated

### 3. Statistical Modelling
* **Multiple Linear Regression:** Built a model to predict diamond prices based on multiple independent variables
* **ANCOVA:** Performed Analysis of Covariance to understand the interaction between categorical attributes and continuous variables (Carat)
* **Model Validation:** Checked for multicollinearity (VIF), homoscedasticity, and residual normality among others


<table>
  <tr>
    <td><img src="Media/histogram%20of%20price.png" alt="Histogram of Price" width="100%"></td>
    <td><img src="Media/clustered%20bar%20chart%20price%20by%20carat%20and%20clarity.png" alt="Clustered Bar Chart" width="100%"></td>
  </tr>
  <tr>
    <td><img src="Media/scatter%20plot%20price%20carat.png" alt="Scatter Plot" width="100%"></td>
    <td><img src="Media/pie%20chart%20of%20cut.png" alt="Pie Chart" width="100%"></td>
  </tr>
</table>


## Tech Stack
* **Language:** R
* **Libraries:** ggplot2, FSA, Hmisc, mctest, klaR, regclass, MASS, lmtest, olsrr
* **Documentation:** Google Docs

## Repository Structure
* [Hypothesis Testing and Statistical Modelling on Diamonds.pdf](https://github.com/LucaCallus/Diamond-Price-Statistical-Analysis/blob/e02aa6b3c49f43758c37c0d1ad4e8db19e919a8a/Hypothesis%20Testing%20and%20Statistical%20Modelling%20on%20Diamonds.pdf)
* `Data/`: The diamonds dataset used for the study
* `Media/`: Images used in readme
* `Scripts/`: Raw code used for data processing and model generation

## Academic Context
* **Institution:** University of Malta
* **Course:** Hypothesis Testing and Statistical Analysis (Unit Code: SOR1232)
* **Examiner:** Derya Karagoz
* **Grade:** 98/100
