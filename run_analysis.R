#Assignment 
##Call dplyr

library(dplyr)

#Import train data
xtrain <- read.table('~\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\train\\X_train.txt', header=FALSE)
ytrain <- read.table('~\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\train\\y_train.txt', header=FALSE)
subjecttrain <- read.table('~\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\train\\subject_train.txt', header=FALSE)

#Import test data
xtest <- read.table('~\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\test\\X_test.txt', header=FALSE)
ytest <- read.table('~\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\test\\y_test.txt', header=FALSE)
subjecttest <- read.table('~\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\test\\subject_test.txt', header=FALSE)

#import rest of data
features <- read.table('~\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\features.txt', header=FALSE)
actlabel <- read.table('~\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\activity_labels.txt', header=FALSE)

#dplyr tbl_df + rename
features <- tbl_df(features)
xtrain <- tbl_df(xtrain)
ytrain <- tbl_df(ytrain)
subtrain <- tbl_df(subjecttrain) %>%
  rename(ID=V1)
xtest <- tbl_df(xtest)
ytest <- tbl_df(ytest)
subtest <- tbl_df(subjecttest) %>%
  rename(ID=V1)

actlabel <- tbl_df(actlabel) %>%
  rename(ID=V1) %>%
  rename(Action=V2)

#Train data relabel column
#features has labels for x test and train
features <- features[,2]
feat_labels <- t(features)
colnames(xtrain) <- feat_labels
colnames(xtest) <- feat_labels

#time to merge by row
merge_x <- rbind(xtest, xtrain)
merge_y <- rbind(ytest, ytrain)
merge_subj <- rbind(subtrain, subtest)

#merge all the columns together
data_merged <- cbind(merge_x, merge_y, merge_subj)

#merge data frame combine and the actlabel
dat <- merge(data_merged, actlabel, by.x = "V1", by.y ="ID")


#Select the columns we need, and only keep mean and std

col_names <- colnames(dat)
dat_result <- select(dat, ID, Action ,grep("\\bmean\\b|\\bstd\\b",col_names))
dat_result$Action <- as.factor(dat_result$Action)

#rename the variables to be more descriptive

names(dat_result) <- gsub("Acc", "Accelerometer", names(dat_result))
names(dat_result) <- gsub("^t", "Time", names(dat_result))
names(dat_result) <- gsub("^f", "Frequency", names(dat_result))
names(dat_result) <- gsub("Mag", "Magnitude", names(dat_result))
names(dat_result) <- gsub("Gyro", "Gyroscope", names(dat_result))
names(dat_result) <- gsub("BodyBody", "Body", names(dat_result))

tidydata <- dat_result %>%
  group_by(ID, Action) %>%
  summarize_all(funs(mean))

write.table(tidydata, "tidydata.txt", row.names = F)