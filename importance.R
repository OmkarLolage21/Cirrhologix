library(randomForest)

data <- read.csv("liver_oversampled.csv")

rf_model <- randomForest(Stage ~ +	Drug+	Sex+	Ascites+	Hepatomegal1+	Edema+	Bilirubin	+Cholesterol+	Albumin+	Copper	+Alk_Phos+	SGOT	+Tryglicerides	+Platelets +Prothrombin, data = data, importance = TRUE)

print(importance(rf_model))
