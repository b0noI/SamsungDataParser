# Global Script varibles
X_TRAIN_PATH <- "train/X_train.txt"
Y_TRAIN_PATH <- "train/y_train.txt"
X_TEST_PATH <- "test/X_test.txt"
Y_TEST_PATH <- "test/y_test.txt"

# This method:
#   1) reads data frame from path
#   2) reads Activity labels from path to activity labels file
#   3) add activity labels to main data frame
read_data_frame <- function(path, path_to_activity_label) {
  # Reading main DataFrame
  data_set <- read.table(path, header=FALSE)
  # Reading Activity Labels
  activity_labels <- scan(path_to_activity_label)
  # Adding Activity label to main DataFrame
  data_set['Activity'] <- activity_labels
  return(data_set)
}

