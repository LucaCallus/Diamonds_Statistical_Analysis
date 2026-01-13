#! Require package ggplot2 - for diamonds dataset
#! Require package FSA - for dunn test

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

# CH3:

# 1) Perform Shapiro-Wilk test on a random sample of 5000 prices (since dataset is large)
set.seed(123)  # For reproducibility
sample_prices = sample(diamonds$price, 5000)

shapiro.test(sample_prices)


# 2) Wilcoxon signed rank test (Non-parametric alternative of One-Sample T-test)

sum(diamonds$carat==0.3)
sum(diamonds$carat==0.5)
sum(diamonds$carat==1)

# Filter datasets by carat weight
diamonds_0.3 = subset(diamonds, carat == 0.3)
diamonds_0.5 = subset(diamonds, carat == 0.5)
diamonds_1.0 = subset(diamonds, carat == 1.0)

# For 0.3 carat diamonds
# Two-tailed test
wilcox.test(diamonds_0.3$price, mu = 503, alternative = "two.sided")

# One-tailed test (greater)
wilcox.test(diamonds_0.3$price, mu = 503, alternative = "greater")

# For 0.5 carat diamonds
# Two-tailed test
wilcox.test(diamonds_0.5$price, mu = 1042, alternative = "two.sided")

# One-tailed test (greater)
wilcox.test(diamonds_0.5$price, mu = 1042, alternative = "greater")

# For 1 carat diamonds
# Two-tailed test
wilcox.test(diamonds_1.0$price, mu = 3678, alternative = "two.sided")

# One-tailed test (greater)
wilcox.test(diamonds_1.0$price, mu = 3678, alternative = "greater")


# 3) Mann-Whitney U Test (Non-parametric alternative of Independent Samples T-test)

# Calculate the mean carat value
mean_carat = mean(diamonds$carat)

# Create the two subsets
subset_lower_carat = subset(diamonds, diamonds$carat < mean_carat)
subset_higher_carat = subset(diamonds, diamonds$carat >= mean_carat)

# Perform Mann-Whitney U test
wilcox_test_carat = wilcox.test(subset_lower_carat$price, subset_higher_carat$price, alternative="less")

# Print the results
print(wilcox_test_carat)


# 4) Perform Kruskal-Wallis Test on Price (x) and Cut (y) (Non-parametric alternative of One-Way Anova)
kruskal_result = kruskal.test(price ~ cut, data = diamonds)

print(kruskal_result)

# If Kruskal-Wallis is significant, perform Dunn’s post-hoc test
if (kruskal_result$p.value < 0.05) {
  dunn_results = dunnTest(diamonds$price, diamonds$cut, method = "bonferroni")
  
  # Print Dunn's test results
  print(dunn_results)
}