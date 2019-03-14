#read in datasets
train=read.csv("films.csv", stringsAsFactors=F)
test=read.csv("testFilms.csv", stringsAsFactors=F)

#Chop off first column of csv for Film Title
train=train[,-1]
test=test[,-1]

#"normalize" levels to prevent "test data does not match model !." error when predicting
directors <- unique(c(train$Director, test$Director))
test$Director  <- factor(test$Director, levels=directors)
train$Director <- factor(train$Director, levels=directors)

leads <- unique(c(train$Lead, test$Lead))
test$Lead  <- factor(test$Lead, levels=leads)
train$Lead <- factor(train$Lead, levels=leads)

supportings <- unique(c(train$Supporting, test$Supporting))
test$Supporting  <- factor(test$Supporting, levels=supportings)
train$Supporting <- factor(train$Supporting, levels=supportings)

genres <- unique(c(train$Genre, test$Genre))
test$Genre  <- factor(test$Genre, levels=genres)
train$Genre <- factor(train$Genre, levels=genres)

decades <- unique(c(train$Decade, test$Decade))
test$Decade  <- factor(test$Decade, levels=decades)
train$Decade <- factor(train$Decade, levels=decades)

verdicts <- unique(c(train$Verdict, test$Verdict))
test$Verdict  <- factor(test$Verdict, levels=verdicts)
train$Verdict <- factor(train$Verdict, levels=verdicts)

#predict
svm_model<-svm(Verdict ~.,data=train)
pred<-predict(svm_model,test)