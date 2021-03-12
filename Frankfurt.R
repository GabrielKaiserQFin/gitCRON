#nse top gainers

url <- 'https://www.boerse-frankfurt.de/equity/deutsche-telekom-ag'

# extract html 

url_html <- read_html(url)

#table extraction

url_tables <- url_html  %>% html_table(fill = TRUE)


