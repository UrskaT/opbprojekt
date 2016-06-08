#uvozimo kjižnico

library(XML)

#uvozimo .csv datoteko s podatki

avti <- read.csv2("D:\\ROK\\School - FMF\\3.letnik\\OPB\\Projekt\\uvoz\\output_clean.csv",
                header = FALSE,
                dec = ".",
                fill = TRUE,
                strip.white = TRUE)