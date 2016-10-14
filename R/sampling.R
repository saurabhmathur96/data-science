# Random Sampling
# Assuming rating to be a continuous variable.
library("RPostgreSQL")
library("lubridate")

DBNAME = "netflix"

con = dbConnect(dbDriver("PostgreSQL"), 
                dbname=DBNAME, 
                user="postgres", 
                password="pass", 
                host="localhost", port=5432)

# take 9 samples each of 1% of rows
samples = list()
query = "select * from ratings tablesample bernoulli(1);"
for (i in 1:9) {
  df = dbGetQuery(con, query)
  samples[[i]] = df
}

# plot distribution of each sample of ratings
par(mfrow=c(3,3))
for (i in 1:9) {
  hist(samples[[i]]$rating, main=paste("sample ", i), xlab = "Ratings")
}




f.and.t.test = function (x, y) {
  var.test.result = var.test(x, y)
  num.df = var.test.result$parameter[["num df"]]
  denom.df = var.test.result$parameter[["denom df"]]
  f.value = var.test.result$statistic[["F"]]
  
  var.equal = qf(0.95, num.df, denom.df) >= f.value
  
  t.test.result = t.test(x, y, var.equal = var.equal)
  t.value = t.test.result$statistic[["t"]]
  df = t.test.result$parameter[["df"]]
  qt(0.975, df) >= t.value
  
  
}

# check equality of means in samples
results = list()
for (i in 1:9) {
  r = list()
  for (j in 1:9) {
    if (i == j) next
    r[[j]] = f.and.t.test(samples[[i]]$rating, samples[[j]]$rating)

  }
  results[[i]] = r
}

print (results)


