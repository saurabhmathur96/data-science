library("RPostgreSQL")

DBNAME = "netflix"

con = dbConnect(dbDriver("PostgreSQL"), 
                dbname=DBNAME, 
                user="postgres", 
                password="pass", 
                host="localhost", port=5432)

query = "select * from ratings tablesample bernoulli(25);"
df = dbGetQuery(con, query)

saveRDS(df, file=paste(DBNAME, ".sample"))
