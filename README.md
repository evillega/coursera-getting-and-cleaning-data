##Getting-and-Cleaning-Data Course Project

The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. 

####Submit the following items:
1. A tidy data set as described below.
2. A link to a Github repository with your script for performing the analysis.
3. A code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called *CodeBook.md*
4. A README.md in the repo with your scripts.
  * This *README.md* explains how all of the scripts work and how they are connected.

####Create one R script called *run_analysis.R* that does the following:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

==========================================================================================================================
####Links to the data sets and their descriptions needed to complete the assignment
- [Data Set](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) 
- [Description](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)


####File descriptions
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


==========================================================================================================================
######License and disclaimers
*For more information about this dataset contact: activityrecognition@smartlab.ws*

######*License:*
*Use of this dataset in publications must be acknowledged by referencing the following publication [1]* 

*[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012.*

######*Disclaimer:*
*This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.*

*Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.*
