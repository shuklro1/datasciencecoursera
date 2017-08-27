best <- function(state, outcome) {
  
  ## Read outcome data
  dt <- read.csv("outcome-of-care-measures.csv",colClasses = "character")
  ot_list <- c("Heart Attack", "Heart Failure", "Pneumonia")
  
  #selectig outcome column from csv file on basis of value of Outcome
  if(outcome == "Heart Attack") {
    ot_clm <- 11
  }else if (outcome == "Heart Failure") {
    ot_clm <- 17
  }else if (outcome == "Pneumonia") {
    ot_clm <- 23}
  
  
  ## Check that state and outcome are valid
  if(!state %in% dt$State) stop("invalid state")
  else if (!outcome %in% ot_list) stop("invalid outcome")
  
  
  ## Return hospital name in that state with lowest 30-day death
  else {
  dt <- dt[dt$State==state,] #filtering data on state
  dt <- dt[,c(2,ot_clm)]     #and outcome column.
  
  names(dt) = c("Hospital","Deaths") #renaming the columns
  
  dt[, 2] = suppressWarnings(as.numeric(dt[, 2])) #converting Deaths column to numeric from character
  dt <-  dt[!is.na(dt$Deaths),] # removing NAs
  
  dt <- dt[order(dt$Deaths,dt$Hospital),]
  dt$Hospital[1]}
}

#Test
x <- best("AK", "Pneumonia")

