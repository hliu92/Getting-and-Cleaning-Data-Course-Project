# ======================================================
# Step 1: Merges the training and the test sets to create one data set.

## 1.1 Download zip file into current working directory
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, "UCI HAR Dataset.zip")

## 1.2 Unzip file and show what's inside
unzip("UCI HAR Dataset.zip")
list.files("./UCI HAR Dataset", recursive = TRUE)

## 1.3 Read data into R
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
features <- read.table("./UCI HAR Dataset/features.txt")
testsubject <- read.table("./UCI HAR Dataset/test/subject_test.txt")
testdata <- read.table("./UCI HAR Dataset/test/X_test.txt")
testlabel <- read.table("./UCI HAR Dataset/test/y_test.txt")
trainsubject <- read.table("./UCI HAR Dataset/train/subject_train.txt")
traindata <- read.table("./UCI HAR Dataset/train/X_train.txt")
trainlabel <- read.table("./UCI HAR Dataset/train/y_train.txt")

## 1.4 Merge data to create one data set
test <- cbind(testsubject,testlabel,testdata)
train <- cbind(trainsubject,trainlabel,traindata)
merged <- rbind(test, train)

# ======================================================
# Step 2: Extracts only the measurements on the mean and standard deviation for each measurement.

## 2.1 Get index of the target feature names
dataindex <- grep("mean\\(\\)|std\\(\\)", features[,2])
mergedindex <- c(1, 2, dataindex + 2)

## 2.2 Apply index to merged data set
selected <- merged[,mergedindex]

# ======================================================
# Step 3: Uses descriptive activity names to name the activities in the data set.

## 3.1 Replace activity labels with corresponding activity names
selected[,2] <- factor(selected[,2], levels = activity_labels[,1], labels = activity_labels[,2])

# ======================================================
# Step 4: Appropriately labels the data set with descriptive variable names.

## 4.1 Replace column names with meaningful feature variables
features_new <- c("subject", "activity", as.character(features[dataindex,2]))
colnames(selected) <- features_new

## 4.2 Replace abbreviations with readable words according to features_info.txt
colnames(selected) <- gsub("^t", "time", colnames(selected))
colnames(selected) <- gsub("^f", "frequency", colnames(selected))
colnames(selected) <- gsub("Acc", "Accelerometer", colnames(selected))
colnames(selected) <- gsub("Gyro", "Gyroscope", colnames(selected))
colnames(selected) <- gsub("Mag", "Magnitude", colnames(selected))

# ======================================================
# Step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## 5.1 Calculate mean for each variable grouped by subject and activity
library(dplyr)
datamean <- aggregate(selected[,3:68], by = selected[,1:2], FUN = mean)
datamean <- arrange(datamean, subject, activity)

## 5.2 Output new tidy data
write.table(datamean, file = "DataMean.txt", row.names = FALSE)