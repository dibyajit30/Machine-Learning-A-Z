# Importing the dataset
dataset = read.csv('Salary_Data.csv')

# Splitting the dataset into the Training set and Test set
# install.packages('caTools')
library(caTools)
set.seed(123)
split = sample.split(dataset$Salary, SplitRatio = 2/3)
training_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)

# Feature Scaling
# training_set = scale(training_set)
# test_set = scale(test_set)

#Fitting Simple Linear Regression model in training set
regrssor = lm(formula = Salary ~ YearsExperience, data = training_set)

#Predicting the output of test data
y_predict = predict(regrssor, newdata = test_set)

#Visualising the training set results

#install.packages("ggplot2")
library(ggplot2)

ggplot() +
  geom_point(aes(training_set$YearsExperience,training_set$Salary),
             colour='Red') +
  geom_line(aes(training_set$YearsExperience,predict(regrssor,newdata=training_set)),
             colour='Blue') +
  ggtitle("Salary vs Experience (Training set)") +
  xlab("Experience in years") +
  ylab("Salary in Euros")

#Visualising the test set results
ggplot() +
  geom_point(aes(test_set$YearsExperience,test_set$Salary),
             colour='Red') +
  geom_line(aes(training_set$YearsExperience,predict(regrssor,newdata=training_set)),
            colour='Blue') +
  ggtitle("Salary vs Experience (Test set)") +
  xlab("Experience in years") +
  ylab("Salary in Euros")
