# run_analysis.R
#
# Author    : Rduf59
# Date      : November, 16, 2014
# R version : R-3.1.1
#
# This script was developped for the course project of "Getting and Cleaning data"
# on Coursera. It performs the following analysis :
#   - Merges the training and the test sets to create one data set.
#   - Extracts only the measurements on the mean and standard deviation. 
#   - Add descriptive activity names to name the activities in the data set.
#   - Appropriately labels the data set with descriptive variable names.
#   - Creates a second, independent tidy data set with the average of each variable
#     for each activity and each subject.
#
# Data are expected to be located in "./UCI HAR Dataset/" in R's working directory.
#
# For detailled information regarding the variables, the source data, and the transformations
# please refer to the Readme.md file.



# TO DO
# find a better way for sorting such that row numbers are re-ordered
# see marque page in firefox ....



# Read the data, defining variables names
features.names <- read.table("./UCI HAR Dataset/features.txt", stringsAsFactors = FALSE,
                             check.names = FALSE, col.names = c("feature id","feature name"))
activity.label  <- read.table("./UCI HAR Dataset/activity_labels.txt",
                              col.names = c("activity id","activity name"))

training.subject  <- read.table("./UCI HAR Dataset/train/subject_train.txt",
                                col.names = "Subject")
training.activity <- read.table("./UCI HAR Dataset/train/y_train.txt",
                                col.names = "Activity")
training.data     <- read.table("./UCI HAR Dataset/train/X_train.txt",
                                col.names = features.names[,2],
                                check.names = FALSE)

test.subject  <- read.table("./UCI HAR Dataset/test/subject_test.txt",
                            col.names = "Subject")
test.activity <- read.table("./UCI HAR Dataset/test/y_test.txt",
                            col.names = "Activity")
test.data     <- read.table("./UCI HAR Dataset/test/X_test.txt",
                            col.names = features.names[,2],
                            check.names = FALSE)

training      <- cbind(training.subject,training.activity,training.data)
test          <- cbind(test.subject,test.activity,test.data)

# Merge the two datasets. Sort by Subject and ACtivity
merged.data <- rbind(training,test)
merged.data <- merged.data[order(merged.data$Subject,merged.data$Activity),]

# Extracts measurements on the mean and standard deviation
mean.or.std.features <- grep("mean|std",features.names[,2], value = TRUE)
mean.and.std.data     <- merged.data[,c("Subject","Activity",mean.or.std.features)]

# Add descriptive activity names to name the activities in the data set

mean.and.std.data$Activity <- factor(mean.and.std.data$Activity,
                                     levels = activity.label[,1],
                                     labels = activity.label[,2])

# Creates a second, independent tidy data set with the average of each variable
# for each activity and each subject

averaged.data <- aggregate(. ~ Subject + Activity,mean.and.std.data, mean)
averaged.data <- averaged.data[order(averaged.data$Subject,averaged.data$Activity),]

# Write the final data

