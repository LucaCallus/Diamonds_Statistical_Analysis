#! Require package ggplot2
#! Require package Hmisc - use mctest instead
#! Require package klaR
#! Require package mctest
#! Require package regclass
#! Require package MASS
#! Require package lmtest
#! Require package olsrr

# Detecting missing values

sum(diamonds$carat==0)
sum(diamonds$cut==0)
sum(diamonds$color==0)
sum(diamonds$clarity==0)
sum(diamonds$depth==0)
sum(diamonds$table==0)
sum(diamonds$price==0)
sum(diamonds$x==0)
sum(diamonds$y==0)
sum(diamonds$z==0)

# Changing missing values to na

diamonds$x[diamonds$x==0] = NA
diamonds$y[diamonds$y==0] = NA
diamonds$z[diamonds$z==0] = NA

# Verifying changes

sum(is.na(diamonds$x))
sum(is.na(diamonds$y))
sum(is.na(diamonds$z))

# Categorical variables are already defined as such - no need for changing

#Ch4 - Ancova:

ancova_model = lm(price ~ carat + cut + color + clarity, data=diamonds)
summary(ancova_model)


dummyCut = diamonds$cut=="Ideal" # take last level
dummyColor = diamonds$color=="J"
dummyClarity = diamonds$clarity=="IF"
dummyCut = 1*dummyCut
dummyColor = 1*dummyColor
dummyClarity = 1*dummyClarity

# x is the matrix
x = cbind(diamonds$price, diamonds$cut, diamonds$color, diamonds$clarity, diamonds$carat)
rcorr(x, type="spearman")

# VIF test
VIF(lm(diamonds$price ~., diamonds))

# CIs
model_matrix = model.matrix(~ carat + cut + color + clarity, data=diamonds)[,-1]
model_matrix_scaled = scale(model_matrix[,-1])
model_matrix_scaled = cbind("(Intercept)" = rep(1, nrow(model_matrix)), model_matrix_scaled)
svd_model_matrix = svd(model_matrix_scaled)
eigenvalues = svd_model_matrix$d^2
CI = max(svd_model_matrix$d)/svd_model_matrix$d
predictor_names = colnames(model_matrix_scaled)
#build table
ci_table = data.frame(Predictor = predictor_names,
                     Eigenvalue = round(eigenvalues, 4),
                     ConditionIndex = round(CI, 4)
)
print(ci_table, row.names=FALSE)

# CI - easier method
ancova_model_new = lm(price ~ carat + color + clarity, data=diamonds)
summary(ancova_model_new)

ols_coll_diag(ancova_model_new)

#Durbin-Watson test
dwtest(ancova_model_new)

# Anova test
anova_model_new = aov(price ~ carat + color + clarity, data=diamonds)
summary(anova_model_new)

# Studentized residuals
stud_res = studres(ancova_model_new)
stud_res_outliers = which(abs(stud_res) > 3)
stud_res_outliers

# Mahalanobis distance
model_matrix = model.matrix(~ carat + color + clarity, data=diamonds)[,-1]
m_dist = mahalanobis(model_matrix, colMeans(model_matrix), cov(model_matrix))
cutoff_mah = qchisq(0.95, df = ncol(model_matrix))
mah_outliers = which(m_dist > cutoff_mah)
mah_outliers

# Leverage
n = nrow(model_matrix)
p = length(coef(ancova_model_new))
leverage_vals = hatvalues(ancova_model_new)
cutoff_lev = (2*p)/n
lev_outliers = which(leverage_vals > cutoff_lev)
lev_outliers

# Cook's distance - returned no outliers
Cook = cooks.distance(ancova_model_new, type='rstandard')
which(Cook >= 1) #identifying the outliers cutoff=1

# Combine all into one vector
all_outliers = c(stud_res_outliers, mah_outliers, lev_outliers)

# Count how many times each index appears
outlier_table = table(all_outliers)

# Get those that appear at least twice
at_least_two_outliers = as.numeric(names(outlier_table[outlier_table >= 2]))
length(at_least_two_outliers)

# Remove outliers
diamonds_clean = diamonds[-at_least_two_outliers, ]

# Set treatment contrasts for factor variables
contrasts(diamonds_clean$clarity) <- contr.treatment(levels(diamonds_clean$clarity))
contrasts(diamonds_clean$color) <- contr.treatment(levels(diamonds_clean$color))

# Fitting the model again
model_clean = lm(price ~ carat + color + clarity, data=diamonds_clean)
summary(model_clean)

# Shapiro Wilk of residuals
res = residuals(model_clean)

hist(res, breaks = 50, main = "Histogram of Residuals", xlab = "Residuals", col = "skyblue", border = "white")
qqnorm(res)
qqline(res, col = "red", lwd = 2)

set.seed(123)  # for reproducibility
sample_res = sample(res, 5000)

shapiro.test(sample_res)

plot(predict(model_clean), residuals(model_clean), main="Plot of Fitted vs Residual")

# Breush-Pagan
bptest(model_clean)