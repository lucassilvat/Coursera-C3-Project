  library(dplyr);library(tidyr);library(textclean);library(utils)
  
  ##Downloading data into main directory
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
                destfile="OD.zip",mode = "wb")
  unzip("OD.zip")
  
  ##Reading raw data - Train and Test Set, Activities and Subjects and Features
  
  train.set <- read.table("./UCI HAR Dataset/train/X_train.txt",nrows = 7352, colClasses = numeric())
  test.set <- read.table("./UCI HAR Dataset/test/X_test.txt", nrows=2947, colClasses = numeric())
  
  train.activities <- read.table("./UCI HAR Dataset/train/y_train.txt",nrows=7352)
  test.activities <- read.table("./UCI HAR Dataset/test/y_test.txt",nrows=2947)
  
  train.subjects <- read.table("./UCI HAR Dataset/train/subject_train.txt",nrows=7352)
  test.subjects <- read.table("./UCI HAR Dataset/test/subject_test.txt",nrows=2947)
  
  features.names <- read.table("./UCI HAR Dataset/features.txt")
  
  ##Merging Activities and Subjects to Sets
  
  train.set <- train.set %>% mutate(train.activities[,1]) %>% mutate(train.subjects[,1])
  test.set <- test.set %>% mutate(test.activities[,1]) %>% mutate(test.subjects[,1])
  
  ##Adding Activity and Subject to Feature
  
  features.names.vec <- as.vector(features.names[,2])
  features.names.vec <- c(features.names.vec,"Activities","Subjects")
  rm(features.names,train.subjects,train.activities,test.subjects,test.activities)
  
  ##Renaming collumns in Train and Test sets
  names(train.set) <- features.names.vec
  names(test.set) <- features.names.vec
  
  ##Merging them and them dumping them
  dataset <- rbind(train.set,test.set)
  rm(test.set,train.set)
  
  ##Finding "mean()" and "std()" in collumn names
  find.vec <- grepl("mean\\(\\)|std\\(\\)",names(dataset),ignore.case = TRUE)
  find.vec[(length(find.vec)-1):length(find.vec)] <- c(TRUE,TRUE)
  
  ##Removing unwanted collumns
  dataset.subset <- dataset[,find.vec]
  
  ##Reading activities labels
  activities.labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
  
  ##Labelling activities in dataset
  dataset.subset$Activities <- mgsub(dataset.subset$Activities,activities.labels[,1],activities.labels[,2])
  
  ##Transforming dataframe into tibble and grouping by activities and subjects
  dataset.subset <- tbl_df(dataset.subset)
  dataset.subset <- group_by(dataset.subset,Activities,Subjects)
  
  ##Output tidy_data that contains means of variables based on grouping
  tidy.data <- dataset.subset %>% summarise_at(1:(ncol(.)-2),mean)
  
  ##Renaming variables to append "mean" to the end of their names
  var.names <- names(tidy.data)[3:ncol(tidy.data)]
  names(tidy.data)[3:ncol(tidy.data)] <- paste(var.names,"mean",sep="-")
  
  tidy.data
  