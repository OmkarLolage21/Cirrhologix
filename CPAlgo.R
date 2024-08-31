library(caret)
library(rpart)
library(dplyr)
liverf<-read.csv("liver_oversampled.csv")
str(liverf)
liverf<-liverf[sample(nrow(liverf)),]
columns_to_convert <- c("Sex", "Ascites", "Hepatomegal1","Edema","Stage","Drug")

liverf <- mutate_at(liverf, columns_to_convert, as.factor)
str(liverf)
set.seed(123)
num_folds<-10 
train_indices <- createDataPartition(liverf$Stage, p = 0.8, list = FALSE)
training_data <- liverf[train_indices, ]
testing_data <- liverf[-train_indices, ]
test_data<-select(testing_data,-Stage)
formula <- Stage ~ + Drug+	Hepatomegal1+	Edema+	Bilirubin	+Cholesterol+	Albumin+	Copper	+Alk_Phos+	SGOT	+Tryglicerides	+Platelets +Prothrombin

# Set up the control parameters for k-fold cross-validation
train_control <- trainControl(method = "cv", number = num_folds)
# Train the decision tree model using k-fold cross-validation


#set.seed(123)
model7 <- train(formula, data = training_data, method="rf", trControl = train_control)
cat("\n\nRANDOM FOREST\n")
# View the cross-validation results
print(model7)
predictions7 <- predict(model7, newdata = test_data) #remove y variable
# Create confusion matrix
confusion_matrix7 <- confusionMatrix(predictions7,testing_data$Stage,positive = "1")
# Print the confusion matrix
print(confusion_matrix7)

model1 <- train(formula, data = training_data, method="rpart", trControl = train_control)
cat("\n\nDECISION TREE\n")
# View the cross-validation results
print(model1)
predictions1 <- predict(model1, newdata = test_data) #remove y variable
# Create confusion matrix
confusion_matrix1 <- confusionMatrix(predictions1,testing_data$Stage,positive = "1")
# Print the confusion matrix
print(confusion_matrix1)

model2 <- train(formula, data = training_data, method="svmLinear", trControl = train_control)
cat("\n\nSUPPORT VECTOR MACHINE LINEAR\n")
# View the cross-validation results
print(model2)
predictions2 <- predict(model2, newdata = test_data) #remove y variable
# Create confusion matrix
confusion_matrix2 <- confusionMatrix(predictions2,testing_data$Stage,positive = "1")
# Print the confusion matrix
print(confusion_matrix2)


model3 <- train(formula, data = training_data, method="nnet", trControl = train_control)
cat("\n\nNeural Network\n")
# View the cross-validation results
print(model3)
predictions3 <- predict(model3, newdata = test_data) #remove y variable
# Create confusion matrix
confusion_matrix3 <- confusionMatrix(predictions3,testing_data$Stage,positive = "1")
# Print the confusion matrix
print(confusion_matrix3)


model4 <- train(formula, data = training_data, method="nb", trControl = train_control)
cat("\n\nNaive Bayes\n")
# View the cross-validation results
print(model4)
predictions4 <- predict(model4, newdata = test_data) #remove y variable
# Create confusion matrix
confusion_matrix4 <- confusionMatrix(predictions4,testing_data$Stage,positive = "1")
# Print the confusion matrix
print(confusion_matrix4)

model5 <- train(formula, data = training_data, method="svmRadial", trControl = train_control)
cat("\n\nSUPPORT VECTOR MACHINE RADIAL\n")
# View the cross-validation results
print(model5)
predictions5 <- predict(model5, newdata = test_data) #remove y variable
# Create confusion matrix
confusion_matrix5 <- confusionMatrix(predictions5,testing_data$Stage,positive = "1")
# Print the confusion matrix
print(confusion_matrix5)


model6 <- train(formula, data = training_data, method="knn", trControl = train_control)
cat("\n\nK-NEAREST NEIGHBOUR\n")
# View the cross-validation results
print(model6)
predictions6 <- predict(model6, newdata = test_data) #remove y variable
# Create confusion matrix
confusion_matrix6 <- confusionMatrix(predictions6,testing_data$Stage,positive = "1")
# Print the confusion matrix
print(confusion_matrix6)

