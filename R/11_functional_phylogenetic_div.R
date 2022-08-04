comm <- read.csv("data/raw/cestes/comm.csv")
traits <- read.csv("data/raw/cestes/traits.csv")

rownames(comm) <- paste0("Site", comm[,1])
comm <- comm[,-1]
head(comm)[,1:6]

rownames(traits) <- paste0(traits[,1])
traits <- traits[,-1]
head(traits)[,1:6]

# species richness

library(vegan)
richness <- vegan::specnumber(comm)

# taxonomic diversity
# Taxonomic measures can be calculated using diversity() function:

shannon <- vegan::diversity(comm)
simpson <- vegan::diversity(comm, index = "simpson")

# functional diversity
# Gower distance

library(cluster)
install.packages("FD")
library(FD)
gow <- cluster::daisy(traits, metric = "gower")
gow2 <- FD::gowdis(traits)
identical(gow, gow2)

class(gow)
class(gow2)

plot(gow, gow2, asp = 1)

# rao's quadratic entropy
install.packages("SYNCSA")
library(SYNCSA)
tax <- rao.diversity(comm)
fun <- rao.diversity(comm, traits = traits)
plot(fun$Simpson, fun$FunRao, pch = 19, asp = 1)
abline(a = 0, b = 1)

# calculating FD indices with package PD
#we can use the distance matrix to calculate functional diversity indices

FuncDiv1 <- dbFD(x = gow, a = comm, messages = F)
#the returned object has Villéger's indices and Rao calculation
names(FuncDiv1)

#We can also do the calculation using the traits matrix directly
FuncDiv <- dbFD(x = traits, a = comm, messages = F)
head(FuncDiv)

splist <- read.csv("data/raw/cestes/splist.csv")
splist$TaxonName
install.packages("taxize")
library(taxize)

classification_data <- classification(splist$TaxonName, db = "ncbi")
head(classification_data)
classification_data[[4]]

library(dplyr)

pull_ex <- classification_data[[1]] %>%
  filter(rank == "family") %>%
  pull(name)

tible_ex <- classification_data[[1]] %>%
  filter(rank == "family") %>%
  select(name) #returns a tible

is(tible_ex)

extract_fam <- function(x) {
  if(!is.null(dim(x))) {
    y <- x %>%
      filter(rank == "family") %>%
      pull(name)
    return(y)
  }
}

extract_fam(classification_data[[4]])

fam_list <- vector()

for (i in 1:length(classification_data)) {
  f <- extract_fam(classification_data[[i]])
  if(length(f) > 0) fam_list[i] <- f
}

unlist(fam_list)
fam_list

fam_in_cestes <- unique(fam_list)

library(ape)
library(phytools)
library(picante)
