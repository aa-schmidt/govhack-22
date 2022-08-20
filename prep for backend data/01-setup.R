# set up libraries ----
library(data.table)


# import data ----
# Format:
  # Description
  # URL


# QGSO place name concordance
# https://www.qgso.qld.gov.au/geographies-maps/concordances/place-names-concordance-2021
concordance <- read.csv("./data/Place Names Concordance 2021.csv")

# Neighbourhood and community centres
# https://www.data.qld.gov.au/dataset/neighbourhood-and-community-centres
neighbourhood_centres <- read.csv("./data/neighbourhood-centres.csv")


# DESBT - QLD Gov Investment Portal
# https://www.data.qld.gov.au/dataset/desbt-queensland-government-investment-portal-qgip
# identifying money
qgip_grants <- read.csv("./data/current-program-funding-desbt.csv")
# Check structure to make sure expected fields are there
str(qgip_grants)
# snake_case for ease of reference
names(qgip_grants) <- tolower(gsub("\\.+", "_", names(qgip_grants)))
names(qgip_grants) <- gsub("_$", "", names(qgip_grants))


# 2016 ABS census Sub-major occupation by LGA
# Table Builder
# Skip over the table metadata and extract the structured data
occupation_lga <- read.csv("./data/table_2022-08-20_21-26-58.csv", skip = 9)
# Check correct fields have been skipped
str(occupation_lga)
# Looks like there are slightly more rows (4112 in import vs 4108 in csv)
tail(occupation_lga)
# Info and table source attached. Info about small cells is good to note. May need to remove some
# counts
# Remove additional table info - tail shows that count is missing for this
occupation_lga <- occupation_lga[!is.na(occupation_lga$Count), ]

# Update names for easy reference
names(occupation_lga) <- tolower(gsub("\\.+", "_", names(occupation_lga)))
names(occupation_lga) <- tolower(gsub("_$", "", names(occupation_lga)))

# Will update format of data in occupation step


# 2011 ABS census sub-major occupation by LGA
# Table builder
occupation_11_lga <- read.csv("./data/table_2022-08-21_00-21-14.csv", skip = 9)
# Check correct fields have been skipped
str(occupation_11_lga)
# Can remove LGA row. Check for table metadata
tail(occupation_11_lga)
# Info and table source attached. Info about small cells is good to note. May need to remove some
# counts
# Remove additional table info - tail and str show that 2:76 is data range
occupation_11_lga <- occupation_11_lga[2:76, ]

# Update names for easy reference
names(occupation_11_lga)[names(occupation_11_lga) %in% "OCCP...2.Digit.Level"] <- "lga"
