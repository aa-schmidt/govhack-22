# Format 2016 sub-major occupation data ----
# Check structure for identifying what updates are required
str(occupation_lga)

# Remove empty col
all(is.na(occupation_lga$x))
occupation_lga$x <- NULL

# Is counting var all the same value?
unique(occupation_lga$counting)

# Looking at the structure of the data will need to transform into a wide dataframe to get counts 
# by LGA. Add sub-major to vars since it will be easier to get proportions for area. Remove 
# unnecessary vars (counting)
setDT(occupation_lga)
occupation_lga <- dcast(occupation_lga, lga_ur ~ occp_2_digit_level, value.var = "count")
# Confirm new data structure to make sure that transformation will allow us to get a proportion of
# counted occupations in area.
str(occupation_lga)


# Classify 2016 current skill supply ----
# Check the total in the columns is the total for the LGA
setDF(occupation_lga)
matching_totals <- rowSums(occupation_lga[, !grepl("Total|\\blga", names(occupation_lga))]) == 
      occupation_lga$Total
occupation_lga[matching_totals, c("lga_ur", "Total")]
# 3 totals match - they look like larger areas. This probably has something to do with 
# de-identifying counts. 


# Get the proportion of ICT professionals in the area. ICT is the sub-major group of interest in 
# this proposal
occupation_lga$prop_ict_professionals <- occupation_lga$`ICT Professionals`/occupation_lga$Total
occupation_lga[grepl("Moreton", occupation_lga$lga_ur), ]


# Use quantile information to classify
quantile(occupation_lga$prop_ict_professionals)
# Data positively skewed. Will need to create following labels:
  # - low < 50%
  # - medium >= 50% - < 75%
  # - high >= 75%
occupation_lga$supply <- NA
occupation_lga$supply[occupation_lga$prop_ict_professionals < quantile(occupation_lga$prop_ict_professionals)[3]] <- "Low supply"
occupation_lga$supply[occupation_lga$prop_ict_professionals >= 
                        quantile(occupation_lga$prop_ict_professionals)[3] & 
                      occupation_lga$prop_ict_professionals < quantile(occupation_lga$prop_ict_professionals)[4]
                        ] <- "Medium supply"
occupation_lga$supply[occupation_lga$prop_ict_professionals >= quantile(occupation_lga$prop_ict_professionals)[4]] <- "High supply"

# Confirm assignment
table(occupation_lga$supply, useNA = "ifany")
