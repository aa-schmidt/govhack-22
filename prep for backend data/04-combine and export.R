# Narrow occupation to just the demo data
# occupation_lga <- occupation_lga[
#   , c("lga_ur", "ICT.Professionals", "prop_ict_professionals"
#       , "supply")]


# Combine with location area ----
# Add in the linked neighbourhood centres
neighbourhood_centres <- read.csv("./data/neighborhood_centresv2.csv")

# Keep just the required vars for the merge
neighbourhood_centres <- neighbourhood_centres[, c("Title", "LGA")]


# Add the eligible grants and supply level for the area
qgip_grants_lga <- data.frame("program_title" = character(0),
                              "purpose" = character(0),
                              "website" = character(0), 
                              "category" = character(0),
                              "skill" = character(0),
                              "lga" = character(0),
                              "supply" = character(0)
                              )
for(lga in unique(neighbourhood_centres$LGA)){
  x <- qgip_grants[, !names(qgip_grants) %in% "lga"]
  x$lga <- lga
  x$supply <- NA
  if(any(occupation_lga$lga_ur %in% lga)){
    x$supply <- occupation_lga$supply[occupation_lga$lga_ur %in% lga]
  }
  qgip_grants_lga <- rbind(x, qgip_grants_lga)
}

# Add neighbourhood centres to combined data
data2 <- merge(neighbourhood_centres, qgip_grants_lga, by.x = "LGA", by.y = "lga", all = T)


# Export for demo website ----
write.csv(data2, "./demo data - all LGA.csv", row.names = F)


# Export for graphs ----
occupation_combined <- occupation_combined[, c("lga", "ICT.Professionals_11", "ICT.Professionals_16", "prop_ict_professionals_11", "prop_ict_professionals_16", "supply_11", "supply_16", "supply_growth")]

write.csv(occupation_combined, "./ict supply growth.csv", row.names = F)
