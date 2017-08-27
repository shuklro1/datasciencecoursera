pollutantmean <- function(directory,pollutant,id=1:332)
{
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'pollutant' is a character vector of length 1 indicating
  ## the name of the pollutant for which we will calculate the
  ## mean; either "sulfate" or "nitrate".
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return the mean of the pollutant across all monitors list
  ## in the 'id' vector (ignoring NA values)
  
  t_data <- c()
  #Getting file names of all pollutant data files. 
  file_names <- list.files(directory,full.names = T)
  
  for (i in id)
  {
    p_dt <- read.csv(file_names[i]) # reading data
    x <- c(p_dt[[pollutant]]) ##Filtering cummulative data on "Pollutant"
    t_data <- c(t_data,x) #adding filtered data to resultant vector.
  }
  return(mean(t_data,na.rm=T))
  
}

#Test
pollutantmean("specdata","nitrate",70:72) == 1.706047
