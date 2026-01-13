#! Require package ggplot2
#! Require package Hmisc - use mctest instead
#! Require package klaR
#! Require package mctest
#! Require package regclass
#! Require package MASS
#! Require package lmtest

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

#Ch4 - Anova:

model = lm(price ~ cut + color + clarity, data=diamonds)
summary(model)

# Assumption 2:

dummyCut = diamonds$cut=="Ideal" # take last level
dummyColor = diamonds$color=="J"
dummyClarity = diamonds$clarity=="IF"
dummyCut = 1*dummyCut
dummyColor = 1*dummyColor
dummyClarity = 1*dummyClarity

# x is the matrix
x = cbind(dummyCut, dummyColor, dummyClarity)
rcorr(x, type="spearman")

# CIs
klaR::cond.index(price ~ cut + color + clarity, data=diamonds) # condition indices


# Studentized residuals
stud_res = studres(model)
stud_res_outliers = which(abs(stud_res) > 3)
stud_res_outliers

# Mahalanobis distance
model_matrix = model.matrix(~ cut + color + clarity, data=diamonds)[,-1]
m_dist = mahalanobis(model_matrix, colMeans(model_matrix), cov(model_matrix))
cutoff_mah = qchisq(0.95, df = ncol(model_matrix))
mah_outliers = which(m_dist > cutoff_mah)
mah_outliers

# Leverage
n = nrow(model_matrix)
p = length(coef(model))
leverage_vals = hatvalues(model)
cutoff_lev = (2*p)/n
lev_outliers = which(leverage_vals > cutoff_lev)
lev_outliers

# Cook's distance - returned no outliers
Cook = cooks.distance(model,type='rstandard')
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

# Fitting the model again
model_clean = lm(price ~ cut + color + clarity, data=diamonds_clean)
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