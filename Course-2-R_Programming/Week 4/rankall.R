rankall <- function(outcome, num = "best") {
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
  if (!outcome %in% ot_list) stop("invalid outcome")
  
  ## For each state, find the hospital of the given rank
  else{
    dt <- dt[,c(2,7,ot_clm)]
    names(dt) = c("Hospital","State","Deaths")
    
    ##converting Deaths column to numeric from character
    dt[, 3] = suppressWarnings( as.numeric(dt[, 3]) ) 
    
    dt <-  dt[!is.na(dt$Deaths),] #removing NAs
    
    ##Ordering dataset first by State then by Deaths and last by Hospital name
    dt <- dt[order(dt$State,dt$Deaths,dt$Hospital),] 
    
    
    ##Grouping dataset "dt" by States and then subsetting on the basis of "best",
    ##"worst" or any given rank
    dt <- aggregate(dt, by=list(dt$State), function(x){
      if(num=="best"){
        return(x[1]) 
      }else if (num=="worst"){
        return(x[length(x)])
      }else {
        return(x[num])
      }
    })
  }
  
  dt <- dt[,c(2,3)]
 
  ## Return a data frame with the hospital names and the
  ## (abbreviated) state name
  return(dt)
}

#Test
tail(rankall("Heart Failure"), 10)
head(rankall("Heart Attack", 20), 10)

r <- rankall("Heart Attack", 4)
as.character(subset(r, State == "HI")$Hospital)


r <- rankall("Pneumonia", "worst")
as.character(subset(r, State == "NJ")$Hospital)

r <- rankall("Heart Failure", 10)
as.character(subset(r, State == "NV")$Hospital)