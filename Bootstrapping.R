#Read our data in
films.df <- read.csv("films.csv")

#Chop off Names column 
films.df <- films.df[,-1]

#Number of iterations for bootstrapping
b <- 200

#Initialize error array of size b
err <- array(dim=b)

for (i in 1:b) {

	#Sample films.df with replacement of same length |films.df|
	sampleD = sample(nrow(films.df), replace=TRUE)
	B = films.df[sampleD,]
	
	#Hold-Out Method
	#Perform an 80/20 split of sampleD into a training and testing set
	split = sample(nrow(B),40)
	train = B[split,]
	test = B[-split,]
	
	#train model on training set
	svm.model = svm(Verdict ~ ., data=train, type="C-classification", kernel="linear", cost=1)
	
	#test trained model on test set
	pred = predict(svm.model,test)
	
	#Confusion matrix of test 
	cm = table(test$Verdict,pred)
	
	#calculate error
	err[i] = (cm[1,2] + cm[2,1]) / length(pred) * 100
	
}

#Sort err in ascending fashion
err <- sort(err)

print(err)

#extract lower and upper bounds for a 95% confidence interval
lb <- err[5]
ub <- err[195]

cat("lower bound is ", lb, "\n")
cat("upper bound is ", ub, "\n")