# Global Script varibles
X_TRAIN_PATH <- "train/X_train.txt"
Y_TRAIN_PATH <- "train/y_train.txt"
X_TEST_PATH <- "test/X_test.txt"
Y_TEST_PATH <- "test/y_test.txt"
ACTIVITY_LABELS_PATH <- "activity_labels.txt"

ACTIVITY_COLUMN_NAME <- 'Activity'

# This method:
#   1) reads data frame from path
#   2) add activity labels to main data frame
read_data_frame <- function(path, path_to_activity_label) {
  # Reading main DataFrame
  data_frame <- read.table(path, header=FALSE)
  # Adding Activity label to main DataFrame
  data_frame[ACTIVITY_COLUMN_NAME] <- read_activity_lables(path_to_activity_label)
  convert_activity_column(data_frame)
  return(data_frame)
}

# This method reads activity codes and maps it to activity labels
read_activity_lables <- function(path_to_activity_codes) {
  # Reading Activity codes
  activity_codes <- scan(path_to_activity_codes)
  # Read mapping table for Activity codes
  activity_map_table <- read.table(ACTIVITY_LABELS_PATH, header=FALSE)
  codes <- activity_map_table$V1
  labels <- activity_map_table$V2
  # Map code to labels and return
  return(labels[match(activity_codes, codes)])
}

# Reading data frames
test_data_frame <- read_data_frame(X_TEST_PATH, Y_TEST_PATH)
train_data_frame <- read_data_frame(X_TRAIN_PATH, Y_TRAIN_PATH)

# Creating total data frame
total_data_frame <- rbind(test_data_frame, train_data_frame)

