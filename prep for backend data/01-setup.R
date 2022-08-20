# set up libraries ----
library(data.table)


# import data ----
# Format:
  # Description
  # URL


# QGSO place name concordance
# https://www.qgso.qld.gov.au/geographies-maps/concordances/place-names-concordance-2021


# Neighbourhood and community centres
# https://www.data.qld.gov.au/dataset/neighbourhood-and-community-centres


# DESBT - QLD Gov Investment Portal
# https://www.data.qld.gov.au/dataset/desbt-queensland-government-investment-portal-qgip
# identifying money
qgip_grants <- read.csv("./data/current-program-funding-desbt.csv")
# Check structure to make sure expected fields are there
str(qgip_grants)
# snake_case for ease of reference
names(qgip_grants) <- tolower(gsub("\\.+", "_", names(qgip_grants)))
names(qgip_grants) <- gsub("_$", "", names(qgip_grants))


# 2016 ABS Census Occupation by Age by Sex
# https://www.abs.gov.au/census/find-census-data/datapacks?release=2016&product=GCP&geography=LGA&header=S
# alert for what is in demand
occupation_age_sex_16 <- read.csv("./data/2016Census_G57B_QLD_LGA.csv")
