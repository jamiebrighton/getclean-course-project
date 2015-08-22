## load dplyr package
library(dplyr)

import_data <- function(datatype) {
        ## First determine names and positions of columns to keep from the test
        ## and training data as this will be applied to both sets of data after
        ## it is loaded in to R
        ## Load col names from features.txt
        column_Names <<- read.table("./data/features.txt", 
                                    header=FALSE, sep=" ")
        list_Names <<- column_Names[,2]
        
        ## Determine which columns to keep based on the names containing
        ## -mean() and -std()
        to_match <<- c("-mean\\(\\)","-std\\(\\)")
        keep_cols <<- grep(paste(to_match, collapse="|"),list_Names)
        
        ## Load test data
        X <<- read.table(paste("./data/",datatype,"/X_",datatype,".txt",sep=""),header=FALSE)
        subject <<- read.table(paste("./data/",datatype,"/subject_",datatype,".txt",sep=""),header=FALSE)
        y <<-read.table(paste("./data/",datatype,"/y_",datatype,".txt",sep=""),header=FALSE)
        
        ## Set subject and activity_type column names to avoid
        ## column name collisions
        subject <<- rename(subject, subject=V1)
        y <<- rename(y, activity_type=V1)
        y <<- select(y, activity_type)
        
        ## Remove unwanted columns
        X <<- select(X, keep_cols)
        
        ## Set descriptive names of remaining columns in test data
        colnames(X) <<- list_Names[keep_cols]
        
        ## Combine test datasets and set
        output <<- cbind(y, subject)
        output <<- cbind(output, X)
        
        output <<- tbl_df(output)
        
        return(output)
        
}


run_analysis <- function() {
        ## Load the data in to R, filter and combine
        
        ## Use import function to load test and training data
        test_data <<- import_data("test")
        train_data <<- import_data("train")
        
        ## combine test and training data
        total_data <<- rbind(test_data, train_data)
        
        ## Write in descriptive activity names
        ## Load activity names from activity_labels.txt
        activity_names <<- read.table("./data/activity_labels.txt",header=FALSE)
        
        total_data <<- total_data %>%
                merge(activity_names, by.x="activity_type",
                    by.y="V1",all=TRUE) %>%
                select(V2,subject:`fBodyBodyGyroJerkMag-std()`) %>%
                rename(activity_type=V2)
        
        
        
        ## Create second tidy data set with summary(the average of each variable
        ## for each activity and each subject.
        tidy_data <<- total_data %>% 
                group_by(activity_type, subject) %>%
                summarise_each(funs(mean))
        
        return(tidy_data)
                
}

