# Combine occupation by lga with grants ----
# Narrow occupation to just the demo data
occupation_lga <- occupation_lga[grepl("Moreton", occupation_lga$lga_ur)
                                 , c("lga_ur", "ICT.Professionals", "prop_ict_professionals"
                                     , "supply")]


# Combine using recycling. Different format may need to be applied with more than one LGA
data <- merge(occupation_lga[, c("lga_ur", "supply")], qgip_grants, by.x = "lga_ur", by.y = "lga"
              , all = T)


# Combine with location area ----
# Add in the linked neighbourhood centres
neighbourhood_centres <- read.csv("./data/neighborhood_centresv2.csv")

# Add neighbourhood centres to combined data
data2 <- merge(neighbourhood_centres, data, by.x = "LGA", by.y = "lga_ur", all = T)


# Export for demo website ----
write.csv(data2, "./demo data.csv", row.names = F)


# Export for graphs ----
occupation_combined <- occupation_combined[, c("lga", "ICT.Professionals_11", "ICT.Professionals_16", "prop_ict_professionals_11", "prop_ict_professionals_16", "supply_11", "supply_16", "supply_growth")]

write.csv(occupation_combined, "./ict supply growth.csv", row.names = F)
