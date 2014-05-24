1. High level process
==================

All actions in script can be separated on 3 main steps:
* reading data;
* processing (joining/cleaning);
* generating tidy data frame.
 
2. Steps
=====

2.1 Reading data
---

Reading data are perfomed with read_data_frames() method. This method will read next data frames:
* test_data_frame;
* train_data_frame.
It will read this data frames as is without any filtering. After reading this method will add to each data frame:
* feature names (column names);
* activity names (activity lables).

2.2 Processing data
---

Processing data done inside of method process_data_frames(). This method will do next operations:
* join test_data_frame and train_data_frame to one big set;
* filter values inside of result set.

Filtering will be done in next way:
If any value in column is lover then (mean - standartDiviation) or greater then (mean + standartDiviation) it will be replaced with NA.

3. Generating tidy data frame
=============================

Tidy data frame generation is done by method generate_tidy(). Tidy data frames building have next steps:
1. Create separated data.frame for each activity;
2. In each activity data frame average for all features will be calculated;
3. Join all activity data frame to one tidy data frame.

4. Results varibles in workspace
================================

Script will create next data.frames inside of workspace after runing:
* tidy;
* total_data_frame_filtered;
* total_data_frame;
* train_data_frame;
* test_data_frame.