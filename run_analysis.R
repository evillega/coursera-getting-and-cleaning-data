
## Coursera Getting and Cleaning Data Course Project
## 2014-09-21

#==========================================================================================
# File name: run_analysis.R 
# Project description:
# This script will perform the following tasks:
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
# 1. Merge the training and the test sets to create one data set.
# 2. Extract only the measurements on the mean and standard deviation for each measurement. 
# 3. Use descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive activity names. 
# 5. Creates a second, independent tidy data set with the average of 
#    each variable for each activity and each subject. 

# The following data sets can be downloaded from the URL below
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
#==========================================================================================

#==========================================================================================
# i. Prepare directory and load any required packages
#==========================================================================================
# check working directory
getwd()

# if wrong working directory then set directory
# insert file path between the ""
setwd("~/Google Drive/Coursera-courses/Data Science/3-Getting and Cleaning Data/3-Assignment_Project/coursera-getting-and-cleaning-data")
# Clean up workspace
rm(list = ls())

# Check if "data" directory already exists.
# If not, then it creates "data" directory, where all data pertaining to this code
# are stored.  
if(!file.exists("data")) {
     dir.create("data")
}


#==========================================================================================
# 1. Merges the training and the test data sets to create one set
#==========================================================================================
# Read training data files
Features <- read.table("./Data/features.txt", header = FALSE) #imports features.txt
dim(Features) # checks dimensions: [1] 561   2
head(Features, n= 3) # checks the first 3 rows of the data table 
#   V1                V2
# 1  1 tBodyAcc-mean()-X
# 2  2 tBodyAcc-mean()-Y
# 3  3 tBodyAcc-mean()-Z

ActivityLabels <- read.table("./Data/activity_labels.txt", 
                             header = FALSE) #imports activity_labels.txt
dim(ActivityLabels) # checks dimensions: [1] 6   2
head(ActivityLabels) # checks the first 6 rows of the data table 
#   V1                 V2
# 1  1            WALKING
# 2  2   WALKING_UPSTAIRS
# 3  3 WALKING_DOWNSTAIRS
# 4  4            SITTING
# 5  5           STANDING
# 6  6             LAYING

SubjectTrain <- read.table("./Data/train/subject_train.txt", 
                           header = FALSE) #imports subject_train.txt
dim(SubjectTrain) # checks dimensions [1] 7352    1
head(SubjectTrain, n= 3) # checks the first 3 rows of the data table 
#   V1
# 1  1
# 2  1
# 3  1

x_Train <- read.table("./Data/train/x_train.txt", 
                      header = FALSE) #imports x_train.txt
dim(x_Train) # checks dimension: [1] 7352  561

y_Train <- read.table("./Data/train/y_train.txt", 
                      header = FALSE) #imports y_train.txt
dim(y_Train) # checks dimension: [1] 7352    1
head(y_Train, n= 3) # checks the first 3 rows of the data table 
#   V1
# 1  5
# 2  5
# 3  5

# Assign column names to the Train data set
colnames(ActivityLabels) <- c("ActivityID", "ActivityType") 
# replace column names to ActivityID and ActivityType
head(ActivityLabels, n= 3) #check to see if column names have been replaced
#   ActivityID       ActivityType
# 1          1            WALKING
# 2          2   WALKING_UPSTAIRS
# 3          3 WALKING_DOWNSTAIRS

colnames(SubjectTrain) <- "SubjectID" # replace column name to SubjectID
colnames(SubjectTrain) #check to see if column names have been replaced
# [1]  "SubjectID"

# replace column name with Feature names listed in column 2
colnames(x_Train) <- Features[, "V2"] 
colnames(x_Train[1:3]) # check to see if column names have been replaced
# [1] "tBodyAcc-mean()-X" "tBodyAcc-mean()-Y" "tBodyAcc-mean()-Z"                  

colnames(x_Train[559:561]) # check to see if column names have been replaced
# [1] "angle(X,gravityMean)" "angle(Y,gravityMean)" "angle(Z,gravityMean)"  

colnames(y_Train) <- "ActivityID" # replace column name to ActivityID
colnames(y_Train) # check to see if column names have been replaced
# [1] "ActivityID"


# Read Test data files
SubjectTest <- read.table("./Data/test/subject_test.txt", 
                           header = FALSE) #imports subject_test.txt
dim(SubjectTest) # checks dimensions [1] 2947    1
head(SubjectTest, n= 3) # checks the first 3 rows of the data table 
#   V1
# 1  2
# 2  2
# 3  2

