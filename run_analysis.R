#Week4 Assignment

# 1. Merges the training and the test sets to create one data set.

## training set
Xtrain <- read.table("train/X_train.txt", header = FALSE, sep = "", dec = ".")
str(Xtrain)
dim(Xtrain)

names <- read.table("features.txt", header = FALSE, sep = "", dec = ".")
str(names)
head(names)
colnames(Xtrain) <- names[, 2]

Ytrain <- read.table("train/y_train.txt", header = FALSE, sep = "", dec = ".")
colnames(Ytrain) <- c("activityID")
dim(Ytrain)
str(Ytrain)

subjecttrain <- read.table("train/subject_train.txt", header = FALSE, sep = "", dec = ".")
colnames(subjecttrain) <- c("subjectID")
dim(subjecttrain)
str(subjecttrain)

train <- cbind(subjecttrain, Ytrain, Xtrain)
head(train, 1)
dim(train)

## test set
Xtest <- read.table("test/X_test.txt", header = FALSE, sep = "", dec = ".")
colnames(Xtest) <- names[, 2]
dim(Xtest)

Ytest <- read.table("test/y_test.txt", header = FALSE, sep = "", dec = ".")
colnames(Ytest) <- c("activityID")
dim(Ytest)

subjecttest <- read.table("test/subject_test.txt", header = FALSE, sep = "", dec = ".")
colnames(subjecttest) <- c("subjectID")
dim(subjecttest)

test <- cbind(subjecttest, Ytest, Xtest)
head(test, 1)
dim(test)

## merge training and testing
mrg <- rbind(train, test)


################################################################################
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
mean <- grep("mean\\()$", names(mrg), value = TRUE)
mean
std <- grep("std\\()$", names(mrg), value = TRUE)
std
dat <- mrg[c("subjectID", "activityID", mean, std)]
head(dat)


################################################################################
# 3. Uses descriptive activity names to name the activities in the data set
activity <- read.table("activity_labels.txt", header = FALSE, sep = "", dec = ".")
head(activity)
dat$activity <- activity$V2[match(dat$activityID, activity$V1)]
head(dat)
dat$activityID <- NULL


################################################################################
# 4. Appropriately labels the data set with descriptive variable names. 
newnames <- names(dat)
newnames <- gsub("\\.", "", newnames)
newnames <- gsub("_", "", newnames)
newnames <- gsub("\\(", "", newnames)
newnames <- gsub(")", "", newnames)
newnames
names(dat) <- newnames
length(names(dat))


################################################################################
# 5. From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.
table(dat$subjectID)
library(dplyr)
names(dat)
dat2 <- 
    dat %>%
    group_by(subjectID, activity) %>%
    summarise_all(funs(mean(., na.rm = TRUE)))
head(dat2)

write.table(dat2, "tidy data.txt", row.names = FALSE)
