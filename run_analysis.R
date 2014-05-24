# Global Script varibles
X_TRAIN_PATH <- "train/X_train.txt"
Y_TRAIN_PATH <- "train/y_train.txt"
X_TEST_PATH <- "test/X_test.txt"
Y_TEST_PATH <- "test/y_test.txt"

# This method is using for reading vectors from file
read_vector <- function(path) {
  return (scan(file=path, sep=" "))
}

# This method is reading 2 vectors from paths and creating one DataSet from it
read_data_set <- function(path_to_left_vector, peth_to_right_vector) {
  left_vector <- read_vector(path_to_left_vector)
  right_vector <- read_vector(peth_to_right_vector)
  return (cbind(left_vector, right_vector))
}

