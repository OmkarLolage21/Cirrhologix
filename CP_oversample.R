#KNN IMPUTATION ----
library(VIM)
library(ROSE)
library(caret)
library(dplyr)
liver<-read.csv("liver_dataset.csv")
columns_to_convert <- c("Sex", "Ascites", "Hepatomegal1", "Edema", "Stage", "Drug")
liver <- mutate_at(liver, columns_to_convert, as.factor)
liver <- mutate_at(liver, "Cholesterol", as.double)
liver<-kNN(liver)


oversampled_data <- ovun.sample(Stage ~ ., data = liver, method = "over" )
over=oversampled_data$data
print(table(over$Stage))
write.csv(over,"liver_oversampled.csv")
#create data partition

#write.csv(liver,"liver_knn.csv")
#ROSE Balancing ----
#library(ROSE)
#liver<-read.csv("liver_knn.csv")
#table(liver$Stage)
#cpy<-liver
#cpy$Stage=ifelse(cpy$Stage %in% c("1","2"),0,1)
#cpy[]<-lapply(cpy,as.factor)
#balanced_liver <- ROSE(Stage ~ ., data = cpy, seed = 123)$data
#table(balanced_liver$Stage)
#write.csv(oversampled_liver,"liver_balanced_ROSE.csv")