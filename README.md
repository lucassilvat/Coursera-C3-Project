# Coursera-C3-Project
Coursera's Johns Hopkins Data Science Specialization - Course 3 - Project

This project main motivation is subsetting data from [**Human Activity Recognition Using Smartphones Data Set**](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones), which can be downloaded from [this link](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

The user should download and extract files into the main directory. You **shouldn't** change how data is stored or delete any folder.

*run_analysis.R* performs the tasks listed below:
- It merges the training and the test sets to create one data set;
- Extracts only the measurements on the mean and standard deviation for each measurement;
- Uses descriptive activity names to name the activities in the data set;
- Labels the data set with descriptive variable names;
- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject, which then is saved in *tidy_data.txt*.

Variable names were kept from the original project, adding "mean" to the end of each variable to indicate that the average was calculated.

A CodeBook is provided in *CodeBook.MD*

