
library(data.table)
library(reshape2)

# Load activity labels and features
activity_labels <- read.table(".\\UCI HAR Dataset\\activity_labels.txt")[,2]
features <- read.table(".\\UCI HAR Dataset\\features.txt")[,2]

# Load and process the test and train data sets
test_data <- read.table(".\\UCI HAR Dataset\\test\\X_test.txt")
test_activities <- read.table(".\\UCI HAR Dataset\\test\\y_test.txt")
test_subjects <- read.table(".\\UCI HAR Dataset\\test\\subject_test.txt")
names(test_data) = features

train_data <- read.table(".\\UCI HAR Dataset\\train\\X_train.txt")
train_activities <- read.table(".\\UCI HAR Dataset\\train/y_train.txt")
train_subjects <- read.table(".\\UCI HAR Dataset\\train\\subject_train.txt")
names(train_data) = features


# Extract only the measurements on the mean and standard deviation for each measurement.
features_selected <- grepl("mean|std", features)
test_data = test_data[,features_selected]
train_data = train_data[,features_selected]

# Add activity labels and column labels
test_activities[,1] = activity_labels[test_activities[,1]]
names(test_activities) = "activity"
names(test_subjects) = "subject"

train_activities[,1] = activity_labels[train_activities[,1]]
names(train_activities) = "activity"
names(train_subjects) = "subject"

# Bind data
test <- cbind(as.data.table(test_subjects), test_data, test_activities)
train <- cbind(as.data.table(train_subjects), train_data, train_activities)

# Merge test and train datasets 
data_merged <- rbind(test, train)

id_labels <- c("subject", "activity")
data_labels <- names(train_data)
data_melt <- melt(data_merged, id = id_labels, measure.vars = data_labels)

# Apply mean function to dataset using dcast function
data_tidy <- dcast(data_melt, subject + activity ~ variable, mean)

# Safe tidy dataset
write.table(data_tidy, file = "tidy_data.txt", row.name=FALSE)