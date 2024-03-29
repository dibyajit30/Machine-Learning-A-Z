# Importing the dataset
dataset = read.csv('Mall_Customers.csv')
dataset = dataset[4:5]

#Finding optimal no. of clusters using Elbow method
set.seed(6)
wcss = vector()
for (i in 1:10) wcss[i] = sum(kmeans(dataset,i)$withinss)
plot(1:10,
     wcss,
     type = 'b',
     main = paste('The Elbow Method'),
     xlab = 'Number of clusters',
     ylab = 'WCSS')

#Using the optimal no. of clusters for clustering using K-Means
set.seed(29)
kmeans = kmeans(x = dataset, centers = 5, iter.max = 300, nstart = 10)
y_kmeans = kmeans$cluster

#Visualizing the result
library(cluster)
clusplot(dataset,
         y_kmeans,
         lines = 0,
         shade = TRUE,
         color = TRUE,
         labels = 2,
         plotchar = FALSE,
         span = TRUE,
         main = paste('Clusters of customers'),
         xlab = 'Annual Income',
         ylab = 'Spending Score')