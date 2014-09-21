#Codebook.md


This is the code book that describes the variables, the data, transformations and work performed to clean up the data using the code *run_analysis.R*

####Background information on the data sets analyzed in this assignment

Links:
- [Description](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)


One of the most exciting areas in all of data science right now is wearable computing - see for example this [article](http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/). Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. 


The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING UPSTAIRS, WALKING DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 


####Raw data

![Diagrammatic relationship of the files in this data set](https://raw.githubusercontent.com/evillega/coursera-getting-and-cleaning-data/master/Diagram.png)

By: David Hood

Links:

-[https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) 

*The dataset includes the following files:*

* 'README.txt'
* 'features_info.txt': Shows information about the variables used on the feature vector.
* 'features.txt': List of all features.
* 'activity_labels.txt': Links the class labels with their activity name.
* 'train/X_train.txt': Training set.
* 'train/y_train.txt': Training labels.
* 'test/X_test.txt': Test set.
* 'test/y_test.txt': Test labels.
* 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. 
* 'test/subject_test.txt': Each row identifies the subject who performed the activity for each window sample. 

**Notes:** 

* Features are normalized and bounded within [-1,1].
* Each feature vector is a row on the text file.

*For more information about this dataset contact: activityrecognition@smartlab.ws*

####Code details
####i. Preparing working directory 

Created a [*Data*](https://github.com/evillega/coursera-getting-and-cleaning-data/tree/master/data) folder containing all the data sets needed for this assignment. See above for the file list.

==========================================================================================
####1. Merging the training and the test data sets to create one set
Created the following data.frame vectors:

- Features
  - Contains the list of all  561 measured features of the study.  
  - Dimension: 561 x 2.
- ActivityLabels
  - Contains the list of all  6 types of activities measured in the study.
    - WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING.
	- Dimension: 6 x 2.
- SubjectTrain
  - Each row identifies the subject, using unique numeric ID#'s for each subject, who performed the activity during the training session.
  - Dimension: 7352 x 1.
- x_Train
  - File that contains the measured features data during the training portion of the study.
  - Dimension: 7352 x 561.
- y_Train
  - File that contains the training labels.
  - Dimension: 7352 x 1.
- SubjectTest
  - Each row identifies the subject, using unique numeric ID#'s for each subject, who performed the activity during the test sessions
  - Dimension: 2947 x 1.
- x_Test
  - File that contains the measured features data during the training portion of the study.
  - Dimension: 2947 x 561.
- y_Test
  - File that contains the test labels.
  - Dimension: 2947 x 1.
- TrainMerged
  - Combined 3 data frames (x_Train, SubjectTrain, y_Train) together into one.
  - Dimension: 7352 X 563.
- TestMerged
  - Combined 3 data frames (x_Test, SubjectTest, y_Test)together into one.
  - Dimenson: 2947 x 563.
- AllData
  - Merges the TrainMerged and TestMerged data frames together into one data set.
  - Dimension: 10299 x 563.
 
Changed column labels on the data frames created above

- ActivityLabel: column names were changed from "V1" and "V2" to "ActivityID" and "ActivityType", respectively.
- SubjectTrain: Column name was changed from "V1" to "SubjectID".
- x_Train: column names were replaced from "V1, V2, ..., V561" using the labels of the measured features provided in the "Features" (e.g., tBodyAcc-mean()-X, tBodyAcc-mean()-Y, tBodyAcc-mean()-Z) vector.
- y_Train: column name was replaced to "ActivityID".
- SubjectTest: column name was changed from "V1" to "SubjectID".
- x_Test: column names were replaced from "V1, V2, ..., V561" using the labels of the measured features. provided in the "Features" (e.g., tBodyAcc-mean()-X, tBodyAcc-mean()-Y, tBodyAcc-mean()-Z) vector.
- y_Test: column name was replaced to "ActivityID".

==========================================================================================
####2. Extracts only the measurements on the mean and standard deviation for each measurement

1. Created a character vector containing the column names from the "AllData" data.frame vector. Named the vector "columnNames".  This was used to create a new data.frame vector that only contained mean "mean", standard deveation "std", "ActivityID" and "SubjectID" columns.
2. A logical vector named "MeanStdVector" was created that contained the selected columns.  Columns were selected from the "AllData" data.frame vector using character strings containing either "Activity", "Subject", "std" "mean" and "meanfreq"  using ***grepl*** command. A total of 68 columns were downselected.
3. A final table "MeanStdMeasures" data.frame consisting of the mean and standard deviations for each SubjectID and Activity measurements was created. The dimension of the data frame is 10299 x 68.

==========================================================================================
####3. Uses descriptive activity names to name the activites in the data set

1. Created a new data.frame called "MeanStdMeasures_2" that Merged "ActivityLabels" with "MeanStdMeasures" vectors by "ActivityID" using the merge command. A new column containing the Activity (e.g. WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) is added to the new data.frame.
2. Columns were rearranged so that columns 1:3 are the "SubjectID", "ActivityID", "ActivityType" column.

==========================================================================================
####4. Appropriately labels the data set with descriptive variable names

1. The column names in the "MeandStdMeasures_2" were re-labeld to make the data cleaner.  To do this a new vector called "columnNames" containing just the column names of "MeanStdMeasures_2" was created.
2.  The names were then modified using the ***gsub*** function. Character strings used are listed below:
  - "-std" replaced with "Std".
  - "-mean" replaced with "Mean".
  - "\\(\\)" replaced with "" (Note:  this function removes all "()").
  - "BodyBody" replaced with "Body".
3. The variable names, before and after the changes made in this section are listed in the "Variable Names" section below.
4. The resulting data set is named "FinalData".
5. The table was saved in the working directory called "FinalData.txt" without row names or quotes.
  - This table is then used in section 5 below. 


==========================================================================================
####5. Creates a second, independent tidy data  with the average of each variable for each activity and each subject

1. Created the final tidy data set that contains the average for each variable, activity, and subject using the ***aggregate*** command.  
2. A series of column reaarrangements and relabeling were carried out using ***merge*** command so that the first 3 columns are "SubjectID", "ActivityID", and "ActivityType", respectively.
3. The rows of the tidy data was rearranged so that the values are grouped by "SubjectID" using the ***order*** command.
4. The "ActivityType" names were cleaned up using the ***gsub*** command.  All "_" were removed from the "WALKING_DOWNSTAIRS" and "WALKING_UPSTAIRS_" names.
5. The final tidy data set is called "TidyData.txt" and is saved in the working directory using the ***write.data(TidayData,./TidyData.txt, row.names = FALSE)*** function.


==========================================================================================
####Variable Names 

Representative transforamtion of variable names

**Features**

Before | After
--- | ---
tBodyAcc-mean()-X |	tBodyAccMeanX
tBodyAcc-mean()-Y |	tBodyAccMeanY
tBodyAcc-mean()-Z |	tBodyAccMeanZ
tBodyAcc-std()-X | tBodyAccStdX

**ActivityLabels (column names)**

Before | After
--- | ---
V1 | ActivityID
V2 | ActivityType

**ActivityLabels (ActivityTypes)**

Before | After
--- | ---
WALKING |	WALKING
WALKING_UPSTAIRS | WALKING UPSTAIRS
WALKING_DOWNSTAIRS | WALKING DOWNSTAIRS
SITTING | SITTING
STANDING | STANDING
LAYING | LAYING

**SubjectTrain and SubjectTes (column name)**

Before | After
--- | ---
V1 | SubjectID

**y_Train and y_Test (column names)**

Before | After
--- | ---
V1 | ActivityID

**x_Train and x_Test (column names)**

Before | After
--- | ---
V1 | tBodyAcc-mean()-X
V2 | tBodyAcc-mean()-Y
... | ...
V561 | angle(Z,gravitymean)

==========================================================================================
######License and Disclaimers
*For more information about this dataset contact: activityrecognition@smartlab.ws*

######*License:*
*Use of this dataset in publications must be acknowledged by referencing the following publication [1]* 

*[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012.*

######*Disclaimer:*
*This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.*

*Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.*