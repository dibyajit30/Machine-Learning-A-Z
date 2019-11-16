# Importing the dataset
dataset_org = read.delim('Restaurant_Reviews.tsv', quote = '', stringsAsFactors = FALSE)

# Cleaning the texts
#install.packages('tm')
install.packages('SnowballC')
library(SnowballC)
library(tm)
corpus = VCorpus(VectorSource(dataset_org$Review))
corpus = tm_map(corpus, content_transformer(tolower))
corpus = tm_map(corpus, removeNumbers)
corpus = tm_map(corpus, removePunctuation)
corpus = tm_map(corpus, removeWords, stopwords())
corpus = tm_map(corpus, stemDocument)
corpus = tm_map(corpus, stripWhitespace)

# Creating the bag of words
dtm = DocumentTermMatrix(corpus)
dtm = removeSparseTerms(dtm, sparse = 0.99)
dataset = as.data.frame(as.matrix(dtm))
dataset$Liked = dataset_org$Liked

# Splitting the dataset into the Training set and Test set
# install.packages('caTools')
library(caTools)
set.seed(123)
split = sample.split(dataset$Liked, SplitRatio = 0.8)
training_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)

# Fitting Random Forest Classification to the Training set
# install.packages('randomForest')
library(randomForest)
classifier = randomForest(x = training_set[-97],
                          y = training_set$Liked,
                          ntree = 10)

# Predicting the Test set results
y_pred = predict(classifier, newdata = test_set[-97])

# Making the Confusion Matrix
cm = table(test_set[, 97], y_pred)