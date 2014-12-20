## DS3_Proj.R

## script tools
library(data.table)
library(plyr)
library(reshape2)

## global data settings
dir.data.parent <- file.path(getwd(), "/UCI HAR Dataset")


df.names.features <- read.table(file.path(dir.data.parent, "features.txt"), 
                                colClasses = c("integer","character"),
                                col.names = c("FeatureNum", "FeatureName"))

## Identify the features you DO NOT want to read with "NULL" in a anew ColClass field
df.names.features$ColClass <- with( df.names.features, 
                                    ifelse((grepl("std()", FeatureName, fixed = TRUE)), "numeric", 
                                    ifelse((grepl("mean()", FeatureName, fixed = TRUE)), "numeric", "NULL")))

df.names.activity <- read.table(file.path(dir.data.parent, "activity_labels.txt"), 
                                colClasses = c("integer","character"),
                                col.names = c("ActivityNum", "ActivityName"))

## training data
dir.data.train <- file.path(dir.data.parent, "/train")
file.data.train.x <- file.path(dir.data.train, "X_train.txt") # train set (561-feature vectors)
file.data.train.y <- file.path(dir.data.train, "y_train.txt") # activity labels 
file.data.train.s <- file.path(dir.data.train, "subject_train.txt") # subject ID 
df.train <- cbind(read.table(file.data.train.y, colClasses = "factor"), 
                 read.table(file.data.train.s, colClasses = "numeric"), as.factor(1))

setnames(df.train, c("ActivityClass", "SubjectID", "DataRecordType"))

df.train <- cbind(df.train, read.table(file.data.train.x, col.names = df.names.features$FeatureName,
                                       colClasses = df.names.features$ColClass, check.names = FALSE ))

## test data
dir.data.test <- file.path(dir.data.parent, "/test")
file.data.test.x <- file.path(dir.data.test, "X_test.txt") # test set (561-feature vectors)
file.data.test.y <- file.path(dir.data.test, "y_test.txt") # activity values 
file.data.test.s <- file.path(dir.data.test, "subject_test.txt") # subject ID 

df.test <- cbind(read.table(file.data.test.y, colClasses = "factor"), 
                 read.table(file.data.test.s, colClasses = "numeric"), as.factor(2))

setnames(df.test, c("ActivityClass", "SubjectID", "DataRecordType"))

df.test <- cbind(df.test, read.table(file.data.test.x, col.names = df.names.features$FeatureName,
                                     colClasses = df.names.features$ColClass, check.names = FALSE ))


## final clean up
## combine training and test data
df.data <- rbind(df.train, df.test)

## add activity factor labels
df.data$ActivityClass <- factor(df.data$ActivityClass,
                                levels = df.names.activity$ActivityNum,
                                labels = df.names.activity$ActivityName)

## add label to the test/train data record identifier
df.data$DataRecordType <- factor(df.data$DataRecordType,
                                levels = c(1, 2),
                                labels = c("TEST", "TRAIN"))


## create independent tidy data set with the average of each variable for each activity and each subject.
df.melt <- melt(df.data, id.vars=c("SubjectID", "ActivityClass", "DataRecordType"))
df.summ <- ddply(df.melt, c("SubjectID", "ActivityClass", "variable"), summarise,
      mean = mean(value))

## write to file
write.table(df.summ, "tidydata.txt", row.names=FALSE, quote = FALSE)