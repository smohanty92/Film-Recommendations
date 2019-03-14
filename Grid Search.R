#load e1071 library
library("e1071")

#Read in our dataset
films.df <- read.csv("films.csv")

#Attach this dataset
attach(films.df)

#Chop off first column for films' names (used for viewing purposes in Excel but not for R)
films.df <- films.df[,-1]

#Build model 1
model1 <- svm(Verdict ~ ., 
			  data=films.df, 
			  type="C-classification",
			  cost=0.1,
			  kernel="linear",
              cross=5)
			  
#Build model 2
model2 <- svm(Verdict ~ ., 
			  data=films.df, 
			  type="C-classification",
			  cost=1,
			  kernel="linear",
              cross=5)

#Predict the models			  
pred1 <- fitted(model1)
pred2 <- fitted(model2)

#Construct the confusion matrices
cm1 <- table(Verdict, pred1)
cm2 <- table(Verdict, pred2)

print(cm1)
print(cm2)

model1 <- svm(HR ~ .,
              data=films.df,
              type="eps-regression",
              cost=1,
              kernel="linear",
              epsilon=1)

