#import dpylr to do data mutation
#install.packages("dplyr")
#library(dplyr)
library(stringi)

#set working directory
setwd("/home/erich/Documents/Govhack22/govhack-22/data")

#load concordance dataset
concordance <- read.csv("./Place Names Concordance 2021.csv")

# get a subset of the concordance dataset that links suburb with LGA area
suburbs_LGA <- concordance[,c("Suburb..2020.","LGA.name..2020.")]

#remove the duplicates
suburbs_LGA <- suburbs_LGA[!duplicated((suburbs_LGA)),]

#load neighborhood centres dataset
neighborhood_centres <- read.csv("./neighbourhood-centres.csv")

#change these to upper case instead of capitalise
neighborhood_centres$Suburb <- stri_trans_totitle(neighborhood_centres$Suburb)

#fix a mispelled suburb
neighborhood_centres$Suburb <- replace(neighborhood_centres$Suburb, neighborhood_centres$Suburb=="Acacia  Ridge","Acacia Ridge")

#fix a mispelled suburb
neighborhood_centres$Suburb <- replace(neighborhood_centres$Suburb, neighborhood_centres$Suburb=="Luywyche","Lutwyche")

#fix a mispelled suburb
neighborhood_centres$Suburb <- replace(neighborhood_centres$Suburb, neighborhood_centres$Suburb=="Mt Isa","Mount Isa")

#fix a mispelled suburb
neighborhood_centres$Suburb <- replace(neighborhood_centres$Suburb, neighborhood_centres$Suburb=="Lissner","Charters Towers City")

#neighborhood_centres$Suburb["Acacia  Ridge"] = "Acacia Ridge"

#make into a data frame
#suburbs_LGA <- as.data.frame(suburbs_LGA)

#loop over neighborhood centres and enter the equivalent LGA from the suburbs_LGA dataset
# for(i in 1:nrow(neighborhood_centres))
# {
#   browser()
#   neighborhood_centres$LGA[i] <- suburbs_LGA$LGA.name..2020.[
#     suburbs_LGA$Suburb..2020. == neighborhood_centres$Suburb[i]
#     ]
# }

#update LGA to suburb MOST IMPORTANT LINE
neighborhood_centres$LGA <- suburbs_LGA$LGA.name..2020.[match(neighborhood_centres$Suburb, suburbs_LGA$Suburb..2020.)]

#update a specific value to fix an anomaly
neighborhood_centres$LGA[neighborhood_centres$Suburb=="Gladstone"] <- "Gladstone (R)"



#restrict the dataset to make it easier for an anomaly check
#suburbs_LGA <- subset(suburbs_LGA, suburbs_LGA$LGA.name..2020.=="Charters Towers (R)")

#restrict the dataset to make it easier for an anomaly check
#suburbs_LGA <- subset(suburbs_LGA, substring(suburbs_LGA$Suburb..2020.,0,1)=="G")

#restrict the dataset to make it easier for an anomaly check
#suburbs_LGA <- subset(suburbs_LGA, suburbs_LGA$LGA.name..2020.=="Gladstone (R)")
