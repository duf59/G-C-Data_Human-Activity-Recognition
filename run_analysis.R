# run_analysis.R
#
# Author    : duf59
# Date      : November, 18, 2014
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


# Reading of the source data into test and training dataframes
training.subject  <- read.table("./UCI HAR Dataset/train/subject_train.txt")
training.activity <- read.table("./UCI HAR Dataset/train/y_train.txt")
training.data     <- read.table("./UCI HAR Dataset/train/X_train.txt")

test.subject  <- read.table("./UCI HAR Dataset/test/subject_test.txt")
test.activity <- read.table("./UCI HAR Dataset/test/y_test.txt")
test.data     <- read.table("./UCI HAR Dataset/test/X_test.txt")

training      <- cbind(training.subject,training.activity,training.data)
test          <- cbind(test.subject,test.activity,test.data)

# Merges the training and the test sets to create one data set.
merged.data <- rbind(training,test)

# Appropriately labels the data set with descriptive variable names
# (we clean a bit the features names and make some abbreviations more explicit)
features.names <- read.table("./UCI HAR Dataset/features.txt") # read features names
features.names <- gsub("-",".", features.names[,2])
features.names <- gsub("()","", features.names, fixed = TRUE)
features.names <- gsub("BodyBody","Body", features.names)
features.names <- gsub("Acc","Acceleration", features.names)
features.names <- gsub("Mag","Magnitude", features.names)

names(merged.data) <- c("SubjectID","Activity",features.names) # Set variables names

# Extracts only the measurements on the mean and standard deviation
mean.or.std.features <- grep("mean|std",features.names, value = TRUE)
mean.and.std.data    <- merged.data[,c("SubjectID","Activity",mean.or.std.features)]

# Add descriptive activity names to name the activities in the data set
activity.label  <- read.table("./UCI HAR Dataset/activity_labels.txt")

mean.and.std.data$Activity <- factor(mean.and.std.data$Activity,
                                     levels = activity.label[,1],
                                     labels = activity.label[,2])

# creation of the tidy dataset 'averaged.data'
averaged.data <- aggregate(. ~ SubjectID + Activity,mean.and.std.data, mean)
averaged.data <- averaged.data[order(averaged.data$Subject,averaged.data$Activity),]

names(averaged.data) <- c("SubjectID","Activity",paste("Mean.Of.",mean.or.std.features, sep = ""))

# Write the final data into text file "tidy.txt"
write.table(x = averaged.data, file = "tidy.txt", row.names = FALSE)

# to read and display the data use :
#   data <- read.table("tidy.txt", header = TRUE, check.names = FALSE)
#   View(data)

