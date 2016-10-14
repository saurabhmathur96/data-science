movies = readRDS("/home/saurabh/Documents/download/samples/imdb.movies")
movies.budget = subset(movies$budget, movies$budget > 0)

plot.hist = function(x, main, xlab) {
  par(mar = c(4, 4, 3, 3), 
      bg = "#f0f0f0", 
      col.axis = "#434343", 
      col.main = "#343434", 
      mgp = c(2.1, .3, 0), 
      family = "HersheySans")
  hist(x, 
       main = main, 
       xlab = xlab, 
       ylab = "Density",
       col = "#ababab", 
       ylim = c(0, 4e-08),
       border = F, 
       axes = F, 
       probability = T)
  grid(NULL, NULL, col = "#dedede", lty = "solid", lwd = 0.9)
  lines(density(movies.budget),  col = "#008ed4", type = "l")
  axis(1, tick = F, cex.axis = 0.9)
  axis(2, tick = F, cex.axis = 0.9)
}
plot.hist(movies.budget, main = "Movie Budget", xlab = "Budget in $s")