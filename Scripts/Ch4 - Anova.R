#! Require package ggplot2 - for diamonds dataset

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

# Ch4:

# Assumption 2:

sum(duplicated(diamonds))

# Create new dataset containing only independent observations
diamonds_indepObs = diamonds[!duplicated(diamonds), ]

sum(duplicated(diamonds_indepObs))

# Assumption 3:

# Create N-Way ANOVA model
model_anova = aov(price ~ cut + color + clarity, data = diamonds_indepObs)

# Normality of residuals
qqnorm(residuals(model_anova))
qqline(residuals(model_anova))

# Check homoscedasticity (equal variance)
# 1. residuals vs fitted
plot(model_anova, which = 1) 
# 2. Levene's test
leveneTest(price ~ cut * color * clarity, data = diamonds_indepObs)

# After log-transforming the price
model_anova_log = aov(log(price) ~ cut + color + clarity, data = diamonds_indepObs) # log-transform price

# Normality of residuals
qqnorm(residuals(model_anova_log))
qqline(residuals(model_anova_log))

# Check homoscedasticity (equal variance)
# 1. residuals vs fitted
plot(model_anova_log, which = 1) 
# 2. Levene's test
leveneTest(log(price) ~ cut * color * clarity, data = diamonds_indepObs) # log-transform price