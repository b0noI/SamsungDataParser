# Global Script varibles
X_TRAIN_PATH <- "train/X_train.txt"
Y_TRAIN_PATH <- "train/y_train.txt"
X_TEST_PATH <- "test/X_test.txt"
Y_TEST_PATH <- "test/y_test.txt"
ACTIVITY_LABELS_PATH <- "activity_labels.txt"
FEATURE_NAME_PATH <- "features.txt"

ACTIVITY_COLUMN_NAME <- 'Activity'

# This method:
#   1) reads data frame from path
#   2) add activity labels to main data frame
read_data_frame <- function(path, path_to_activity_label) {
  # Reading main DataFrame
  data_frame <- read.table(path, header=FALSE)
  colnames(data_frame) <- read_features_names()
  # Adding Activity label to main DataFrame
  data_frame[ACTIVITY_COLUMN_NAME] <- read_activity_lables(path_to_activity_label)
  return(data_frame)
}

read_features_names <- function() {
  data_frame <- read.table(FEATURE_NAME_PATH, header=FALSE)
  return (data_frame$V2)
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
  if (class(column) == "factor")
    return (column)
  # Calculating mean
  mean <- mean(column, na.rm = TRUE)
  # Calculating StandartDiviation
  sd <- sd(column, na.rm = TRUE)
  # Setting to NA all items that not on mean and on standart deviation
  return(sapply(column, function(x) {if (is.na(x)) return (x)
                              if (x < mean - sd || x > mean + sd) NA else x}))
}

# This method will apply filter method for each column in DataSet
filter_data_frame <- function(data_frame) {
  return(sapply(data_frame, filter_column))
}

# This function will read all DataFrames to memory
read_data_frames <- function() {
  # Reading data frames
  print("Reading Test Data Frame From file...")
  test_data_frame <<- read_data_frame(X_TEST_PATH, Y_TEST_PATH)
  print("Test Data Frame was loaded to test_data_frame")
  print("Reading Train Data Frame From file...")
  train_data_frame <<- read_data_frame(X_TRAIN_PATH, Y_TRAIN_PATH)
  print("Train Data Frame was loaded to train_data_frame")  
}

# This method will process all data frames in workspace
process_data_frames <- function() {
  # Creating total data frame
  print("Joining test_data_frame and train_data_frame...")
  total_data_frame <<- rbind(test_data_frame, train_data_frame)
  print("Joining test_data_frame and train_data_frame completed to total_data_frame")
  print("Filtering total_data_frame...")
  total_data_frame_filtered <<- data.frame(filter_data_frame(total_data_frame))
  total_data_frame_filtered[ACTIVITY_COLUMN_NAME] <<- total_data_frame[ACTIVITY_COLUMN_NAME]
  print("Filtering total_data_frame completed to total_data_frame_filtered")
}

# This method will generate TIDY set
generate_tidy <- function() {
  print("Starting TIDY generation process")
  print("Obtaining activity list...")
  activity_list <- names(table(total_data_frame_filtered[ACTIVITY_COLUMN_NAME]))
  print("activity list obtaining done")
  print("Starting tidy frame generation...")
  tidy <<- rbind(sapply(activity_list, process_average_for_activity))
  print("Tidy frame generation done")
}

# This method will calculate average per Activity
process_average_for_activity <- function(activity_name) {
  print(c("Parsing activity: ", activity_name))
  activity_data_frame <- subset(total_data_frame_filtered, total_data_frame_filtered[ACTIVITY_COLUMN_NAME] == activity_name)
  return (sapply(activity_data_frame, function(x) if (is.numeric(x)) sum(x, na.rm = TRUE) / (length(x) - sum(is.na(x))) else activity_name))
}

# This is main method that starts all logic
main <- function() {
  read_data_frames()
  
  process_data_frames()
  
  generate_tidy()
}

main()

