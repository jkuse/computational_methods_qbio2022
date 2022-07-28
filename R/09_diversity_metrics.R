# Diversity metrics

library(dplyr)

comm <- read.csv("data/raw/cestes/comm.csv")
dim(comm)
head(comm)

# 1. which are the 5 most abundant species

abund <- colSums(comm[,2:57])
sort(abund, decreasing = TRUE)

# 2. how many species are there in each plot? (Richness)
#first we need to transform data to presence/absence
comm_p_a <- comm[,-1]
comm_p_a[comm_p_a > 0] <- 1

# and now we sum the presence in each row
richness_site <- rowSums(comm_p_a)

# 3. which the species that is most abundant in each plot?
# to have the number of the cell with the must abundant value:
abund_plot <- apply(comm[-1], 1, which.max)
 # but we don't have the information of which specie it is

comm2 <- read.csv("data/raw/cestes/comm.csv", row.names = 1)
?colnames
most_abund_site <- as.data.frame(colnames(comm2)[max.col(comm2, ties.method = "first")])
# ties.method returns the column number of the first of several maxima in every row

# another way to do it
apply(X=comm[,-1], MARGIN=1, FUN=which.max)

max_site <- as.data.frame(apply(comm[,-1], 1, which.max))
