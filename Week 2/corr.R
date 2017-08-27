corr <- function(directory,threshold=0)
{
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'threshold' is a numeric vector of length 1 indicating the
  ## number of completely observed observations (on all
  ## variables) required to compute the correlation between
  ## nitrate and sulfate; the default is 0
  
  ## Return a numeric vector of correlations
  
  ##Getting all file names in folder specdata
  file_names <- list.files(directory,full.names = T)
  
  ##creating empty numeric vector to hold final result
  t_data <- vector(mode="numeric",length = 0)
  
  
  for (i in 1:length(file_names))
  {
    dt <- read.csv(file_names[i]) ##Getting all data in single dataframe
    
    ## getting total no. of non NA rows for cheking whether 
    ## correlation needs to be calculated or not
    cnt <- sum(complete.cases(dt)) 
    if (cnt>threshold)
    {
      tmp <- dt[which(!is.na(dt$sulfate)), ]
      tmp <- tmp[which(!is.na(tmp$nitrate)), ]
      t_data <- c(t_data,cor(tmp$sulfate, tmp$nitrate)) ## calculating correlation
    }
    
  }
  t_data
}

#Test
cr <- corr("specdata", 150)
head(cr)
