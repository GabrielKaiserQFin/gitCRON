library(pdftools)
library(data.table)

extractDates <- function(pdf2fetch, firstLevel, secondLevel) {browser()
  #get pdf
  text <- pdf_text(pdf = pdf2fetch)
  text <- strsplit(text, split = "\n")
  text <- strsplit(text[[1]], split = "\r")
  
  index <- grep(firstLevel, text) #get positions
  index <- c(index+1,index+2) #dates are in the +1 and +2 index
  dates <- text[index]
  index <- sapply(secondLevel, grep, dates) #get positions
  dates <- gsub('[[:punct:]]', '', dates)
  for(i in secondLevel) {
    dates <- gsub(i, '', dates)
  }
  dates <- trimws(dates)
  dates <- gsub('^o', '', dates)
  dates <- trimws(dates)
  dates <- as.character(as.Date(dates, "%B %d %Y"))
  dates <- apply(index, 2, function(i) dates[i])
  return(dates)
}
 


#get Review Dates
pdf2fetch <- "https://www.msci.com/eqb/pressreleases/archive/ir_dates.pdf"
QIRdates <- extractDates(pdf2fetch,'Quarterly Index Review', c('Announcement date', 'Effective date'))
SAIRdates <- extractDates(pdf2fetch,'Semi-Annual Index Review', c('Announcement date', 'Effective date'))
data.table::melt(QIRdates, )
pdf2fetch <- 'https://app2.msci.com/eqb/gimi/stdindex/MSCI_Nov20_STPublicList.pdf'
indexReviews <- extractDates(pdf2fetch,'Quarterly Index Review', c('Announcement date', 'Effective date'))
text <- pdf_text(pdf =)

library(RCurl)
url2fetch <- 'https://www.msci.com/quarterly-index-review'

url_content <- getURL(url2fetch)

#HTML
url2fetch <- 'https://www.msci.com/eqb/pressreleases/archive/pr000700.html'
thepage = readLines(url2fetch)



library("jsonlite")


library(RCurl)
url2fetch <- 'https://www.boerse-frankfurt.de/etf/ishares-global-clean-energy-ucits-etf-usd-dist'
tmp <- tempfile()
download.file(url2fetch, destfile =tmp,quiet = FALSE, mode = "w")
wb <- jsonlite::fromJSON(tmp)
json = fromJSON(url2fetch)
url_content <- getURL(url2fetch, ssl.verifypeer = FALSE)
#HTML
url2fetch <- 'https://www.msci.com/eqb/pressreleases/archive/pr000700.html'
thepage = readLines(url2fetch)
write.csv(thepage, file='test.txt')


library(rvest)


# rvest tutorial - extract data from website using r
src <- "https://en.wikipedia.org/wiki/List_of_largest_employers_in_the_United_States"

# rvest web scraping - get the page
page <- read_html(url2fetch)

# rvest html table - use html_nodes to parse html in r
# rvest html_nodes will grab all tables here; you must filter later
# html_table converts to data frame
employers <- page %>%
  html_nodes("table") %>%
  .[5] %>%
  html_table(fill = T)

# select specific table for final output
employers <- employers[[1]]
