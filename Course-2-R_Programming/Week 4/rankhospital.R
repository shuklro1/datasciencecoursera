rankhospital <- function(state, outcome, num = "best") {
  ## Read outcome data
  dt <- read.csv("outcome-of-care-measures.csv",colClasses = "character")
  ot_list <- c("Heart Attack", "Heart Failure", "Pneumonia")
  if(outcome == "Heart Attack") {
    ot_clm <- 11
  }else if (outcome == "Heart Failure") {
    ot_clm <- 17
  }else if (outcome == "Pneumonia") {
    ot_clm <- 23}
  
  ## Check that state and outcome are valid
  if(!state %in% dt$State) stop("invalid state")
  else if (!outcome %in% ot_list) stop("invalid outcome")
  
  
  ## Return hospital name in that state with the given rank
  else {
    dt <- dt[dt$State==state,] #filtering data on state
    dt <- dt[,c(2,ot_clm)]     #and outcome column.
    
    names(dt) = c("Hospital","Deaths") #renaming the columns
    
    dt[, 2] = suppressWarnings(as.numeric(dt[, 2])) #converting Deaths column to numeric from character
    dt <-  dt[!is.na(dt$Deaths),] # removing NAs
    rank <- c(1:length(dt$Hospital)) #creating Rank vector equal to lenght of no. of Hospitals
    
    
    dt <- dt[order(dt$Deaths,dt$Hospital),]
    dt <- cbind(dt,rank) #combining rank with sorted and filtered dataframe "dt"
    
    if(num == "best") {               #checking and returning 
      return(dt$Hospital[min(rank)])  #"best","worst",or any other ranking hospital
    }else if (num == "worst") {       #will return NA if given num is larger 
      return(dt$Hospital[max(rank)])  #than the no. of hospitals in the state
    }else if (num > length(dt$rank)){
      return("NA")
    }else {
      return(dt$Hospital[num])}

  }
}

rankhospital("NY", "Heart Attack", 7)
rankhospital("TX", "Pneumonia", 10)