x_Test <- read.table("./Data/test/x_test.txt", 
                      header = FALSE) #imports x_test.txt
dim(x_Test) # checks dimension: [1] 2947  561

y_Test <- read.table("./Data/test/y_test.txt", 
                      header = FALSE) #imports y_test.txt
dim(y_Test) # checks dimension: [1] 2947    1
head(y_Test, n= 3) # checks the first 3 rows of the data table 
#   V1
# 1  5
# 2  5
# 3  5

# Assign column names to the Test data set
colnames(SubjectTest) <- "SubjectID" # replace column name to SubjectID
colnames(SubjectTest) #check to see if column names have been replaced
# [1] "SubjectID"

colnames(x_Test) <- Features[, "V2"] 
# replace column name with Feature names listed in column 2
colnames(x_Test[1:3]) # check to see if column names have been replaced
# [1] "tBodyAcc-mean()-X" "tBodyAcc-mean()-Y" "tBodyAcc-mean()-Z"

colnames(x_Test[559:561]) # check to see if column names have been replaced
# [1] "angle(X,gravityMean)" "angle(Y,gravityMean)" "angle(Z,gravityMean)"

colnames(y_Test) <- "ActivityID" # replace column name to ActivityID
colnames(y_Test) # check to see if column names have been replaced
# [1] "ActivityID"

# Create merged training data set by columns
TrainMerged <- cbind(x_Train, SubjectTrain, y_Train)
dim(TrainMerged) # check to see if the 3 data sets have been merged by columns
# [1] 7352  563

colnames(TrainMerged[1:3]) # check column names order
# [1] "tBodyAcc-mean()-X" "tBodyAcc-mean()-Y" "tBodyAcc-mean()-Z"                  

colnames(TrainMerged[561:563]) # check column names order
# [1] "angle(Z,gravityMean)" "SubjectID" "ActivityID"   

# Create merged test data set by columns
TestMerged <- cbind(x_Test, SubjectTest, y_Test)
dim(TestMerged) # check to see if the 3 data sets have been merged by columns
# [1] 2947  563

colnames(TestMerged[1:3]) # check column names order
# [1] "tBodyAcc-mean()-X" "tBodyAcc-mean()-Y" "tBodyAcc-mean()-Z" 

colnames(TestMerged[561:563]) # check column names order
# [1] "angle(Z,gravityMean)" "SubjectID" "ActivityID" 

# Merge Training and Test data sets into one data set
AllData <- rbind(TrainMerged, TestMerged)
dim(AllData) # checks if both data sets merged
# [1] 10299   563

colnames(AllData[1:3]) # check column names order
# [1] "tBodyAcc-mean()-X" "tBodyAcc-mean()-Y" "tBodyAcc-mean()-Z"

colnames(AllData[561:563]) # check column names order
# [1] "angle(Z,gravityMean)" "SubjectID" "ActivityID"

#==========================================================================================
# 2. Extracts only the measurements on the mean and standard deviation for each
# measurement.
#==========================================================================================
# Create a character vector for the column names from the AllData table.
# This will be used to downselect to the mean, std, ActivityID and SubjectID columns
columnNames <- colnames(AllData)
columnNames[1:3] # lists the first 3 rows of the vector
# [1] "tBodyAcc-mean()-X" "tBodyAcc-mean()-Y" "tBodyAcc-mean()-Z"

columnNames[561:563] # lists the last 3 rows of the vector
# [1] "angle(Z,gravityMean)" "SubjectID" "ActivityID" 

# Create a logical vector that will be used to select the mean and std dev columns
MeanStdVector <- (grepl("Activity..", columnNames) | grepl("Subject..", columnNames) | 
                grepl("std..", columnNames) | grepl("mean..", columnNames) & 
                !grepl("-meanFreq", columnNames))
summary(MeanStdVector) # checks the number of TRUE rows selected
#    Mode   FALSE    TRUE    NA's 
# logical     495      68       0 

# Create final table that only contains the mean and std deviation values
MeanStdMeasures <- AllData[MeanStdVector == TRUE]
dim(MeanStdMeasures) # checks the dimension of the table containing only mean and std
# [1] 10299    68


#==========================================================================================
# 3. Uses descriptive activity names to name the activites in the data set
#==========================================================================================
# merge the ActivityLabels and MeanStdMeasures table together by the ActivityID column
MeanStdMeasures_2 <- merge(MeanStdMeasures, ActivityLabels, by = "ActivityID", 
                           all.x = TRUE)
