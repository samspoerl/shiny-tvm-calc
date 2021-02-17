#############################################################
## Helper script to support Shiny app
##
##
## Author: Sam Spoerl (sam@samspoerl.com)
## Created: 2021-02-17
#############################################################

library(FinCal)

# Calculate the future value of an investment
# for each period in n periods.
fv_plot <- function(r, n, pv, pmt){
  
  # Vector of periods
  x <- c(0:n)
  
  # Vector of (investment) values
  y <- c()
  
  # For each period in n periods,
  # calculate the future investment value
  for (i in c(0:n)){
    
    # Call fv function from FinCal
    f <- fv(r=r, n=i, pv=pv, pmt=pmt)
    
    # Append value to vector of values
    y <- append(y, f)
  }
  
  # Bind the vectors together
  xy <- cbind(x, y)
  
  # Convert table to dataframe
  df <- data.frame(xy)
  
  # Rename columns
  names(df)[1] <- "Number of Periods"
  names(df)[2] <- "Future Value"
  
  return(df)
}
