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

# This method will filter vector (column)
filter_column <- function(column) {
  # if vector is not numeric we shouldn't do anything
  if (!is.numeric(column))
    return (column)
  # Calculating mean
  mean <- mean(column)
  # Calculating StandartDiviation
  sd <- sd(column)
  # Setting to NA all items that not on mean and on standart deviation
  sapply(column, function(x) if (x < mean - sd || x > mean + sd) return(NA) else return(x))
}

# This method will apply filter method for each column in DataSet
filter_data_frame <- function(data_frame) {
  data_frame_with_na <- sapply(data_frame, filter_column)
}

main <- function() {
  # Reading data frames
  print("Reading Test Data Frame From file...")
  test_data_frame <- read_data_frame(X_TEST_PATH, Y_TEST_PATH)
  print("Test Data Frame was loaded to test_data_frame")
  print("Reading Train Data Frame From file...")
  train_data_frame <- read_data_frame(X_TRAIN_PATH, Y_TRAIN_PATH)
  print("Train Data Frame was loaded to train_data_frame")
  
  # Creating total data frame
  print("Joining test_data_frame and train_data_frame...")
  total_data_frame <- rbind(test_data_frame, train_data_frame)
  print("Joining test_data_frame and train_data_frame completed to total_data_frame")
  print("Filtering total_data_frame")
  total_data_frame <- filter_data_frame(total_data_frame)
  print("Filtering total_data_frame completed")
}

main()

