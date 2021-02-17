#############################################################
## Helper script to support Shiny app
##
##
## Author: Sam Spoerl (sam@samspoerl.com)
## Created: 2021-02-17
#############################################################

library(FinCal)

fv_plot <- function(r, n, pv, pmt){
  x <- c(0:n)
  y <- c()
  for (i in c(0:n)){
    f <- fv(r=r, n=i, pv=pv, pmt=pmt)
    y <- append(y, f)
  }
  xy <- cbind(x, y)
  df <- data.frame(xy)
  names(df)[1] <- "Number of Periods"
  names(df)[2] <- "Future Value"
  return(df)
}

#xy <- fv_plot(0.08, 10, -100, 0)
#print(xy)