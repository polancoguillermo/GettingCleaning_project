# Peer-graded Assignment: Getting and Cleaning Data Course Project

Repository with data and files for the Getting and Cleaning Data course project. Data is sourced from the Human Activity recognition dataset.

Files
CodeBook.md is a codebook which describes variables, data, and any manipulations done to clean the data. 

run_analysis.R -> data preparation, following guidelines from course project's assigment.
  Data sets are merged into one data set. 
  Only mean and standard deviation for each measurement. 
  Labels updated to be descriptive. 
  Creates a new Tidy data set, grouped by activity and ID. 
  exported into a final file called tidydata.txt

Merges the training and the test sets to create one data set.
Extracts only the measurements on the mean and standard deviation for each measurement.
Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive variable names.
From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
FinalData.txt is the exported final data after going through all the sequences described above.
