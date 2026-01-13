#! Require package ggplot2

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

# Obtaining descriptive statistics

describe(diamonds[, -c(2,3,4)]) # removing categorical variables

# Obtaining graphical statistics

# Categorical - Cut (pie chart)

summary(diamonds$cut)

slices.cut = summary(diamonds$cut)
lbls.cut = levels(diamonds$cut)
pct.cut = round(slices.cut/sum(slices.cut)*100)
lbls.cut = paste(lbls.cut, pct.cut, "%",sep=" ")

pie(slices.cut, labels = lbls.cut, main="Pie Chart of Cut")
 
# Categorical - Color (pie chart)

summary(diamonds$color)

slices.color = summary(diamonds$color)
lbls.color = levels(diamonds$color)
pct.color = round(slices.color/sum(slices.color)*100)
lbls.color = paste(lbls.color, pct.color, "%",sep=" ")

pie(slices.color, labels = lbls.color, main="Pie Chart of Color")

# Categorical - Clarity (pie chart)

summary(diamonds$clarity)

slices.clarity = summary(diamonds$clarity)
lbls.clarity = levels(diamonds$clarity)
pct.clarity = round(slices.clarity/sum(slices.clarity)*100)
lbls.clarity = paste(lbls.clarity, pct.clarity, "%", sep=" ")

pie(slices.clarity, labels = lbls.clarity, main = "Pie Chart of Clarity")

# Boxplot for Cut vs Price
ggplot(diamonds, aes(x = cut, y = price, fill = cut)) +
  geom_boxplot() +
  theme_minimal() +
  ggtitle("Boxplot of Price by Cut")

# Boxplot for Color vs Price
ggplot(diamonds, aes(x = color, y = price, fill = color)) +
  geom_boxplot() +
  theme_minimal() +
  ggtitle("Boxplot of Price by Color")

# Boxplot for Clarity vs Price
ggplot(diamonds, aes(x = clarity, y = price, fill = clarity)) +
  geom_boxplot() +
  theme_minimal() +
  ggtitle("Boxplot of Price by Clarity")

# Histogram for Carat
ggplot(diamonds, aes(x = carat)) +
  geom_histogram(binwidth = 0.1, fill = "steelblue", color = "black") +
  theme_minimal() +
  ggtitle("Histogram of Carat") +
  xlab("Carat") +
  ylab("Count")

# Histogram for Price
ggplot(diamonds, aes(x = price)) +
  geom_histogram(binwidth = 500, fill = "tomato", color = "black") +
  theme_minimal() +
  ggtitle("Histogram of Price") +
  xlab("Price") +
  ylab("Count")

# Scatter plot of Carat vs Price
ggplot(diamonds, aes(x = carat, y = price)) +
  geom_point(alpha = 0.3, color = "blue") +
  theme_minimal() +
  ggtitle("Scatter Plot of Carat vs Price") +
  xlab("Carat") +
  ylab("Price")

# Scatter plot of Carat vs Price - trend line
ggplot(diamonds, aes(x = carat, y = price)) +
  geom_point(alpha = 0.3, color = "blue") +
  geom_smooth(method = "lm", color = "red") +
  theme_minimal() +
  ggtitle("Scatter Plot of Carat vs Price with Trend Line") +
  xlab("Carat") +
  ylab("Price")

# Scatter plot of Depth vs Price
ggplot(diamonds, aes(x = depth, y = price)) +
  geom_point(alpha = 0.3, color = "blue") +
  theme_minimal() +
  ggtitle("Scatter Plot of Depth vs Price") +
  xlab("Depth") +
  ylab("Price")

# Scatter plot of Depth vs Price - trend line
ggplot(diamonds, aes(x = depth, y = price)) +
  geom_point(alpha = 0.3, color = "blue") +
  geom_smooth(method = "lm", color = "black") +
  theme_minimal() +
  ggtitle("Scatter Plot of Depth vs Price with Trend Line") +
  xlab("Depth") +
  ylab("Price")

# Scatter plot of Table vs Price
ggplot(diamonds, aes(x = table, y = price)) +
  geom_point(alpha = 0.3, color = "red") +
  theme_minimal() +
  ggtitle("Scatter Plot of Table vs Price") +
  xlab("Table") +
  ylab("Price")

# Scatter plot of Table vs Price - trend line
ggplot(diamonds, aes(x = table, y = price)) +
  geom_point(alpha = 0.3, color = "blue") +
  geom_smooth(method = "lm", color = "grey") +
  theme_minimal() +
  ggtitle("Scatter Plot of Table vs Price with Trend Line") +
  xlab("Table") +
  ylab("Price")