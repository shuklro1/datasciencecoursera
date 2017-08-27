makeCacheMatrix <- function(x = matrix()) {
  # Matrix inversion is usually a costly computation and there may be some benefit
  # to caching the inverse of a matrix rather than compute it repeatedly. The
  # following two functions are used to cache the inverse of a matrix.
  
  # makeCacheMatrix creates a list containing a function to
  # 1. set the value of the matrix (set)
  # 2. get the value of the matrix (get)
  # 3. set the value of inverse of the matrix (setinverse)
  # 4. get the value of inverse of the matrix (getinverse)
  
  m <- NULL  ##variable to hold inverse matrix
  
  set <- function(y) {   
    x <<- y       #assigning the initial matrix to x
    m <<- NULL    #initialy setting the inverse matrix variable to NULL
  }
  get <- function() x  # getting the matrix 
  setinverse <- function(solve) m <<- solve  #inversing the matrix
  getinverse <- function() m # getting inverse matrix
  list(set = set, get = get,       #returning list containing functions to set,get,
       setinverse = setinverse,    #setinverse and getinverse a matrix
       getinverse = getinverse)
  
}



# The following function returns the inverse of the matrix. It first checks if
# the inverse has already been computed. If so, it gets the result and skips the
# computation. If not, it computes the inverse, sets the value in the cache via
# setinverse function.

# This function assumes that the matrix is always invertible.
cacheSolve <- function(x,...) {
  m <- x$getinverse()  ##assigning inverse matrix to m
  
  # checking if inverse matrix already exist return it 
  # along with message "getting cached data"
  if(!is.null(m)) {
    message("getting cached data")
    return(m)
  }
  
  # if inverse matrix doesn't exist calculate it
  data <- x$get()
  m <- solve(data)
  x$setinverse(m,...)
  m
}

#Test
mt <- matrix(c(1,3,4,2,3,6,4,9,8),3,3)
temp <- makeCacheMatrix(mt)
temp
cacheSolve(temp)