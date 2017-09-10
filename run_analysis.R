### Week 4 - Assignment
setwd("~/Desktop/Getting and Cleaning Data/Week 4/Assignment/TidyData")
## Reading the data for test
library(data.table)
library(plyr)
testData <- fread("./UCI HAR Dataset/test/X_test.txt", sep = " ")               # these are the preprocessed data without column names
features <- fread("./UCI HAR Dataset/features.txt", sep = " ")                    # this is the data defining the comunm names to be added to the data 
activitiesTestID <- fread("./UCI HAR Dataset/test/Y_test.txt", sep = " ")       # these are the activities ID to be added to the data
usersTest <- fread("./UCI HAR Dataset/test/subject_test.txt", sep = " ")        # there are the subjects ID (persons who performed the test) to be added to the data

## Adding the Names of the columns, based on the features.txt file (variable "features" in the code)
featuresNamesTest <- as.character(features$V2)                  # I set the V2 column in my features dataframe as a character vector, in order to use it to assign the names of the variables
colnames(testData) <- featuresNamesTest                         # I assign the columns names to "testData" via the featureNames vector (character vector of length 561)

## Adding the values from "activitiesID" to "testData". 
testData[, activity:= activitiesTestID$V1]                      # I add the activity column to the testData object and add in it the values found in the V1 variable of the dataframe activitiesTest
## Adding the values from "users" to "testData". 
testData[, user := usersTest$V1]                                # same principle applied here as above

## Reading the data for train
trainData <- fread("./UCI HAR Dataset/train/X_train.txt", sep = " ")            # these are the preprocessed data without column names
activitiesTrainID <- fread("./UCI HAR Dataset/train/Y_train.txt", sep = " ")    # these are the activities ID to be added to the data
usersTrain <- fread("./UCI HAR Dataset/train/subject_train.txt", sep = " ")     # there are the subjects ID (persons who performed the test) to be added to the data

## Adding the Names of the columns, based on the features.txt file (variable "features" in the code)
featuresNamesTrain <- as.character(features$V2)                 # I set the V2 column in my features dataframe as a character vector, in order to use it to assign the names of the variables
colnames(trainData) <- featuresNamesTrain                       # I assign the columns names to "testData" via the featureNames vector (character vector of length 561)

## Adding the values from "activitiesID" to "testData". 
trainData[, activity:= activitiesTrainID$V1]# I add the activity column to the trainData object and add in it the values found in the V1 variable of the dataframe activitiesTrain
# Adding the values from "users" to "testData". 
trainData[, user := usersTrain$V1]                              # same principle applied here as above

## Merging the 2 objects "testData" et "TrainData" in one : "totalData
totalData <- rbind(testData, trainData)                         # The structure of the 2 objects are exactly the same, therefore I want to add the rows together. in order to do this I use the rbind() function.

## Extract the mean and standard deviation values for each measurement/variables
meanStdData <- totalData[, grep("mean|std|user|activity", names(totalData)), with = FALSE] # I look for the string character mean or std or user or activity in the column names and I ewtract all columns containing these character strings.

## Name the activities in the data set using the file "activity_labels.txt"
activityLabels <- fread("./UCI HAR Dataset/activity_labels.txt", sep = " ")       # I load the data from the activity_labels.txt file into memory and store in activityLabels. This is the matching matrix for retrieving the activity names based on the activities IDs.
meanStdData$activity = activityLabels$V2[match(meanStdData$activity, activityLabels$V1)] # I replace the values of the colunmn activity in the meanStdData object with the activity names, using the matrix table. I look for an ID matching, and retrieve the corresponding value to write it down in the activity column.

## Name all variables with descriptive names
# Here I use the gsub function to replace unecessary character by nothing and the other character string with another one which is more explicit.
names(meanStdData) <- gsub("-|\\(|\\)","", names(meanStdData))
names(meanStdData) <- gsub("^f|freq","Frequency", names(meanStdData))
names(meanStdData) <- gsub("^t","Time", names(meanStdData))
names(meanStdData) <- gsub("Acc|acc","Accelerometer", names(meanStdData))
names(meanStdData) <- gsub("Gyro","Gyroscope", names(meanStdData))
names(meanStdData) <- gsub("std","StandardDeviation", names(meanStdData))
names(meanStdData) <- gsub("mean","Mean", names(meanStdData))
names(meanStdData) <- gsub("BodyBody|body","Body", names(meanStdData))
names(meanStdData) <- gsub("gravity","Gravity", names(meanStdData))
names(meanStdData) <- gsub("Mag|mag","Magnitude", names(meanStdData))
names(meanStdData) <- gsub("X$","Xdirection", names(meanStdData))
names(meanStdData) <- gsub("Y$","Ydirection", names(meanStdData))
names(meanStdData) <- gsub("Z$","Zdirection", names(meanStdData))
names(meanStdData) <- gsub("Jerk|jerk","Jerk", names(meanStdData))
names(meanStdData) <- gsub("Freq","Frequency", names(meanStdData))
names(meanStdData) <- gsub("activity","Activity", names(meanStdData))
names(meanStdData) <- gsub("user","User", names(meanStdData))

## create a new data set with mean for all values for each subjects and each activity 
#calculate mean for all measurements for each subject and each activity
tidyDataSet <- aggregate(. ~Activity + User, meanStdData, mean)                 # First, I calculate the mean for all the columns by activity and by user, usng the aggregate() function. "." here means all columns in the dataframe.

## create a new file .txt
write.table(tidyDataSet, file = "tidyData.txt", sep = " ", row.names = FALSE, col.names = TRUE) # Last step is to create the .txt file using the write.table().
