# Importing the dataset
dataset = read.csv('Position_Salaries.csv')
dataset = dataset[2:3]

# Splitting the dataset into the Training set and Test set
# install.packages('caTools')
#library(caTools)
#set.seed(123)
#split = sample.split(dataset$DependentVariable, SplitRatio = 0.8)
#training_set = subset(dataset, split == TRUE)
#test_set = subset(dataset, split == FALSE)

# Feature Scaling
# training_set = scale(training_set)
# test_set = scale(test_set)

#Fitting linear regression model
lin_reg = lm(formula = Salary ~ .,
             data = dataset)

#Fitting polynomial regression model
dataset$Level2 = dataset$Level^2
dataset$Level3 = dataset$Level^3
dataset$Level4 = dataset$Level^4
poly_reg = lm(formula = Salary ~ .,
              data = dataset)

#Visualising the results for linear regression
ggplot() +
  geom_point(aes(x= dataset$Level,y=dataset$Salary),
             colour="red") +
  geom_line(aes(x= dataset$Level,y=predict(lin_reg,newdata = dataset)),
            colour="blue") +
  ggtitle("Truth or Bluff (Linear regression)") +
  xlab("Level") +
  ylab("Salary")

#Visualising the results for polynomial regression
ggplot() +
  geom_point(aes(x= dataset$Level,y=dataset$Salary),
             colour="red") +
  geom_line(aes(x= dataset$Level,y=predict(poly_reg,newdata = dataset)),
            colour="blue") +
  ggtitle("Truth or Bluff (Polynomial regression)") +
  xlab("Level") +
  ylab("Salary")

#Predicting the result of linear regression
y_pred = predict(lin_reg,data.frame(Level = 6.5))

#Predicting the result of ploynomial regression
y_pred = predict(poly_reg,data.frame(Level = 6.5,
                                     Level2 = 6.5^2,
                                     Level3 = 6.5^3,
                                     Level4 = 6.5^4))