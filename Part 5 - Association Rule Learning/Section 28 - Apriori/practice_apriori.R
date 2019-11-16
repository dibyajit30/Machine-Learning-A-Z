#importing the dataset and preprocessing
dataset = read.csv('Market_Basket_Optimisation.csv', header = FALSE)
#install.packages('arules')
library(arules)
dataset = read.transactions('Market_Basket_Optimisation.csv', sep = ',', rm.duplicates = TRUE)
summary(dataset)
itemFrequencyPlot(dataset, topN = 50)

#Traing apriori model with dataset
rules = apriori(data = dataset, parameter = list(support=0.004,confidence=0.2))

#Visualising the results
inspect(sort(rules,by='lift')[1:10])