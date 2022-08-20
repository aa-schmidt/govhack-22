# Explore grant type availability
lapply(qgip_grants[, c("category", "status", "applicant_type1", "applicant_type2", grep("^client", names(qgip_grants), value = T))], table)

# Identify relevant small business grants
# grants are open (status), not local government (applicant types), or Government
qgip_grants <- qgip_grants[qgip_grants$status %in% "Open" &
                  !qgip_grants$applicant_type1 %in% "Local government" & 
                  !qgip_grants$client_group1 %in% "Government", ]

# Scope of project isn't for apprentices or trainees
qgip_grants <- qgip_grants[!grepl("\\b(appren|trainee)", qgip_grants$eligibility), ]

# Check website for employee eligibility
qgip_grants$website[qgip_grants$client_group1 %in% "Employees"]
# Could be people who are looking to reskill with current employer. Remove if they are the only 
# eligible group
qgip_grants <- 
  qgip_grants[!(qgip_grants$client_group1 %in% "Employees" & 
              rowSums(qgip_grants[, grep("^client_group[2-5]"
                        , names(qgip_grants), value = T)] ==
                        "") == 4)
            , ]
# Drop the columns if they are empty
all(qgip_grants$client_group4 %in% c(NA, ""))
all(qgip_grants$client_group5 %in% c(NA, ""))
all(qgip_grants$client_group6 %in% c(NA, ""))
qgip_grants[, c("client_group4", "client_group5", "client_group6")] <-
  NULL


# Explore eligible variable. Are there criteria based on industry
qgip_grants$eligibility[!qgip_grants$eligibility %in% ""]
# For purpose of example remove those with eligibility requirements - further info needed to make
# correct categorisation
qgip_grants <- qgip_grants[qgip_grants$eligibility %in% "", ]


# Transform dataset so eligible participants are in the one var. Also narrow down to eligible fields
setDT(qgip_grants)
qgip_grants <- melt(qgip_grants
                    , id.vars = c("program_title", "purpose", "website")
                    , measure.vars = c("client_group1", "client_group2", "client_group3"))
# Check dataset structure after the melt to identify unnecessary rows
qgip_grants
# Remove empty rows
qgip_grants <- qgip_grants[!qgip_grants$value %in% "", ]
setDF(qgip_grants)

# Drop vars that won't be displayed on site
head(qgip_grants)
qgip_grants$variable <- NULL 
# Give the category a recognisable name
names(qgip_grants)[names(qgip_grants) %in% "value"] <- "category" 


# Add on the skill level. Only 26 used for demo purposes. 
# Reading through the purpose of the programs they all can broadly be applied to 26
qgip_grants$skill <- 26

# Add on the LGA area - the program description and eligibility doesn't specify location. Moreton Bay for Demo purposes
qgip_grants$lga <- "Moreton Bay (R)"
