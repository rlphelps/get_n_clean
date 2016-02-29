# Final project for Getting and Cleaning Data course
# Created Feg 25th, 2016
# author: rphelps

# read data files into R
# This dataset was randomly partitioned into two groups - test and training.
# Nine subjects completed the test portion of the experiments and 21 subjects
# completed the training portion. The experiment was carried out using smart
# phones to measure 3-axial linear acceleration and 3-axial angular velocity
# as described on the webpage
# http://archive.ics.uci.edu/ml/datasets/
#        Human+Activity+Recognition+Using+Smartphones
# Measurements were collected while the test subject completed each of the
# following activities.
# WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING
# These activites are denoted the y_<training | test>.txt files as numbers 1-6

# TEST
# subject_test.txt, X_test.txt, y_test.txt    (files have same num of rows)

# TRAIN
# subject_train.txt, X_train.txt, y_train.txt (files have same num of rows)

# The SUBJECT files contain multiple lines with one number. Each number
# Identifies a person or subject who has completed the tests. The row in which
# any given number resides correspondes to the data in the other files for the
# same row/

# The X_<test | training>.txt files contain rows with 561 measurements each.
# Each of these measurements numerically corresponds to the features of the test
# as listed in the 'features.txt' file

# The y_<test | training>.txt files contain rows with the numbers 1 to 6 that
# correspond to the activities each subject performed

# useful libraries
library(plyr)
library(data.table)

# read in data sets
#print("Reading TEST Data into data tables")
subject_test.df = read.table("UCI HAR Dataset/test/subject_test.txt")
X_test.df = read.table("UCI HAR Dataset/test/X_test.txt")
y_test.df = read.table("UCI HAR Dataset/test/y_test.txt")

# rename cols
#print("rename V1 col in subject_test.df")
subject_test.df = rename(subject_test.df, c("V1" = "SubjectID"))
#print("rename V1 col in y_test.df")
y_test.df = rename(y_test.df, c("V1", "V1"= "Activity"))

# read in data sets
#print("Reading TRAINING Data into data tables")
subject_train.df = read.table("UCI HAR Dataset/train/subject_train.txt")
X_train.df = read.table("UCI HAR Dataset/train/X_train.txt")
y_train.df = read.table("UCI HAR Dataset/train/y_train.txt")

# rename cols
#print("rename V1 col in subject_train.df")
subject_train.df = rename(subject_train.df, c("V1" = "SubjectID"))
#print("rename V1 col in y_train.df")
y_train.df = rename(y_train.df, c("V1", "V1"= "Activity"))

# read features file and extract col indexes with mean and std values
features_ave_std = read.table("UCI HAR Dataset/features.txt")
mean_indexes =  grep("[Mm][Ee][Aa][Nn]", features_ave_std$V2)
std_indexes =   grep("[Ss][Tt][Dd]", features_ave_std$V2)

# extract required cols from measured data "X_test.df and X_train.df"
#print('Extracting required cols from X_test.df')
X_test_mean_subset  = X_test.df[,mean_indexes]
X_test_std_subset   = X_test.df[,std_indexes]
X_train_mean_subset = X_train.df[,mean_indexes]
X_train_std_subset  = X_train.df[,std_indexes]

# extract column labels for extracted data, same for train and test
X_mean_labels = data.table(subset(features_ave_std, select = V2))[mean_indexes]
X_std_labels  = data.table(subset(features_ave_std, select = V2))[std_indexes]

# rename cols to names from features file
names(X_test_mean_subset) = as.character(X_mean_labels$V2)
names(X_test_std_subset)  = as.character(X_std_labels$V2)
names(X_train_mean_subset)= as.character(X_mean_labels$V2)
names(X_train_std_subset) = as.character(X_std_labels$V2)

print('Combining TEST and TRAIN data tables')
test.df = cbind(subject_test.df, y_test.df, X_test_mean_subset, X_test_std_subset)
train.df = cbind(subject_train.df, y_train.df, X_train_mean_subset, X_train_std_subset)

print('creating final tidy data table')
combined.df = rbind(test.df, train.df)

print('Aggregating on SubjectID and Activity mean')
temp.df = aggregate(. ~SubjectID + Activity, data = combined.df, mean)

print('Sorting on SubjectID and Activity')
temp.df = temp.df[ with(temp.df, order(SubjectID, Activity)),]

# Create updated col names to be more accurate
temp_labels  = names(temp.df)
for (i in 3:length(temp_labels)) {
        temp_labels[[i]] = paste("mean(", temp_labels[[i]], ")")
}
# Update column names with new labels
names(temp.df) = temp_labels

# replace numbers with text for activities col
temp.df$Activity = gsub('1', 'Walking', temp.df$Activity)
temp.df$Activity = gsub('2', 'Walking_upstairs', temp.df$Activity)
temp.df$Activity = gsub('3', 'Walking_downstairs', temp.df$Activity)
temp.df$Activity = gsub('4', 'Sitting', temp.df$Activity)
temp.df$Activity = gsub('5', 'Standing', temp.df$Activity)
temp.df$Activity = gsub('6', 'Laying', temp.df$Activity)

# renumber the rows
rownames(temp.df) = 1:nrow(temp.df)

#  Tidy data in final form
print('Tidy data in "human_activity_recognition_measurements_means.df" object')
human_activity_recognition_measurement_means.df = temp.df

#---Uncomment the following to remove intermediate variables from RAM---#
#---and to reduce the clutter in thr Rstudio global env window---#
#rm(subject_test.df, X_test.df, y_test.df, subject_train.df, X_train.df, y_train.df)
#rm(features_ave_std, mean_indexes, std_indexes, X_test_mean_subset)
#rm(X_test_std_subset, X_train_mean_subset, X_train_std_subset)
#rm(test.df, train.df, data.df, X_mean_labels, X_std_labels)











