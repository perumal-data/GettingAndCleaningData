GettingAndCleaningData
======================
Getting and Cleaning Data Course Project:

Source of the original data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
Original description: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

- Reads feature values from "UCI HAR Dataset/features.txt and makes feature name descriptive
- Creates the train and test data sets by combining subject, activity, observed values and feature list.
	- Create train data set by combining UCI HAR Dataset/train/subject_train.txt,UCI HAR Dataset/train/Y_train.txt, UCI HAR Dataset/train/X_train.txt. Inertial Signals are ignored
	- Create test data  set by combining UCI HAR Dataset/test/subject_test.txt, UCI HAR Dataset/test/Y_test.txt,UCI HAR Dataset/test/X_test.txt. Inertial Signals are ignored.
	- Merge both train and test data set.
- Extracts only the measurements on the mean and standard deviation for each measurement. 
- Creates tidy data set with the average of each variable for each activity and each subject and appropriately labels the data set with descriptive activity names by reading activity_labels.txt and applies descriptive activity names to name the activities in the data set.
- Tidy date set is written to tidy_data_set.txt file, a 180x68 data frame. 
There are 30 subjects and 6 activities, thus 180 rows in this data set with averages.


