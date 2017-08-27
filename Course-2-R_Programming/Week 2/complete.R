complete <- function(directory,id=1:332)
{ ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return a data frame of the form:
  ## id nobs
  ## 1  117
  ## 2  1041
  ## ...
  ## where 'id' is the monitor ID number and 'nobs' is the
  ## number of complete cases
  
  # getting file names for all files in "specdata" folder
  file_names <- list.files(directory,full.names = T) 
  
  t_data <- data.frame() # final data frame
  for (i in id)
  {
    dt <- read.csv(file_names[i]) ##getting all records in a single dataframe
    cnt <- sum(complete.cases(dt)) ##removing observations having NAs
    
    ##adding file num. and no. of observations to that file in single data frame
    temp <- data.frame(i,cnt)  
    
    t_data <- rbind(t_data,temp)
    
  }
  
  colnames(t_data) <- c("id","nobs")
  t_data
}

complete("specdata", 30:25)
