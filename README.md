# Week4-Assignment: 
Getting and Cleaning Data Course Project

The data for this project were downloaded at:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The script named run_analysis.R does the following.
1. Merges the training and the test sets to create one data set (rbind, cbind).
2. Extracts only the measurements on the mean and standard deviation for each measurement (grep).
3. Uses descriptive activity names to name the activities in the data set (match).
4. Appropriately labels the data set with descriptive variable names (colnames).
5.  From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject (dplyr).
