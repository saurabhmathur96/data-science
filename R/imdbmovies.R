library("RPostgreSQL")
library("stringr")
library("lubridate")

DBNAME = "movielens"

con = dbConnect(dbDriver("PostgreSQL"), 
                dbname=DBNAME, 
                user="postgres", 
                password="pass", 
                host="localhost", port=5432)
query = "select * from imdbmovies";
df = dbGetQuery(con, query)


# parse_array = function(x) {
#  as.factor(stringr::str_extract_all(x, pattern = "[a-zA-Z1-9]+", simplify = T))
#}
#spoken_langs =lapply(df$spoken_languages, parse_array)
#langs = unique(unlist(spoken_langs))
#spoken_languages = data.frame()
#for (lang in langs) {
#  spoken_languages[,lang] = lapply(spoken_langs, function(x) { lang %in% x})
#}
