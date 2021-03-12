#load libs

library(tidyverse)
library(rvest)
library(janitor)

library(httr)

# Source R script from Github
script <-
  GET(
    url = paste0("https://api.github.com/repos/", github-actions, "/fincap/src/fcts-old.R"),
    authenticate(github-actions, secrets.GITHUB_TOKEN),     # Instead of PAT, could use password
    accept("application/vnd.github.v3.raw")
  ) %>%
  content(as = "text")

# Evaluate and parse to global environment
eval(parse(text = script))


#nse top gainers

url <- 'https://www.moneycontrol.com/stocks/marketstats/nsegainer/index.php'

# extract html 

url_html <- read_html(url)

#table extraction

url_tables <- url_html %>% html_table(fill = TRUE)

#extract relevant table

top_gainers <- url_tables[[2]]

#extract relevant columns

top_gainers %>%
  select(1:7) -> top_gainers

top_gainers %>% 
  clean_names() -> top_gainers

top_gainers %>%
  filter(!is.na(low)) -> top_gainers

top_gainers %>%
  separate(company_name,
           into = 'company_name',
           sep = '\t') -> top_gainers
           
           
 write_csv(top_gainers,paste0('data/',Sys.Date(),'_top_gainers','.csv'))    
