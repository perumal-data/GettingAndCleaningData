GettingAndCleaningData
======================
Getting and Cleaning Data Course Project:

Source of the original data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
Original description: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

run_analysis.R script does the following: 
1.Creates the feature list from file and converts to descriptive feature name to use as name for columns in tidy data set.
    - Read feature values from "UCI HAR Dataset/features.txt. 
    - Following patterns and replacements are used to make feature name descriptive
		patterns ["tBodyAcc", "tGravityAcc","tBodyGyro","fBodyAcc","fBodyGyro","fBodyBodyAccJerk", 
					  "fBodyBodyGyroJerk", "-meanFreq", "-mean", "-std", "Mag"}
		replacements["Body Acceleration Time ", "Gravity Acceleration Time ", "Body Gyro Time ",
						  "Body Acceleration Frequency ", "Body Gyro Frequency ","Body Body Acceleration Frequency Jerk ",
						  "Body Body Gyro Frequency Jerk ", " Avg Frequency ","- Mean Value ", " - Standard Deviation ",
						  " Magnitude"]
    
2. Creates the train and test data sets by combining subject, activity, observed values and feature list.
	- Create train data set 
		- Read subject data from UCI HAR Dataset/train/subject_train.txt.		
		- Read activity data from UCI HAR Dataset/train/Y_train.txt.		
		- Read observed values from UCI HAR Dataset/train/X_train.txt. 
		- Assign column name from feature data set
		- Combine Subject, Activity and Observed values to single data set
		- Inertial Signals are ignored
	- Create test data  set
		- Read subject data from UCI HAR Dataset/test/subject_test.txt.		
		- Read activity data from UCI HAR Dataset/test/Y_test.txt.		
		- Read observed values from UCI HAR Dataset/test/X_test.txt. 
		- Assign column name from feature data set
		- Combine Subject, Activity and Observed values to single data set
		- Inertial Signals are ignored.
	- Merge both train and test data set.

3. Extracts only the measurements on the mean and standard deviation for each measurement. 
4. Creates tidy data set with the average of each variable for each activity and each subject. 
5. Appropriately labels the data set with descriptive activity names by reading activity_labels.txt and applies descriptive activity names to name the activities in the data set.
6. Tidy date set is written to tidy_data_set.txt file, a 180x68 data frame. 
	- First column contains subject IDs.
    - Second column contains activity.
    - Averages for each of the 66 attributes are in columns 3...68. 
	There are 30 subjects and 6 activities, thus 180 rows in this data set with averages.
