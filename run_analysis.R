
# Libraries
 library(dplyr)
 packageVersion("dplyr")

#install.packages("data.table")
library("data.table")

#######################################################################################
#  STEP 1
#  
#  a) Define the files names that we will use in our analysis.
#  b) Define the path to test and train files
#######################################################################################
#  
#   Variables
#
# - 'working_directory': is the path to the actual defined working directory
# - 'features.txt': List of all features.
# - 'activity_labels.txt': Links the class labels with their activity name.
# - 'X_train.txt': Training set.
# - 'y_train.txt': Training labels.
# - 'X_test.txt': Test set.
# - 'y_test.txt': Test labels.
# - 'subject_train.txt': Each row identifies the subject who performed the activity 
#                        for each window sample. Its range is from 1 to 30. 
# 
#####################################################################################

working_directory <- getwd()
 
file_features <- "features.txt" 

file_x_test <- "X_test.txt"  
file_y_test <- "Y_test.txt"  
file_subject_test <- "subject_test.txt"  
 
file_x_train <- "X_train.txt"  
file_y_train <- "Y_train.txt"  
file_subject_train <- "subject_train.txt"

#Path files
path_features <- paste(working_directory, file_features, sep = "/") 

path_x_test <- paste(working_directory, file_x_test, sep = "/") 
path_y_test <- paste(working_directory, file_y_test, sep = "/") 

path_x_train <- paste(working_directory, file_x_train, sep = "/") 
path_y_train <- paste(working_directory, file_y_train, sep = "/") 

path_subject_test <- paste(working_directory, file_subject_test, sep = "/") 
path_subject_train <- paste(working_directory, file_subject_train, sep = "/") 

#########################################################################################
# 
#  STEP 2: Reading data set files and storing in the following variables 
#
#   - 'col_names': List of all features. It will be the columns names. 561rows x 2col
#   - 'test_dataset': Testing table set. 2947rows x 561cols 
#   - 'test_activity_labels': Labels activity table. 2947rows x 1col
#   - 'test_subject': Test subject table. 2947rows x 1col
#   - 'train_dataset': Training table set. 7352rows x 561cols
#   - 'train_activity_labels': Training labels. 7352rows x 1col
#   - 'train_subject': Train subjects. 7352rows x 1col
#   
##########################################################################################   

col_names <- read.table(path_features, sep = " ", header =  FALSE) 

# Read test files as data frames
test_dataset <- read.table(path_x_test, sep = "", header = FALSE) #12Mb. With tbl_df() 71 Mb
test_activity_labels <- read.table(path_y_test, sep = " ", header =  FALSE) 
test_subject <- read.table(path_subject_test, sep = " ", header =  FALSE) 
  
# Read train files as data frames
train_dataset <- read.table(path_x_train, sep = "", header = FALSE)  # 31Mb. With tbl_df() 175 Mb
train_activity_labels <- read.table(path_y_train, sep = " ", header =  FALSE) 
train_subject <- read.table(path_subject_train, sep = " ", header =  FALSE) 

###########################################################################################
#   
#  STEP 3: Merges the train and test sets to create one data set.
#     
#    - 'complete_dataset': this variable contains all the rows of the test and train data sets
#   
###########################################################################################  

complete_dataset <- as.data.frame(rbindlist(list(train_dataset, test_dataset))) # 10299x561

#Add the columns names to complete_dataset that are stored in col_names$V2.
names(complete_dataset) <- col_names$V2 # 10299x561

# Add a column in  complete_dataset with the activity labels of train and test sets stored in test_activity_labels. 
complete_dataset$activity_labels = rbindlist(list(train_activity_labels, test_activity_labels)) # 10299x562

# Add a column in complete_dataset with the data in subject of train and test variable.
complete_dataset$subject = rbindlist(list(train_subject, test_subject))# 10299x 563
 
# Set the names of the new columns
setnames(complete_dataset$activity_labels, "V1", "activity_labels")
setnames(complete_dataset$subject, "V1", "subject")
 
# Clean objects in memory
 rm(list = c("test_activity_labels","train_activity_labels", "train_subject", "test_subject",
            "test_dataset", "train_dataset", "activity_labels", "tbl_subject_total"))

#######################################################################################
#
#  STEP 4: Extracts only the measurements on the mean and standard deviation for each measurement.
#  
#  - 'grep(pattern = "mean", col_names$V2)': Extract the columns numbers with the pattern "mean()" in col_names$V2
#  - 'grep(pattern = "std", col_names$V2)': Extract the columns numbers with the patter "std()" in col_names$V2
#  - 'index_mean_std': Store all the index that we want to select as columns
#  - 'subset_mean_std': This is a subset of complete_dataset that has only the 
#                       columns contained in index_mean_std
####################################################################################### 

index_mean_std <- c(grep(pattern = "mean()", col_names$V2), grep(pattern = "std()", col_names$V2))
subset_mean_std <- subset(complete_dataset, select = c(index_mean_std, activity_labels, subject)) #10299 x 81
rm(complete_dataset, col_names)
 
#######################################################################################
#  
#  STEP 5: Uses descriptive activity names to name the activities in the data set
#  
#  1 Walking
#  2 Walking upstairs
#  3 Walking downstairs
#  4 Sitting
#  5 Standing
#  6 Laying
####################################################################################### 

activity_names <- c("Walking", "Walking upstairs", "Walking downstairs", "Sitting", "Standing", "Laying")

 for (i in 1:length(activity_names)) {
   subset_mean_std[subset_mean_std$activity_labels == i, "activity_labels"] <- activity_names[i]
 }
 
#######################################################################################
#  
#  STEP 6: From the data set in step 5, creates a second, independent tidy data set
#           with the average of each variable for each activity and each subject.
#  
#
###############################################################################
 
aggrData <- aggregate(subset_mean_std[,1:79], by = c(subset_mean_std$activity_labels, subset_mean_std$subject), FUN = mean)

 # write the data for course upload
 write.table(format(aggrData, scientific=T), "tidy2.txt",
             row.names=F, col.names=F, quote=2)
 