dim(MeanStdMeasures_2) # checks dimension of merged data set
# [1] 10299    69
colnames(MeanStdMeasures_2[1:3]) # checks the first 3 columns
# [1] "ActivityID" "tBodyAcc-mean()-X" "tBodyAcc-mean()-Y"

colnames(MeanStdMeasures_2[67:69]) # checks the last 3 columns
# [1] "fBodyBodyGyroJerkMag-std()" "SubjectID" "ActivityType"

MeanStdMeasures_2 <- MeanStdMeasures_2[, c(68, 1, 69, 2:67)] # rearranges columns
colnames(MeanStdMeasures_2[1:3]) # checks the first 3 columns
# [1] "SubjectID"    "ActivityID"   "ActivityType"

# Write table to Data folder
write.table(MeanStdMeasures_2, "./Data/MeanStdMeasures_2.txt",row.names = FALSE,
            quote = FALSE)

#==========================================================================================
# 4. Appropriately labels the data set with descriptive variable names
#==========================================================================================
# Tidying up the variable names
columnNames <- colnames(MeanStdMeasures_2) # updates columnNames, to tidy up labels
columnNames[1:5] # checks content of columnNames
# [1] "SubjectID" "ActivityID" "ActivityType" "tBodyAcc-mean()-X" "tBodyAcc-mean()-Y"

# replace word strings in the descriptive variable names
columnNames <- gsub("-std", "Std", columnNames)
columnNames <- gsub("-mean", "Mean", columnNames)
columnNames <- gsub("\\(\\)", "", columnNames)
columnNames <- gsub("-", "", columnNames)
columnNames <- gsub("BodyBody", "Body", columnNames)

colnames(MeanStdMeasures_2) <- columnNames
FinalData <- MeanStdMeasures_2
write.table(FinalData, "./Data/FinalData.txt",row.names = FALSE,
            quote = FALSE)
#==========================================================================================
# 5. Creates a second, independent tidy data wet with the average of each variable for
# each activity and each subject
#==========================================================================================
TidyData <- aggregate(FinalData, by=list(FinalData$ActivityID, FinalData$SubjectID), 
                      FUN= mean)
# [1] "Group.1" "Group.2" SubjectID" "ActivityID" "ActivityType"

TidyData[, "ActivityType"] = NULL # Removes Activity Type
TidyData[, "Group.1"] = NULL # Removes column that is identical to ActivityID
TidyData[, "Group.2"] = NULL # Removes column that is identical to SubjectID
colnames(TidyData[1:5])
# [1] "SubjectID" "ActivityID" "tBodyAccMeanX" "tBodyAccMeanY" "tBodyAccMeanZ"

# Reintroduces ActivityType into the Tidy Data
TidyData <- merge(TidyData, ActivityLabels, by = "ActivityID", all.x = TRUE)
colnames(TidyData[1:5])
# [1] "SubjectID" "ActivityID" "tBodyAccMeanX" "tBodyAccMeanY" "tBodyAccMeanZ"

colnames(TidyData[67:69])
# [1] "fBodyGyroJerkMagMean" "fBodyGyroJerkMagStd" "ActivityType"   

# Rearranges the column 
TidyData <- TidyData[, c(2, 1, 69, 3:68 )]
colnames (TidyData[1:5])
# [1] "SubjectID" "ActivityID" "ActivityType" "tBodyAccMeanX" "tBodyAccMeanY"

#  Sorts table by SubjectID
TidyData <- TidyData[order(TidyData$SubjectID, TidyData$ActivityID), ]
TidyData[1:4,1:4] # checks sorted table
#     SubjectID ActivityID       ActivityType tBodyAccMeanX
# 1           1          1            WALKING     0.2773308
# 31          1          2   WALKING_UPSTAIRS     0.2554617
# 70          1          3 WALKING_DOWNSTAIRS     0.2891883
# 110         1          4            SITTING     0.2612376

# Cleans up ActivityType variables
TidyData$ActivityType <- gsub("_", " ", TidyData$ActivityType)
TidyData$ActivityType[1:6]
# [1] "WALKING" "WALKING UPSTAIRS" "WALKING DOWNSTAIRS" "SITTING" "STANDING" "LAYING" 

# Saves table to Data folder
write.table(TidyData, "./TidyData.txt", row.names = FALSE)

