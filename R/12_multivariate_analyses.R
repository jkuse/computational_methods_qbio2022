# multivariate analysis
# dissimilarity metrics: presence have more weight than absence in some measurements
# raw euclidean distance do not work with abundance

# clustering is made upon similarities and dissimilarities
# two large types of cluster used in ecology
# K-means (tell how many groups you want, and arrange species between the number of groups)
# hierarchical clustering (no predefined number of groups)

# linkage functions: average and centroid are most robust

library(vegan)
install.packages("cluster")
library(cluster)
data("dune.env")
dune <- dune.env
remove(dune)
data(dune)
table(dune.env$Management)

# cluster analysis of the dune vegetation
# We calculate two dissimlarity indices between sites: Bray-Curtis distance and Chord distance

bray_distance <- vegdist(dune)

# Chord distance, euclidean distance normalized to 1.
chord_distance <- dist(decostand(dune, "norm"))
is(chord_distance)
norm <- decostand(dune, "norm") # we are taking off the distance part of chord_dist
# because pca doesn't work with distance, only with normalized data
pca <- rda(norm)
plot(pca)
summary(pca)
?rda

b_cluster <- hclust(bray_distance, method = "average")
c_cluster <- hclust(chord_distance, method = "average")

par(mfrow = c(1,2))
plot(b_cluster, xlab="Bray-Curtis Distance")
plot(c_cluster, xlab="Chord Distance")
par(mfrow = c(1,1))

par(mfrow = c(1,2))
plot(b_cluster, hang=-1, main="", axes=F)
axis(2, at=seq(0,1,0.1), labels = seq(0,1,0.1), las = 2)
plot(c_cluster, hang=-1, main="", axes=F)
axis(2, at=seq(0,1,0.1), labels = seq(0,1,0.1), las=2)
par(mfrow = c(1,1))

par(mfrow = c(1,2))
plot(c_cluster, hang=-1, main="", axes=F)
axis(2, at=seq(0,1,0.1), labels = seq(0,1,0.1), las=2)
plot(pca)
par(mfrow = c(1,1))

plot(pca, choices = c(2,3))

# but what are the variables related to this?
# we need to plot a pca of the dune environments

dune.env$Moisture <- as.numeric(dune.env$Moisture)
is.numeric(dune.env$Moisture)
dune.env$Manure <- as.numeric(dune.env$Manure)
is.numeric(dune.env$Manure)

pca_env <- vegan::rda(dune.env[, c("A1","Moisture", "Manure")])
plot(pca_env)

# PCA: ordination technique, or gradient analysis
# PCoA can use Bray-Curtis, PCA don't
# Canonical Correspondence Analysis (CCA) uses a second matrix



