# This script does the following: 
# Creates the feature list from file and converts to descriptive feature name to use as name for columns in tidy data set
# Creates the train and test data sets by combining subject, activity, observed values and feature list
# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement. 
# Creates tidy data set with the average of each variable for each activity and each subject. 
# Appropriately labels the data set with descriptive activity names. 
# tidy date set is written to tidy_data_set.txt file.
run_analysis <- function() {
    
    # Read feature name and change to descriptive names
    features <- get_feature_lables() 
    
    # Create trainig data set
    training.data <- create_training_data_set(features)
    
    # Create test data set
    testing.data <- create_testing_data_set(features)
    
    # Merge training and testing data
    total.data <- rbind(training.data, testing.data) 
    
    # Extract only the measurements on the mean and standard deviation for each measurement
    total.mean.std.data <- total.data[, grep("Subject|Activity|Mean Value|Standard Deviation", names(total.data))]
    
    # Create  tidy data set with the average of each variable for each activity and each subject.
    tidy.data <- aggregate(total.mean.std.data[ , 3:ncol(total.mean.std.data)], 
                         list(Subject=total.mean.std.data$Subject, 
                              Activity_Code=total.mean.std.data$Activity_Code), 
                         mean)
    
    
    #Appropriately label the data set with descriptive activity names
    tidy.data <- add_activity_description(tidy.data)
    
    # Write tidy data to file
    write.table(tidy.data, "tidy_data_set.txt", row.names = FALSE)

}

# Creates training data set by combining subject, activity and observed values 
create_training_data_set <- function(features) {
    
    # Read subject data
    subject <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names="Subject")
    
    # Read activity data
    train.Y <- read.table("UCI HAR Dataset/train/Y_train.txt", col.names="Activity_Code")
    
    # Read observed values
    train.X <- read.table("UCI HAR Dataset/train/X_train.txt") 
    
    # Assign column name from feature data set
    colnames(train.X ) <- features[,2]
    
    # Combine Subject, Activity and Observed values to single data set
    training.data <- cbind(subject,train.Y,train.X) 

}

# Creates test data set by combining subject, activity and observed values  
create_testing_data_set <- function(features) {
    
    # Read subject data
    subject <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names="Subject")

    # Read activity data
    test.Y <- read.table("UCI HAR Dataset/test/Y_test.txt", col.names="Activity_Code")
    
    # Read observed values
    test.X <- read.table("UCI HAR Dataset/test/X_test.txt")  
    
    # Assign column name from feature data set
    colnames(test.X ) <- features[,2]
    
    # Combine Subject, Activity and Observed values to single data set 
    testing.data <- cbind(subject,test.Y,test.X) 

}

#Reads feature name and change to descriptive names
get_feature_lables <- function() {
    library(stringr)
    # Read feature values
    features <- read.table("UCI HAR Dataset/features.txt")
    
    #define patterns and replacements
    patterns <- c("tBodyAcc", "tGravityAcc","tBodyGyro","fBodyAcc","fBodyGyro","fBodyBodyAccJerk", 
                  "fBodyBodyGyroJerk", "-meanFreq", "-mean", "-std", "Mag")
    replacements <- c("Body Acceleration Time ", "Gravity Acceleration Time ", "Body Gyro Time ",
                      "Body Acceleration Frequency ", "Body Gyro Frequency ","Body Body Acceleration Frequency Jerk ",
                      "Body Body Gyro Frequency Jerk ", " Avg Frequency ","- Mean Value ", " - Standard Deviation ",
                      " Magnitude")
    
    #change to descriptive names
    for (id in 1:length(patterns)) {
      features$V2 <- str_replace(string=features$V2, pattern=patterns[id], replacement=replacements[id])      
    }

   features
    
}

#Appropriately label the data set with descriptive activity names
add_activity_description<-function(tidy.data) {

    # Read activity descriptions
    activity.label <- read.table("UCI HAR Dataset/activity_labels.txt", col.names=c("Activity_Code", "Activity"))
    
    #add columm with activity description
    tidy.data <- merge(activity.label, tidy.data,  by="Activity_Code")
    
    # merge moves activity _code as first column.
    # move Subject as first column after merge      
    subject_idx <- grep("Subject", names(tidy.data))
    activity_code_idx <- grep("Activity_Code", names(tidy.data))
    tidy.data <- tidy.data[, c(subject_idx , (1:ncol(tidy.data))[-subject_idx][-activity_code_idx])]
    
    # Sort by Subject
    tidy.data <- tidy.data[order(tidy.data[,1]),]
    
    # remove the row. names created while sorting
    row.names(tidy.data) <- NULL
    
    #return tidy data
    tidy.data
    
}