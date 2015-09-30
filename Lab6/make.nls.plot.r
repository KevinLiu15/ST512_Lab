make.nls.plot <- function(th1,th2,th3){
  
  plot(y~x,data=optics) # this command assumes that the data frame 'optics' is stored in memory
  
  # create a vector of length 100 that spans the range of the x values in 'optics'
  x.values <- seq(from=min(optics$x),to=max(optics$x),length=100)   
  
  # calculate y values for a three-parameter exponential function
  y.values <- th1 + th2 * exp(-th3 * x.values)
  
  # add a line to the plot
  lines(x.values, y.values)
  
}
