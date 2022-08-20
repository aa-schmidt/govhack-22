# Combine occupation by lga with grants ----
# Narrow occupation to just the demo data
occupation_lga <- occupation_lga[grepl("Moreton", occupation_lga$lga_ur)
                                 , c("lga_ur", "ICT Professionals", "prop_ict_professionals"
                                     , "supply")]


# Combine using recycling. Different format may need to be applied with more than one LGA
data <- merge(occupation_lga[, c("lga_ur", "supply")], qgip_grants, by.x = "lga_ur", by.y = "lga"
              , all = T)


# Combine with location area ----



# Export for demo website ----
write.csv(data, "./demo data.csv", row.names = F)
